"""Checks PicayuneDreams_extract against the committed hash baseline.

The extract is the untouched decompiled game code and is never committed, so
this compares it against scripts/extract.sha256 to catch accidental edits.

Files can be picked by name (".gml" optional) or glob pattern.

usage:
    uv run scripts/check_extract.py                   # verifies everything
    uv run scripts/check_extract.py "*obj_player*"    # verifies some files
    uv run scripts/check_extract.py --update          # (re)writes the baseline
"""

import argparse
import hashlib
import sys
from pathlib import Path

from common import EXTRACT_BASELINE, EXTRACT_DIR, ROOT, match_names


def hash_dir(directory: Path, names: list[str] | None = None) -> dict[str, str]:
    """Maps each file's path (relative, forward slashes) to its sha256.

    With names, only those files are hashed (missing ones are left out).
    """
    if names is None:
        names = [path.relative_to(directory).as_posix() for path in directory.rglob("*") if path.is_file()]
    return {
        name: hashlib.sha256((directory / name).read_bytes()).hexdigest()
        for name in sorted(names)
        if (directory / name).is_file()
    }


def read_baseline(path: Path) -> dict[str, str]:
    """Reads a sha256sum-style file ("<digest>  <name>" per line)."""
    hashes = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        if line and not line.startswith("#"):
            digest, name = line.split("  ", 1)
            hashes[name] = digest
    return hashes


def write_baseline(path: Path, hashes: dict[str, str]) -> None:
    lines = [f"{digest}  {name}" for name, digest in sorted(hashes.items())]
    path.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")


def compare(expected: dict[str, str], actual: dict[str, str]) -> tuple[list[str], list[str], list[str]]:
    """Returns (modified, missing, added) file names."""
    modified = sorted(name for name in expected.keys() & actual.keys() if expected[name] != actual[name])
    missing = sorted(expected.keys() - actual.keys())
    added = sorted(actual.keys() - expected.keys())
    return modified, missing, added


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("files", nargs="*", help="file names or glob patterns to check (default: all)")
    parser.add_argument("--update", action="store_true", help="overwrite the baseline with the whole current extract")
    args = parser.parse_args(argv)

    if not EXTRACT_DIR.is_dir():
        print(f"error: {EXTRACT_DIR.relative_to(ROOT)} not found (run scripts/setup.py first)")
        return 2

    if args.update or not EXTRACT_BASELINE.exists():
        if args.files:
            print("error: --update always rewrites the whole baseline; don't pass files")
            return 2
        actual = hash_dir(EXTRACT_DIR)
        write_baseline(EXTRACT_BASELINE, actual)
        print(f"wrote baseline of {len(actual)} files to {EXTRACT_BASELINE.relative_to(ROOT)}")
        return 0

    expected = read_baseline(EXTRACT_BASELINE)
    on_disk = [path.relative_to(EXTRACT_DIR).as_posix() for path in EXTRACT_DIR.rglob("*") if path.is_file()]
    names, unmatched = match_names(sorted(expected.keys() | set(on_disk)), args.files)
    for pattern in unmatched:
        print(f"no extract file matches: {pattern}")

    expected = {name: expected[name] for name in names if name in expected}
    modified, missing, added = compare(expected, hash_dir(EXTRACT_DIR, names))

    for label, group in (("modified", modified), ("missing", missing), ("added", added)):
        if group:
            print(f"{label} ({len(group)}):")
            for name in group:
                print(f"  {name}")

    if modified or missing or added or unmatched:
        print("extract does NOT match baseline")
        return 1

    print(f"extract matches baseline ({len(names)} files)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
