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


REAL_SAVE = '[boss]\r\nx="1"\r\n[options]\r\nmusvol="0.2"\r\nkb_up="87"\r\n[stats]\r\ny="2"\r\n'
BASELINE = '[stats]\r\nhas_beaten_game="0"\r\n[overdrive]\r\nz="0"\r\n'


def test_extract_section_keeps_lines_up_to_next_header():
    assert setup.extract_section(REAL_SAVE, "options") == '[options]\r\nmusvol="0.2"\r\nkb_up="87"\r\n'


def test_extract_section_missing_returns_none():
    assert setup.extract_section(REAL_SAVE, "nope") is None


def test_build_save_template_puts_options_first():
    options = setup.extract_section(REAL_SAVE, "options")

    assert setup.build_save_template(BASELINE, options) == options + BASELINE
    assert setup.build_save_template(BASELINE, None) == BASELINE


@pytest.fixture
def template_paths(tmp_path, monkeypatch):
    baseline, template = tmp_path / "baseline.sav", tmp_path / "out" / "game.sav"
    baseline.write_bytes(BASELINE.encode())
    monkeypatch.setattr(setup, "ROOT", tmp_path)
    monkeypatch.setattr(setup, "SAVE_BASELINE", baseline)
    monkeypatch.setattr(setup, "SAVE_TEMPLATE", template)
    return template


def test_create_save_template_adds_users_options(tmp_path, template_paths):
    saves = tmp_path / "saves"
    saves.mkdir()
    (saves / "game.sav").write_bytes(REAL_SAVE.encode())

    setup.create_save_template(saves, force=False)

    text = template_paths.read_bytes().decode()
    assert text.startswith('[options]\r\nmusvol="0.2"')
    assert text.endswith(BASELINE)
    assert "[boss]" not in text


def test_create_save_template_without_a_save_uses_baseline(tmp_path, template_paths):
    setup.create_save_template(tmp_path, force=False)

    assert template_paths.read_bytes().decode() == BASELINE


def test_create_save_template_skips_existing_unless_forced(tmp_path, template_paths):
    template_paths.parent.mkdir()
    template_paths.write_text("keep")

    setup.create_save_template(tmp_path, force=False)
    assert template_paths.read_text() == "keep"

    setup.create_save_template(tmp_path, force=True)
    assert template_paths.read_bytes().decode() == BASELINE
