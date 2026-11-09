import diff_edit
from diff_edit import diff_file, summarize


def patch_dirs(tmp_path, monkeypatch):
    extract, edit = make_dirs(tmp_path)
    monkeypatch.setattr(diff_edit, "ROOT", tmp_path)
    monkeypatch.setattr(diff_edit, "EXTRACT_DIR", extract)
    monkeypatch.setattr(diff_edit, "EDIT_DIR", edit)
    monkeypatch.setattr(diff_edit, "DIFF_LOG_DIR", tmp_path / "logs")
    return extract, edit


def test_main_finds_originals_for_files_in_subfolders(tmp_path, monkeypatch, capsys):
    extract, edit = patch_dirs(tmp_path, monkeypatch)
    (edit / "current" / "steam").mkdir(parents=True)
    (extract / "a.gml").write_text("one\ntwo\n")
    (edit / "current" / "steam" / "a.gml").write_text("one\n2\n")
    (edit / "current" / "steam" / "notes.txt").write_text("ignored")

    assert diff_edit.main([]) == 0

    assert "current/steam/a.gml: +1 -1" in capsys.readouterr().out
    log = (tmp_path / "logs" / "a.diff").read_text()
    assert "--- extract/a.gml" in log and "+2\n" in log
    assert not (tmp_path / "logs" / "notes.diff").exists()


def test_main_fails_on_duplicate_names(tmp_path, monkeypatch, capsys):
    _, edit = patch_dirs(tmp_path, monkeypatch)
    (edit / "x").mkdir()
    (edit / "a.gml").write_text("1")
    (edit / "x" / "a.gml").write_text("2")

    assert diff_edit.main([]) == 1

    out = capsys.readouterr().out
    assert "edit" in out and "a.gml" in out
    assert not (tmp_path / "logs").exists()


def make_dirs(tmp_path):
    extract, edit = tmp_path / "extract", tmp_path / "edit"
    extract.mkdir()
    edit.mkdir()
    return extract, edit


def test_changed_file_is_diffed(tmp_path):
    extract, edit = make_dirs(tmp_path)
    (extract / "a.gml").write_text("one\ntwo\n")
    (edit / "a.gml").write_text("one\n2\n")

    lines = diff_file(extract / "a.gml", edit / "a.gml", "a.gml")

    assert "-two\n" in lines and "+2\n" in lines
    assert summarize(extract / "a.gml", lines) == "+1 -1"


def test_common_lines_in_long_files_are_not_reported(tmp_path):
    # difflib's autojunk treats the repeated blank lines as junk
    extract, edit = make_dirs(tmp_path)
    old = "".join(f"line{i}\n    \n" for i in range(150))
    (extract / "a.gml").write_text(old)
    (edit / "a.gml").write_text(old.replace("line75\n", "changed\n"))

    lines = diff_file(extract / "a.gml", edit / "a.gml", "a.gml")

    assert summarize(extract / "a.gml", lines) == "+1 -1"


def test_unchanged_and_new_files(tmp_path):
    extract, edit = make_dirs(tmp_path)
    (extract / "same.gml").write_text("x\n")
    (edit / "same.gml").write_text("x\n")
    (edit / "new.gml").write_text("y")

    same = diff_file(extract / "same.gml", edit / "same.gml", "same.gml")
    new = diff_file(extract / "new.gml", edit / "new.gml", "new.gml")

    assert summarize(extract / "same.gml", same) == "unchanged (can be removed from _edited)"
    assert summarize(extract / "new.gml", new) == "new file"
    assert "+y\n" in new
