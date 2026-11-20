from pathlib import Path

import pytest

import setup


@pytest.fixture
def answers(monkeypatch):
    """Feeds input() from a list."""
    queue = []
    monkeypatch.setattr("builtins.input", lambda _prompt: queue.pop(0))
    return queue


def test_ask_dir_enter_accepts_suggestion(tmp_path, answers):
    answers.append("")

    assert setup.ask_dir("folder", tmp_path) == tmp_path


def test_ask_dir_requires_input_without_suggestion(tmp_path, answers):
    answers += ["", str(tmp_path)]

    assert setup.ask_dir("folder", None) == tmp_path


def test_ask_dir_rejects_folder_missing_required_file(tmp_path, answers):
    good = tmp_path / "game"
    good.mkdir()
    (good / "data.win").write_bytes(b"")
    answers += [str(tmp_path), f'"{good}"']

    assert setup.ask_dir("folder", None, required_file="data.win") == Path(good)


def test_copy_game_files_only_copies_whitelist(tmp_path, monkeypatch):
    monkeypatch.setattr(setup, "ROOT", tmp_path)
    monkeypatch.setattr(setup, "GAME_FILE_WHITELIST", ["data.win", "mods"])
    install, dst = tmp_path / "install", tmp_path / "copy"
    (install / "mods" / "my-mod").mkdir(parents=True)
    (install / "mods" / "my-mod" / "main.gml").write_text("x")
    (install / "data.win").write_bytes(b"win")
    (install / "mod_temprun.temp").write_bytes(b"junk")

    setup.copy_game_files(install, dst, force=False)

    copied = sorted(p.relative_to(dst).as_posix() for p in dst.rglob("*"))
    assert copied == ["data.win", "mods", "mods/my-mod", "mods/my-mod/main.gml"]

def test_copy_user_save_copies_the_whole_folder(tmp_path, monkeypatch):
    monkeypatch.setattr(setup, "ROOT", tmp_path)
    src, dst = tmp_path / "appdata", tmp_path / "game_files" / "save"
    (src / "slots").mkdir(parents=True)
    (src / "game.sav").write_text("a")
    (src / "slots" / "x.sav").write_text("b")

    setup.copy_user_save(src, dst, force=False)

    assert (dst / "game.sav").read_text() == "a"
    assert (dst / "slots" / "x.sav").read_text() == "b"


def test_copy_user_save_skips_an_existing_copy_unless_forced(tmp_path, monkeypatch):
    monkeypatch.setattr(setup, "ROOT", tmp_path)
    src, dst = tmp_path / "appdata", tmp_path / "save"
    src.mkdir()
    dst.mkdir()
    (src / "game.sav").write_text("new")
    (dst / "game.sav").write_text("old")

    setup.copy_user_save(src, dst, force=False)
    assert (dst / "game.sav").read_text() == "old"

    setup.copy_user_save(src, dst, force=True)
    assert (dst / "game.sav").read_text() == "new"
