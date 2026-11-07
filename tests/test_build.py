import build


def make_layout(tmp_path, monkeypatch, with_gml=True):
    game, edit, modded = tmp_path / "game", tmp_path / "edited", tmp_path / "modded"
    game.mkdir()
    edit.mkdir()
    (game / "data.win").write_bytes(b"win")
    if with_gml:
        (edit / "gml_Object_a_Create_0.gml").write_text("x")
    for name, value in {"ROOT": tmp_path, "GAME_DIR": game, "EDIT_DIR": edit, "MODDED_DIR": modded}.items():
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
    assert calls == [(game / "data.win", edit, modded / "data.win")]


def test_main_fails_without_edited_gml(tmp_path, monkeypatch):
    _, _, modded = make_layout(tmp_path, monkeypatch, with_gml=False)

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
    edit = tmp_path / "edited"

    assert build.import_code(tmp_path / "data.win", edit, tmp_path / "out.win") is False
