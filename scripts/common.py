"""Paths and helpers shared by the project scripts."""

import fnmatch
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

EXTRACT_DIR = ROOT / "PicayuneDreams_extract"
EDIT_DIR = ROOT / "PicayuneDreams_edited"
GAME_FILES_DIR = ROOT / "game_files"
LOG_DIR = ROOT / "logs"

# is committed so anyone can verify their own (uncommitted) extract
EXTRACT_BASELINE = ROOT / "scripts" / "extract.sha256"

GAME_DIR = GAME_FILES_DIR / "game"

UTMT_VERSION = "0.9.2.0"
_UTMT_RELEASE = f"https://github.com/UnderminersTeam/UndertaleModTool/releases/download/{UTMT_VERSION}"
UTMT_DIR = ROOT / f"UndertaleModTool_v{UTMT_VERSION}-Windows-SingleFile"
UTMT_URL = f"{_UTMT_RELEASE}/UndertaleModTool_v{UTMT_VERSION}-Windows-SingleFile.zip"
UTMT_CLI_DIR = ROOT / f"UTMT_CLI_v{UTMT_VERSION}-Windows"
UTMT_CLI_URL = f"{_UTMT_RELEASE}/UTMT_CLI_v{UTMT_VERSION}-Windows.zip"
EXPORT_CODE_SCRIPT = ROOT / "scripts" / "utmt" / "export_code.csx"
IMPORT_CODE_SCRIPT = ROOT / "scripts" / "utmt" / "import_code.csx"
MODDED_DIR = ROOT / "game_files_modded"

GAME_FOLDER_NAME = "Picayune Dreams"
# steam_appid.txt next to the exe stops the Steam API from relaunching the
# official install when the exe is started outside Steam
STEAM_APP_ID = "2088840"
SAVE_FOLDER_NAME = "PicayuneDreams"
SAVE_FILE_NAME = "game.sav"
# must match global.save_dir in PicayuneDreams_edited/gml_Object_obj_init_Create_0.gml
MODDED_SAVE_DIR = MODDED_DIR / "save"
# committed fresh profile (default values only); setup adds the user's [options] to it
SAVE_BASELINE = ROOT / "scripts" / "save_baseline.sav"
SAVE_TEMPLATE = GAME_FILES_DIR / "save_template" / SAVE_FILE_NAME

# everything the game ships with; anything else in the install is left behind
GAME_FILE_WHITELIST = [
    "data.win",
    "PICAYUNEDREAMS.exe",
    "options.ini",
    "steam_api64.dll",
    "Steamworks_x64.dll",
    "mods",
]


def match_names(names: list[str], patterns: list[str]) -> tuple[list[str], list[str]]:
    """Filters file names by name (".gml" optional), glob pattern or path.

    Returns (sorted matching names, patterns that matched nothing); no
    patterns selects everything.
    """
    if not patterns:
        return sorted(names), []

    selected, unmatched = set(), []
    for pattern in patterns:
        pattern = Path(pattern).name
        if not any(char in pattern for char in "*?[") and not pattern.endswith(".gml"):
            pattern += ".gml"
        matches = [name for name in names if fnmatch.fnmatch(Path(name).name, pattern)]
        if not matches:
            unmatched.append(pattern)
        selected.update(matches)

    return sorted(selected), unmatched
