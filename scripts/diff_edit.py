"""Diffs PicayuneDreams_edited files against their originals in
PicayuneDreams_extract, writing one log per file to logs/diff/<name>.diff.

Edited files are found in PicayuneDreams_edited and all its subfolders; a
file name used twice fails the run. Files can be picked by name (".gml"
optional) or glob pattern; with none given every edited file is diffed and
stale logs are removed.

usage:
    uv run scripts/diff_edit.py
    uv run scripts/diff_edit.py gml_Object_obj_init_Create_0
    uv run scripts/diff_edit.py "*skillpoint*" --print
"""

import argparse
import difflib
import sys
from pathlib import Path

from common import EDIT_DIR, EXTRACT_DIR, LOG_DIR, ROOT, find_duplicates, match_names

DIFF_LOG_DIR = LOG_DIR / "diff"


def read_lines(path: Path) -> list[str]:
    lines = path.read_text(encoding="utf-8", errors="replace").splitlines(keepends=True)
    # a newline on every line keeps the diff well-formed when the file lacks a final one
    return [line if line.endswith("\n") else line + "\n" for line in lines]


def hunk_range(start: int, stop: int) -> str:
    """Line range in unified diff "@@" notation."""
    length = stop - start
    first = start + 1 if length else start
    return str(first) if length == 1 else f"{first},{length}"


def unified_diff(old: list[str], new: list[str], from_name: str, to_name: str, context: int = 3) -> list[str]:
    """difflib.unified_diff, but with autojunk off.

    autojunk ignores lines making up >1% of a 200+ line file (e.g. indented
    blank lines in GML), which shows unchanged lines as removed and re-added.
    """
    matcher = difflib.SequenceMatcher(None, old, new, autojunk=False)
    output = []

    for group in matcher.get_grouped_opcodes(context):
        if not output:
            output += [f"--- {from_name}\n", f"+++ {to_name}\n"]
        first, last = group[0], group[-1]
        output.append(f"@@ -{hunk_range(first[1], last[2])} +{hunk_range(first[3], last[4])} @@\n")

        for tag, i1, i2, j1, j2 in group:
            if tag == "equal":
                output += [" " + line for line in old[i1:i2]]
                continue
            if tag in ("replace", "delete"):
                output += ["-" + line for line in old[i1:i2]]
            if tag in ("replace", "insert"):
                output += ["+" + line for line in new[j1:j2]]

    return output


def diff_file(original: Path, edited: Path, name: str) -> list[str]:
    """Unified diff of one file; a missing original diffs against nothing."""
    old = read_lines(original) if original.exists() else []
    from_name = f"extract/{name}" if original.exists() else "/dev/null"
    return unified_diff(old, read_lines(edited), from_name, f"edit/{name}")


def summarize(original: Path, lines: list[str]) -> str:
    if not original.exists():
        return "new file"
    if not lines:
        return "unchanged (can be removed from _edited)"
    added = sum(1 for line in lines[2:] if line.startswith("+"))
    removed = sum(1 for line in lines[2:] if line.startswith("-"))
    return f"+{added} -{removed}"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("files", nargs="*", help="_edited file names or glob patterns (default: all)")
    parser.add_argument("--print", action="store_true", help="print diffs to the terminal instead of writing logs")
    args = parser.parse_args(argv)

    for directory in (EXTRACT_DIR, EDIT_DIR):
        if not directory.is_dir():
            print(f"error: {directory.relative_to(ROOT)} not found")
            return 2

    duplicates = find_duplicates(EDIT_DIR)
    if duplicates:
        print(f"error: the same file name is used more than once in {EDIT_DIR.relative_to(ROOT)}:")
        for paths in duplicates.values():
            for path in paths:
                print(f"  {path.relative_to(ROOT)}")
            print()
        return 1

    edit_names = [path.relative_to(EDIT_DIR).as_posix() for path in EDIT_DIR.rglob("*.gml")]
    names, unmatched = match_names(edit_names, args.files)
    for pattern in unmatched:
        print(f"no _edited file matches: {pattern}")

    if not args.print:
        DIFF_LOG_DIR.mkdir(parents=True, exist_ok=True)
        if not args.files:
            for stale in DIFF_LOG_DIR.glob("*.diff"):
                stale.unlink()

    for name in names:
        # the extract is flat: an edited file's original has the same file name
        file_name = Path(name).name
        original = EXTRACT_DIR / file_name
        lines = diff_file(original, EDIT_DIR / name, file_name)

        if args.print:
            sys.stdout.writelines(lines)
        else:
            log = DIFF_LOG_DIR / f"{Path(name).stem}.diff"
            log.write_text("".join(lines), encoding="utf-8", newline="\n")
        print(f"{name}: {summarize(original, lines)}")

    if not args.print and names:
        print(f"logs in {DIFF_LOG_DIR.relative_to(ROOT)}")
    return 1 if unmatched else 0


if __name__ == "__main__":
    sys.exit(main())
