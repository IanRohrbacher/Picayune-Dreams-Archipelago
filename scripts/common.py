"""Paths and helpers shared by the project scripts."""

import fnmatch
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

EXTRACT_DIR = ROOT / "PicayuneDreams_extract"
EDIT_DIR = ROOT / "PicayuneDreams_edited"
NEW_DIR = ROOT / "PicayuneDreams_new"
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
ADD_ROOMS_SCRIPT = ROOT / "scripts" / "utmt" / "add_rooms.csx"
LINK_ROOM_CODE_SCRIPT = ROOT / "scripts" / "utmt" / "link_room_code.csx"
# run in this order on the same loaded data.win: rooms first so new code can name them
BUILD_SCRIPTS = [ADD_ROOMS_SCRIPT, IMPORT_CODE_SCRIPT, LINK_ROOM_CODE_SCRIPT]
MODDED_DIR = ROOT / "game_files_modded"

# the gm-apclientpp release to use is the tag in global.gm_apclientpp_version in obj_init Create
INIT_GML = EDIT_DIR / "gml_Object_obj_init_Create_0.gml"
GM_APCLIENT_DIR = GAME_FILES_DIR / "gm-apclientpp"  # one <tag>/ folder per downloaded release
GM_APCLIENT_DLL = "gm-apclientpp.dll"
GM_APCLIENT_URL = "https://github.com/black-sliver/gm-apclientpp/releases/download/{tag}/gm-apclientpp-win64.zip"
# written next to the DLL in game_files_modded so a build can tell which release is installed
GM_APCLIENT_VERSION_FILE = "gm-apclientpp.version"
_GM_APCLIENT_TAG = re.compile(r'global\.gm_apclientpp_version\s*=\s*"([^"]*)"\s*;')
_RELEASE_TAG = re.compile(r"[A-Za-z0-9][A-Za-z0-9._-]*")

GAME_FOLDER_NAME = "Picayune Dreams"
# steam_appid.txt next to the exe stops the Steam API from relaunching the
# official install when the exe is started outside Steam
STEAM_APP_ID = "2088840"
SAVE_FOLDER_NAME = "PicayuneDreams"
SAVE_FILE_NAME = "game.sav"
# setup copies the user's whole save folder here; the real one is only ever read
USER_SAVE_DIR = GAME_FILES_DIR / "save"
# must match global.save_dir in PicayuneDreams_edited/gml_Object_obj_init_Create_0.gml
MODDED_SAVE_DIR = MODDED_DIR / "save"

# everything the game ships with; anything else in the install is left behind
GAME_FILE_WHITELIST = [
    "data.win",
    "PICAYUNEDREAMS.exe",
    "options.ini",
    "steam_api64.dll",
    "Steamworks_x64.dll",
    "mods",
]


def read_gm_apclient_version(init_gml: Path = INIT_GML) -> str:
    """The gm-apclientpp release tag set in global.gm_apclientpp_version; raises ValueError when it is missing or unsafe."""
    match = _GM_APCLIENT_TAG.search(init_gml.read_text(encoding="utf-8"))
    if match is None:
        raise ValueError(f"global.gm_apclientpp_version is not set in {init_gml.name}")
    tag = match.group(1)
    # the tag becomes part of a download URL and a folder name
    if _RELEASE_TAG.fullmatch(tag) is None:
        raise ValueError(f"invalid gm-apclientpp release tag {tag!r} in {init_gml.name}")
    return tag


def extract_section(text: str, name: str) -> str | None:
    """Returns the INI section `name` (header line included, line endings kept), or None."""
    lines = text.splitlines(keepends=True)
    start = next((i for i, line in enumerate(lines) if line.strip() == f"[{name}]"), None)
    if start is None:
        return None
    end = next((i for i in range(start + 1, len(lines)) if lines[i].startswith("[")), len(lines))
    return "".join(lines[start:end])


def replace_section(text: str, name: str, section: str) -> str:
    """Replaces the INI section `name` in text with `section`, or puts it first when text has none."""
    if not section.endswith("\n"):
        section += "\r\n"
    old = extract_section(text, name)
    if old is None:
        return section + text
    return text.replace(old, section, 1)


def find_duplicates(*dirs: Path) -> dict[str, list[Path]]:
    """Maps each .gml file name used more than once under dirs (any depth, case-insensitive) to its paths."""
    by_name: dict[str, list[Path]] = {}
    for directory in dirs:
        for path in sorted(directory.rglob("*.gml")):
            by_name.setdefault(path.name.lower(), []).append(path)
    return {name: paths for name, paths in by_name.items() if len(paths) > 1}


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
