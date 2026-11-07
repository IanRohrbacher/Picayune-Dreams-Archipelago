from diff_edit import diff_file, summarize


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
