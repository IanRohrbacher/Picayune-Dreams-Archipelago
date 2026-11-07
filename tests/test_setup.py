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


def test_create_archipelago_save_dir_is_idempotent(tmp_path):
    setup.create_archipelago_save_dir(tmp_path)
    setup.create_archipelago_save_dir(tmp_path)

    assert (tmp_path / setup.ARCHIPELAGO_SAVE_DIR_NAME).is_dir()
