import build


def make_layout(tmp_path, monkeypatch, with_edited=True, with_new=True):
    game, edit, new, modded = tmp_path / "game", tmp_path / "edited", tmp_path / "new", tmp_path / "modded"
    game.mkdir()
    edit.mkdir()
    new.mkdir()
    (game / "data.win").write_bytes(b"win")
    if with_edited:
        (edit / "gml_Object_a_Create_0.gml").write_text("x")
    if with_new:
        (new / "gml_Script_added.gml").write_text("z")
    paths = {
        "ROOT": tmp_path,
        "GAME_DIR": game,
        "EDIT_DIR": edit,
        "NEW_DIR": new,
        "MODDED_DIR": modded,
        "MODDED_SAVE_DIR": modded / "save",
        "SAVE_TEMPLATE": tmp_path / "template" / "game.sav",
    }
    for name, value in paths.items():
        monkeypatch.setattr(build, name, value)
    monkeypatch.setattr("setup.ROOT", tmp_path)
    monkeypatch.setattr("setup.GAME_FILE_WHITELIST", ["data.win"])
    return game, edit, modded


def test_main_copies_game_files_then_imports(tmp_path, monkeypatch):
    game, edit, modded = make_layout(tmp_path, monkeypatch)
    calls = []
    monkeypatch.setattr(build, "import_code", lambda *args: calls.append(args) or True)

    assert build.main([]) == 0

    assert (modded / "data.win").read_bytes() == b"win"
    assert (modded / "steam_appid.txt").read_text() == build.STEAM_APP_ID
    assert calls == [(game / "data.win", edit, modded / "data.win", build.NEW_DIR)]


def test_main_keeps_the_current_save_by_default(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: True)
    build.SAVE_TEMPLATE.parent.mkdir()
    build.SAVE_TEMPLATE.write_text("template")
    (modded / "save").mkdir(parents=True)
    (modded / "save" / "game.sav").write_text("mine")

    assert build.main([]) == 0

    assert (modded / "save" / "game.sav").read_text() == "mine"


def test_main_fresh_save_replaces_the_save_with_the_template(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: True)
    build.SAVE_TEMPLATE.parent.mkdir()
    build.SAVE_TEMPLATE.write_text("template")
    (modded / "save").mkdir(parents=True)
    (modded / "save" / "game.sav").write_text("mine")

    assert build.main(["--fresh-save"]) == 0

    assert (modded / "save" / "game.sav").read_text() == "template"


def test_main_fresh_save_needs_the_template(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch)

    assert build.main(["--fresh-save"]) == 1
    assert not modded.exists()


def test_find_duplicates_searches_subfolders_ignoring_case(tmp_path):
    (tmp_path / "a" / "b").mkdir(parents=True)
    (tmp_path / "x.gml").write_text("1")
    (tmp_path / "a" / "X.gml").write_text("2")
    (tmp_path / "a" / "b" / "x.gml").write_text("3")
    (tmp_path / "a" / "y.gml").write_text("4")

    duplicates = build.find_duplicates(tmp_path)

    assert list(duplicates) == ["x.gml"]
    assert len(duplicates["x.gml"]) == 3


def test_main_fails_and_names_duplicates(tmp_path, monkeypatch, capsys):
    _, edit, modded = make_layout(tmp_path, monkeypatch)
    (edit / "current").mkdir()
    (edit / "current" / "gml_Object_a_Create_0.gml").write_text("y")
    monkeypatch.setattr(build, "import_code", lambda *args: True)

    assert build.main([]) == 1

    out = capsys.readouterr().out
    assert "edited" in out and "current" in out and "gml_Object_a_Create_0.gml" in out
    assert not modded.exists()


def test_main_accepts_files_in_subfolders_of_both_folders(tmp_path, monkeypatch):
    _, edit, _ = make_layout(tmp_path, monkeypatch, with_edited=False, with_new=False)
    (edit / "current").mkdir()
    (edit / "current" / "gml_Object_b_Create_0.gml").write_text("y")
    (build.NEW_DIR / "sub").mkdir()
    (build.NEW_DIR / "sub" / "gml_Script_added.gml").write_text("z")
    monkeypatch.setattr(build, "import_code", lambda *args: True)

    assert build.main([]) == 0


def test_main_accepts_an_empty_edited_folder(tmp_path, monkeypatch):
    make_layout(tmp_path, monkeypatch, with_edited=False)
    monkeypatch.setattr(build, "import_code", lambda *args: True)

    assert build.main([]) == 0


def test_main_fails_on_a_name_in_both_edited_and_new(tmp_path, monkeypatch, capsys):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    (build.NEW_DIR / "gml_Object_a_Create_0.gml").write_text("z")
    monkeypatch.setattr(build, "import_code", lambda *args: True)

    assert build.main([]) == 1

    out = capsys.readouterr().out
    assert "edited" in out and "new" in out and "gml_Object_a_Create_0.gml" in out
    assert not modded.exists()


def test_main_skips_the_new_folder_without_gml(tmp_path, monkeypatch):
    game, edit, modded = make_layout(tmp_path, monkeypatch, with_new=False)
    calls = []
    monkeypatch.setattr(build, "import_code", lambda *args: calls.append(args) or True)

    assert build.main([]) == 0

    assert calls == [(game / "data.win", edit, modded / "data.win", None)]


def test_main_skips_a_missing_new_folder(tmp_path, monkeypatch):
    game, edit, modded = make_layout(tmp_path, monkeypatch)
    (build.NEW_DIR / "gml_Script_added.gml").unlink()
    build.NEW_DIR.rmdir()
    calls = []
    monkeypatch.setattr(build, "import_code", lambda *args: calls.append(args) or True)

    assert build.main([]) == 0

    assert calls == [(game / "data.win", edit, modded / "data.win", None)]


def test_main_fails_without_any_gml(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch, with_edited=False, with_new=False)

    assert build.main([]) == 1
    assert not modded.exists()


def test_main_fails_without_game_data(tmp_path, monkeypatch):
    game, _, modded = make_layout(tmp_path, monkeypatch)
    (game / "data.win").unlink()

    assert build.main([]) == 1
    assert not modded.exists()


def test_main_propagates_import_failure(tmp_path, monkeypatch):
    make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: False)

    assert build.main([]) == 1


def test_import_code_needs_the_cli(tmp_path, monkeypatch):
    monkeypatch.setattr(build, "ROOT", tmp_path)
    monkeypatch.setattr(build, "UTMT_CLI_DIR", tmp_path / "missing")

    assert build.import_code(tmp_path / "data.win", tmp_path / "edited", tmp_path / "out.win", tmp_path / "new") is False
