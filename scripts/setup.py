"""First-time setup: gathers everything the repo needs but doesn't commit.

  1. copy the whitelisted game files      -> game_files/game   (work on a copy, never the install)
  2. create the test save template        -> game_files/save_template/game.sav
     (scripts/save_baseline.sav plus the [options] of <save folder>/game.sav)
  3. download UndertaleModTool GUI + CLI
  4. decompile game_files/game/data.win    -> PicayuneDreams_extract, then check it against the baseline

The game and save folders are always asked for; a detected path is offered
and accepted with Enter. Steps whose result already exists are skipped
unless --force is given.

usage:
    uv run scripts/setup.py
"""

import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
import urllib.request
import zipfile
from pathlib import Path

import check_extract
from common import (
    EDIT_DIR,
    EXPORT_CODE_SCRIPT,
    EXTRACT_DIR,
    GAME_DIR,
    GAME_FILE_WHITELIST,
    GAME_FOLDER_NAME,
    ROOT,
    SAVE_BASELINE,
    SAVE_FILE_NAME,
    SAVE_FOLDER_NAME,
    SAVE_TEMPLATE,
    UTMT_CLI_DIR,
    UTMT_CLI_URL,
    UTMT_DIR,
    UTMT_URL,
)


def steam_libraries() -> list[Path]:
    """Every Steam library folder listed in the registry's Steam install."""
    try:
        import winreg

        with winreg.OpenKey(winreg.HKEY_CURRENT_USER, r"Software\Valve\Steam") as key:
            steam = Path(winreg.QueryValueEx(key, "SteamPath")[0])
    except OSError:
        return []

    vdf = steam / "steamapps" / "libraryfolders.vdf"
    if not vdf.exists():
        return [steam]
    paths = re.findall(r'"path"\s+"([^"]+)"', vdf.read_text(encoding="utf-8", errors="replace"))
    return [Path(path.replace("\\\\", "\\")) for path in paths] or [steam]


def detect_game_dir() -> Path | None:
    for library in steam_libraries():
        candidate = library / "steamapps" / "common" / GAME_FOLDER_NAME
        if (candidate / "data.win").exists():
            return candidate
    return None


def detect_save_dir() -> Path | None:
    candidate = Path(os.environ.get("LOCALAPPDATA", "")) / SAVE_FOLDER_NAME
    return candidate if candidate.is_dir() else None


def ask_dir(prompt: str, suggestion: Path | None, required_file: str | None = None) -> Path:
    """Asks until the user gives an existing folder (Enter accepts the suggestion)."""
    while True:
        hint = f" [{suggestion}]" if suggestion else ""
        answer = input(f"  {prompt}{hint}: ").strip().strip('"')
        path = Path(answer) if answer else suggestion

        if path is None:
            print("    a path is required")
        elif not path.is_dir():
            print(f"    not a folder: {path}")
        elif required_file and not (path / required_file).exists():
            print(f"    no {required_file} in {path}")
        else:
            return path


def copy_game_files(src: Path, dst: Path, force: bool) -> None:
    """Copies only GAME_FILE_WHITELIST from the install, reporting what is left out."""
    if dst.exists() and not force:
        print(f"  skip: {dst.relative_to(ROOT)} already exists (--force to overwrite)")
        return

    missing = [name for name in GAME_FILE_WHITELIST if not (src / name).exists()]
    if missing:
        print(f"  warning: not in the install: {', '.join(missing)}")

    dst.mkdir(parents=True, exist_ok=True)
    for name in GAME_FILE_WHITELIST:
        source = src / name
        if source.is_dir():
            shutil.copytree(source, dst / name, dirs_exist_ok=True)
        elif source.is_file():
            shutil.copy2(source, dst / name)
        else:
            continue
        print(f"  copied {name}")

    left_out = sorted(path.name for path in src.iterdir() if path.name not in GAME_FILE_WHITELIST)
    if left_out:
        print(f"  not copied (not whitelisted): {', '.join(left_out)}")


def extract_section(text: str, name: str) -> str | None:
    """Returns the INI section `name` (header line included, line endings kept), or None."""
    lines = text.splitlines(keepends=True)
    header = f"[{name}]"
    start = next((i for i, line in enumerate(lines) if line.strip() == header), None)
    if start is None:
        return None
    end = next((i for i in range(start + 1, len(lines)) if lines[i].startswith("[")), len(lines))
    return "".join(lines[start:end])


def build_save_template(baseline: str, options: str | None) -> str:
    """Inserts the [options] section before the baseline's first section."""
    if not options:
        return baseline
    if not options.endswith("\n"):
        options += "\r\n"
    return options + baseline


def create_save_template(save_dir: Path, force: bool) -> None:
    """Writes SAVE_TEMPLATE: the baseline save plus [options] from the user's game.sav."""
    if SAVE_TEMPLATE.exists() and not force:
        print(f"  skip: {SAVE_TEMPLATE.relative_to(ROOT)} already exists (--force to overwrite)")
        return

    real = save_dir / SAVE_FILE_NAME
    options = None
    if real.is_file():
        options = extract_section(real.read_bytes().decode("utf-8", errors="replace"), "options")
    if options is None:
        print(f"  warning: no [options] in {real}; the template has the game's defaults")

    baseline = SAVE_BASELINE.read_bytes().decode("utf-8")
    SAVE_TEMPLATE.parent.mkdir(parents=True, exist_ok=True)
    SAVE_TEMPLATE.write_bytes(build_save_template(baseline, options).encode("utf-8"))
    print(f"  wrote {SAVE_TEMPLATE.relative_to(ROOT)}")


def download_zip(url: str, target_dir: Path, exe_name: str, force: bool) -> None:
    if (target_dir / exe_name).exists() and not force:
        print(f"  skip: {target_dir.relative_to(ROOT)} already exists")
        return

    with tempfile.TemporaryDirectory() as tmp:
        archive = Path(tmp) / "download.zip"
        print(f"  downloading {url} ...")
        urllib.request.urlretrieve(url, archive)

        with zipfile.ZipFile(archive) as zf:
            names = [name for name in zf.namelist() if not name.endswith("/")]
            # unwraps a single top-level folder so the exe lands directly in target_dir
            tops = {name.split("/", 1)[0] for name in names}
            prefix = tops.pop() + "/" if len(tops) == 1 and all("/" in n for n in names) else ""

            target_dir.mkdir(parents=True, exist_ok=True)
            for name in names:
                target = target_dir / name.removeprefix(prefix)
                target.parent.mkdir(parents=True, exist_ok=True)
                with zf.open(name) as src, target.open("wb") as dst:
                    shutil.copyfileobj(src, dst)

    print(f"  extracted to {target_dir.relative_to(ROOT)}")


def export_code(data_win: Path, out_dir: Path) -> bool:
    """Decompiles data_win into out_dir with the UndertaleModTool CLI."""
    cli = UTMT_CLI_DIR / "UndertaleModCli.exe"
    if not cli.exists():
        print(f"  error: {cli.relative_to(ROOT)} not found")
        return False

    # exporting to a temp folder first means a failed run never leaves a half-written extract
    tmp = out_dir.with_name(out_dir.name + ".tmp")
    shutil.rmtree(tmp, ignore_errors=True)

    # flushing keeps this line ahead of the CLI's output when stdout is piped
    print(f"  decompiling {data_win.relative_to(ROOT)} ...", flush=True)
    env = {**os.environ, "PDA_EXPORT_DIR": str(tmp)}
    result = subprocess.run([cli, "load", data_win, "--scripts", EXPORT_CODE_SCRIPT], env=env)
    if result.returncode != 0 or not tmp.is_dir():
        print(f"  error: UndertaleModCli failed (exit {result.returncode})")
        shutil.rmtree(tmp, ignore_errors=True)
        return False

    shutil.rmtree(out_dir, ignore_errors=True)
    tmp.rename(out_dir)
    return True


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--force", action="store_true", help="redo steps whose result already exists")
    args = parser.parse_args(argv)

    print("[1/4] game files")
    game_dir = ask_dir("game install folder", detect_game_dir(), required_file="data.win")
    copy_game_files(game_dir, GAME_DIR, args.force)

    print("[2/4] test save template")
    save_dir = ask_dir("save data folder", detect_save_dir())
    create_save_template(save_dir, args.force)

    print("[3/4] UndertaleModTool")
    download_zip(UTMT_URL, UTMT_DIR, "UndertaleModTool.exe", args.force)
    download_zip(UTMT_CLI_URL, UTMT_CLI_DIR, "UndertaleModCli.exe", args.force)

    print("[4/4] decompiled code")
    EDIT_DIR.mkdir(exist_ok=True)
    if EXTRACT_DIR.is_dir() and not args.force:
        print(f"  skip: {EXTRACT_DIR.relative_to(ROOT)} already exists")
    elif not export_code(GAME_DIR / "data.win", EXTRACT_DIR):
        return 1

    return check_extract.main([])


if __name__ == "__main__":
    sys.exit(main())
