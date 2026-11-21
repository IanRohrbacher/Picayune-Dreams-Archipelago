"""Builds the patched game into game_files_modded/.

  1. copy the whitelisted game files from game_files/game -> game_files_modded,
     plus steam_appid.txt and gm-apclientpp.dll (the release named by
     global.gm_apclientpp_version in obj_init, downloaded by scripts/setup.py);
     the DLL is copied only when it is missing or another release is installed
  2. with --fresh-save, delete game_files_modded/save so the game starts from
     its defaults; otherwise the current save is kept. With --transfer-options,
     copy the [options] section of game_files/save/game.sav (your save, copied
     by scripts/setup.py) into game_files_modded/save/game.sav
  3. with the UndertaleModTool CLI, change data.win and save it as
     game_files_modded/data.win:
       - scripts/utmt/add_rooms.csx adds the cloned rooms (rm_ap_connect);
       - every .gml under PicayuneDreams_edited replaces the game's code entry
         of the same name;
       - every .gml under PicayuneDreams_new adds a code entry, with the
         object, event or script it belongs to; the name must not exist yet.
         The folder is skipped when it is missing or holds no .gml;
       - scripts/utmt/link_room_code.csx attaches gml_Room_<room>_Create to its room.
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
    BUILD_SCRIPTS,
    EDIT_DIR,
    GAME_DIR,
    GM_APCLIENT_DIR,
    GM_APCLIENT_DLL,
    GM_APCLIENT_VERSION_FILE,
    INIT_GML,
    MODDED_DIR,
    MODDED_SAVE_DIR,
    NEW_DIR,
    ROOT,
    SAVE_FILE_NAME,
    STEAM_APP_ID,
    USER_SAVE_DIR,
    UTMT_CLI_DIR,
    extract_section,
    find_duplicates,
    read_gm_apclient_version,
    replace_section,
)
from setup import copy_game_files


def write_steam_appid(dst) -> None:
    """Writes steam_appid.txt so the exe runs the build in dst, not the Steam install."""
    (dst / "steam_appid.txt").write_text(STEAM_APP_ID, encoding="ascii")
    print("  wrote steam_appid.txt")


def copy_gm_apclient(tag, dst) -> bool:
    """Copies the gm-apclientpp DLL of release `tag` into dst, unless that release is already installed there."""
    source = GM_APCLIENT_DIR / tag / GM_APCLIENT_DLL
    if not source.is_file():
        print(f"  error: {source.relative_to(ROOT)} not found (run scripts/setup.py)")
        return False

    target = dst / GM_APCLIENT_DLL
    marker = dst / GM_APCLIENT_VERSION_FILE
    installed = marker.read_text(encoding="utf-8").strip() if marker.is_file() else None
    if target.is_file() and installed == tag:
        print(f"  {GM_APCLIENT_DLL} {tag} is already installed")
        return True

    try:
        shutil.copy2(source, target)
    except PermissionError:
        print(f"  error: cannot replace {target.relative_to(ROOT)}; close the game and build again")
        return False
    marker.write_text(tag, encoding="utf-8")
    print(f"  copied {GM_APCLIENT_DLL} {tag}")
    return True


def reset_save(save_dir) -> None:
    """Deletes save_dir with everything in it; the game recreates it with its default values."""
    if save_dir.is_dir():
        shutil.rmtree(save_dir)
        print(f"  deleted {save_dir.relative_to(ROOT)}")
    else:
        print(f"  {save_dir.relative_to(ROOT)} does not exist; nothing to delete")


def transfer_options(source_dir, save_dir) -> bool:
    """Replaces the [options] section of save_dir/game.sav with the one in source_dir/game.sav; other data stays."""
    source = source_dir / SAVE_FILE_NAME
    if not source.is_file():
        print(f"  error: {source.relative_to(ROOT)} not found (run scripts/setup.py)")
        return False

    options = extract_section(source.read_bytes().decode("utf-8", errors="replace"), "options")
    if options is None:
        print(f"  error: no [options] section in {source.relative_to(ROOT)}")
        return False

    target = save_dir / SAVE_FILE_NAME
    current = target.read_bytes().decode("utf-8", errors="replace") if target.is_file() else ""
    save_dir.mkdir(parents=True, exist_ok=True)
    target.write_bytes(replace_section(current, "options", options).encode("utf-8"))
    print(f"  copied [options] from {source.relative_to(ROOT)} into {target.relative_to(ROOT)}")
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
    script_args = [arg for script in BUILD_SCRIPTS for arg in ("--scripts", script)]
    result = subprocess.run([cli, "load", data_win, *script_args, "--output", output, "--overwrite"], env=env)
    if result.returncode != 0:
        print(f"  error: UndertaleModCli failed (exit {result.returncode})")
        return False
    return True


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument(
        "--fresh-save",
        action="store_true",
        help="delete game_files_modded/save (game.sav, slots, loadouts) before building",
    )
    parser.add_argument(
        "--transfer-options",
        action="store_true",
        help="copy the [options] section of your save (game_files/save/game.sav, made by setup) into "
        "game_files_modded/save/game.sav; all other saved data is left alone",
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

    try:
        gm_apclient_tag = read_gm_apclient_version(INIT_GML)
    except (OSError, ValueError) as error:
        print(f"error: {error}")
        return 1
    gm_apclient_dll = GM_APCLIENT_DIR / gm_apclient_tag / GM_APCLIENT_DLL
    if not gm_apclient_dll.is_file():
        print(f"error: {gm_apclient_dll.relative_to(ROOT)} not found (run scripts/setup.py)")
        return 1

    print("[1/3] game files")
    copy_game_files(GAME_DIR, MODDED_DIR, force=True)
    write_steam_appid(MODDED_DIR)
    if not copy_gm_apclient(gm_apclient_tag, MODDED_DIR):
        return 1

    print("[2/3] save")
    if args.fresh_save:
        reset_save(MODDED_SAVE_DIR)
    else:
        print("  keeping the current save (--fresh-save deletes it)")
    if args.transfer_options and not transfer_options(USER_SAVE_DIR, MODDED_SAVE_DIR):
        return 1

    print("[3/3] code")
    if not import_code(GAME_DIR / "data.win", EDIT_DIR, MODDED_DIR / "data.win", NEW_DIR if has_new else None):
        return 1

    print(f"built {MODDED_DIR.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
