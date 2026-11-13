"""Builds the patched game into game_files_modded/.

  1. copy the whitelisted game files from game_files/game -> game_files_modded,
     plus steam_appid.txt
  2. with --fresh-save, replace game_files_modded/save/game.sav with the
     template made by scripts/setup.py; otherwise the current save is kept
  3. with the UndertaleModTool CLI, import into data.win and save it as
     game_files_modded/data.win:
       - every .gml under PicayuneDreams_edited replaces the game's code entry
         of the same name;
       - every .gml under PicayuneDreams_new adds a code entry, with the
         object, event or script it belongs to; the name must not exist yet.
         The folder is skipped when it is missing or holds no .gml.
     All subfolders are read; a file name used twice across both folders fails
     the build.

game_files/game/data.win is only read. Each build starts from the unmodified
data.win, so removing a file from either folder removes its patch.

usage:
    uv run scripts/build.py
"""

import argparse
import os
import shutil
import subprocess
import sys

from common import (
    EDIT_DIR,
    GAME_DIR,
    IMPORT_CODE_SCRIPT,
    MODDED_DIR,
    MODDED_SAVE_DIR,
    NEW_DIR,
    ROOT,
    SAVE_FILE_NAME,
    SAVE_TEMPLATE,
    STEAM_APP_ID,
    UTMT_CLI_DIR,
    find_duplicates,
)
from setup import copy_game_files


def write_steam_appid(dst) -> None:
    """Writes steam_appid.txt so the exe runs the build in dst, not the Steam install."""
    (dst / "steam_appid.txt").write_text(STEAM_APP_ID, encoding="ascii")
    print("  wrote steam_appid.txt")


def install_fresh_save(template, save_dir) -> bool:
    """Copies the template save to save_dir/game.sav, replacing the current save."""
    if not template.is_file():
        print(f"  error: {template.relative_to(ROOT)} not found (run scripts/setup.py)")
        return False
    save_dir.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(template, save_dir / SAVE_FILE_NAME)
    print(f"  wrote {(save_dir / SAVE_FILE_NAME).relative_to(ROOT)} from the template")
    return True


def import_code(data_win, edit_dir, output, new_dir=None) -> bool:
    """Imports edit_dir/*.gml over existing code and new_dir/*.gml (when given) as new code, saving to output."""
    cli = UTMT_CLI_DIR / "UndertaleModCli.exe"
    if not cli.exists():
        print(f"  error: {cli.relative_to(ROOT)} not found (run scripts/setup.py)")
        return False

    # flushing keeps this line ahead of the CLI's output when stdout is piped
    print(f"  importing {edit_dir.relative_to(ROOT)} ...", flush=True)
    env = {**os.environ, "PDA_IMPORT_DIR": str(edit_dir)}
    if new_dir is not None:
        print(f"  adding {new_dir.relative_to(ROOT)} ...", flush=True)
        env["PDA_NEW_DIR"] = str(new_dir)
    result = subprocess.run(
        [cli, "load", data_win, "--scripts", IMPORT_CODE_SCRIPT, "--output", output, "--overwrite"],
        env=env,
    )
    if result.returncode != 0:
        print(f"  error: UndertaleModCli failed (exit {result.returncode})")
        return False
    return True


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument(
        "--fresh-save",
        action="store_true",
        help="replace game_files_modded/save/game.sav with the template from scripts/setup.py",
    )
    args = parser.parse_args(argv)

    if not (GAME_DIR / "data.win").exists():
        print(f"error: {GAME_DIR.relative_to(ROOT)}/data.win not found (run scripts/setup.py)")
        return 1
    has_new = NEW_DIR.is_dir() and any(NEW_DIR.rglob("*.gml"))
    if not has_new and not any(EDIT_DIR.rglob("*.gml")):
        print(f"error: no .gml files in {EDIT_DIR.relative_to(ROOT)} or {NEW_DIR.relative_to(ROOT)}")
        return 1
    duplicates = find_duplicates(*(directory for directory in (EDIT_DIR, NEW_DIR) if directory.is_dir()))
    if duplicates:
        print(f"error: the same file name is used more than once in {EDIT_DIR.name} and {NEW_DIR.name}:")
        for paths in duplicates.values():
            for path in paths:
                print(f"  {path.relative_to(ROOT)}")
            print()
        return 1

    if args.fresh_save and not SAVE_TEMPLATE.is_file():
        print(f"error: {SAVE_TEMPLATE.relative_to(ROOT)} not found (run scripts/setup.py)")
        return 1

    print("[1/3] game files")
    copy_game_files(GAME_DIR, MODDED_DIR, force=True)
    write_steam_appid(MODDED_DIR)

    print("[2/3] save")
    if args.fresh_save:
        if not install_fresh_save(SAVE_TEMPLATE, MODDED_SAVE_DIR):
            return 1
    else:
        print("  keeping the current save (--fresh-save replaces it)")

    print("[3/3] code")
    if not import_code(GAME_DIR / "data.win", EDIT_DIR, MODDED_DIR / "data.win", NEW_DIR if has_new else None):
        return 1

    print(f"built {MODDED_DIR.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
