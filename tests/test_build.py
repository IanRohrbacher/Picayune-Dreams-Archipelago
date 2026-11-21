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
        "USER_SAVE_DIR": tmp_path / "user_save",
        "INIT_GML": tmp_path / "init.gml",
        "GM_APCLIENT_DIR": tmp_path / "apclient",
    }
    (tmp_path / "init.gml").write_text('global.gm_apclientpp_version = "v1.0.0";\n')
    (tmp_path / "apclient" / "v1.0.0").mkdir(parents=True)
    (tmp_path / "apclient" / "v1.0.0" / "gm-apclientpp.dll").write_bytes(b"dll-1")
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
    (modded / "save").mkdir(parents=True)
    (modded / "save" / "game.sav").write_text("mine")

    assert build.main([]) == 0

    assert (modded / "save" / "game.sav").read_text() == "mine"


def test_main_fresh_save_deletes_the_whole_save_folder(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: True)
    (modded / "save" / "slots").mkdir(parents=True)
    (modded / "save" / "game.sav").write_text("mine")
    (modded / "save" / "slots" / "a.sav").write_text("slot")

    assert build.main(["--fresh-save"]) == 0

    assert not (modded / "save").exists()
    assert (modded / "data.win").is_file()


def test_main_fresh_save_without_a_save_folder_still_builds(tmp_path, monkeypatch):
    make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: True)

    assert build.main(["--fresh-save"]) == 0


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


def test_rooms_are_added_before_code_is_imported_and_linked_after():
    names = [script.name for script in build.BUILD_SCRIPTS]

    assert names == ["add_rooms.csx", "import_code.csx", "link_room_code.csx"]
    assert all(script.is_file() for script in build.BUILD_SCRIPTS)


def test_import_code_passes_every_script_to_the_cli(tmp_path, monkeypatch):
    (tmp_path / "UndertaleModCli.exe").write_bytes(b"")
    monkeypatch.setattr(build, "ROOT", tmp_path)
    monkeypatch.setattr(build, "UTMT_CLI_DIR", tmp_path)
    calls = []
    monkeypatch.setattr(build.subprocess, "run", lambda args, env: calls.append((args, env)) or build.subprocess.CompletedProcess(args, 0))

    assert build.import_code(tmp_path / "data.win", tmp_path / "edited", tmp_path / "out.win") is True

    args, env = calls[0]
    scripts = [args[i + 1].name for i, arg in enumerate(args) if arg == "--scripts"]
    assert scripts == ["add_rooms.csx", "import_code.csx", "link_room_code.csx"]
    assert "PDA_NEW_DIR" not in env


def test_import_code_needs_the_cli(tmp_path, monkeypatch):
    monkeypatch.setattr(build, "ROOT", tmp_path)
    monkeypatch.setattr(build, "UTMT_CLI_DIR", tmp_path / "missing")

    assert build.import_code(tmp_path / "data.win", tmp_path / "edited", tmp_path / "out.win", tmp_path / "new") is False

def test_transfer_options_replaces_only_the_options_section(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: True)
    build.USER_SAVE_DIR.mkdir()
    (build.USER_SAVE_DIR / "game.sav").write_text('[stats]\nx="9"\n[options]\nmusvol="0.2"\n', newline="")
    (modded / "save").mkdir(parents=True)
    (modded / "save" / "game.sav").write_text('[options]\nmusvol="1"\n[stats]\nx="1"\n', newline="")

    assert build.main(["--transfer-options"]) == 0

    assert (modded / "save" / "game.sav").read_text() == '[options]\nmusvol="0.2"\n[stats]\nx="1"\n'


def test_transfer_options_creates_the_save_when_there_is_none(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: True)
    build.USER_SAVE_DIR.mkdir()
    (build.USER_SAVE_DIR / "game.sav").write_text('[options]\nmusvol="0.2"\n', newline="")

    assert build.main(["--fresh-save", "--transfer-options"]) == 0

    assert (modded / "save" / "game.sav").read_text() == '[options]\nmusvol="0.2"\n'


def test_transfer_options_needs_the_copied_save(tmp_path, monkeypatch):
    make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: True)

    assert build.main(["--transfer-options"]) == 1

def test_main_copies_the_apclient_dll_and_records_its_release(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: True)

    assert build.main([]) == 0

    assert (modded / "gm-apclientpp.dll").read_bytes() == b"dll-1"
    assert (modded / "gm-apclientpp.version").read_text() == "v1.0.0"


def test_main_keeps_the_apclient_dll_of_the_same_release(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: True)
    modded.mkdir()
    (modded / "gm-apclientpp.dll").write_bytes(b"installed")
    (modded / "gm-apclientpp.version").write_text("v1.0.0")

    assert build.main([]) == 0

    assert (modded / "gm-apclientpp.dll").read_bytes() == b"installed"


def test_main_replaces_the_apclient_dll_of_another_release(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: True)
    modded.mkdir()
    (modded / "gm-apclientpp.dll").write_bytes(b"old")
    (modded / "gm-apclientpp.version").write_text("v0.9.0")

    assert build.main([]) == 0

    assert (modded / "gm-apclientpp.dll").read_bytes() == b"dll-1"
    assert (modded / "gm-apclientpp.version").read_text() == "v1.0.0"


def test_main_copies_the_apclient_dll_when_only_the_version_file_remains(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    monkeypatch.setattr(build, "import_code", lambda *args: True)
    modded.mkdir()
    (modded / "gm-apclientpp.version").write_text("v1.0.0")

    assert build.main([]) == 0

    assert (modded / "gm-apclientpp.dll").read_bytes() == b"dll-1"


def test_main_fails_before_copying_without_the_downloaded_dll(tmp_path, monkeypatch, capsys):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    (build.GM_APCLIENT_DIR / "v1.0.0" / "gm-apclientpp.dll").unlink()

    assert build.main([]) == 1

    assert "scripts/setup.py" in capsys.readouterr().out
    assert not modded.exists()


def test_main_fails_without_a_release_tag(tmp_path, monkeypatch, capsys):
    _, _, modded = make_layout(tmp_path, monkeypatch)
    build.INIT_GML.write_text("global.ap_version = 1;\n")

    assert build.main([]) == 1

    assert "gm_apclientpp_version" in capsys.readouterr().out
    assert not modded.exists()
