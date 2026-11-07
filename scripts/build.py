"""Builds the patched game into game_files_modded/.

  1. copy the whitelisted game files from game_files/game -> game_files_modded,
     plus steam_appid.txt
  2. import every PicayuneDreams_edited/*.gml into data.win with the
     UndertaleModTool CLI, saving the result as game_files_modded/data.win

game_files/game/data.win is only read. Each build starts from the unmodified
data.win, so removing a file from PicayuneDreams_edited removes its patch.

usage:
    uv run scripts/build.py
"""

import argparse
import os
import subprocess
import sys

from common import EDIT_DIR, GAME_DIR, IMPORT_CODE_SCRIPT, MODDED_DIR, ROOT, STEAM_APP_ID, UTMT_CLI_DIR
from setup import copy_game_files


def write_steam_appid(dst) -> None:
    """Writes steam_appid.txt so the exe runs the build in dst, not the Steam install."""
    (dst / "steam_appid.txt").write_text(STEAM_APP_ID, encoding="ascii")
    print("  wrote steam_appid.txt")


def import_code(data_win, edit_dir, output) -> bool:
    """Imports edit_dir/*.gml into data_win and saves the result to output."""
    cli = UTMT_CLI_DIR / "UndertaleModCli.exe"
    if not cli.exists():
        print(f"  error: {cli.relative_to(ROOT)} not found (run scripts/setup.py)")
        return False

    # flushing keeps this line ahead of the CLI's output when stdout is piped
    print(f"  importing {edit_dir.relative_to(ROOT)} ...", flush=True)
    env = {**os.environ, "PDA_IMPORT_DIR": str(edit_dir)}
    result = subprocess.run(
        [cli, "load", data_win, "--scripts", IMPORT_CODE_SCRIPT, "--output", output, "--overwrite"],
        env=env,
    )
    if result.returncode != 0:
        print(f"  error: UndertaleModCli failed (exit {result.returncode})")
        return False
    return True


def main(argv: list[str] | None = None) -> int:
    argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter).parse_args(argv)

    if not (GAME_DIR / "data.win").exists():
        print(f"error: {GAME_DIR.relative_to(ROOT)}/data.win not found (run scripts/setup.py)")
        return 1
    if not any(EDIT_DIR.glob("*.gml")):
        print(f"error: no .gml files in {EDIT_DIR.relative_to(ROOT)}")
        return 1

    print("[1/2] game files")
    copy_game_files(GAME_DIR, MODDED_DIR, force=True)
    write_steam_appid(MODDED_DIR)

    print("[2/2] code")
    if not import_code(GAME_DIR / "data.win", EDIT_DIR, MODDED_DIR / "data.win"):
        return 1

    print(f"built {MODDED_DIR.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
