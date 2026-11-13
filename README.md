# Picayune-Dreams-Archipelago

## Setup

Requires [uv](https://docs.astral.sh/uv/).

```sh
uv sync
uv run scripts/setup.py
```

`setup.py` asks for the game install and save folders (detected paths are offered; Enter accepts), then:

1. copies the whitelisted game files into `game_files/game`
2. creates the test save template `game_files/save_template/game.sav` (`scripts/save_baseline.sav` plus the `[options]` of your `game.sav`)
3. downloads the UndertaleModTool GUI and CLI
4. decompiles `game_files/game/data.win` into `PicayuneDreams_extract` and checks it against `scripts/extract.sha256`

Finished steps are skipped; `--force` redoes them.

## Folders

| Folder | Committed | Contents |
| --- | --- | --- |
| `PicayuneDreams_extract/`           | no  | decompiled game code, never edited |
| `PicayuneDreams_edited/`            | yes | only the `.gml` files we changed (any subfolder) |
| `PicayuneDreams_new/`               | yes | `.gml` files that add new scripts, objects or events to the game |
| `game_files/game/`                      | no  | whitelisted, unmodified copy of the game install |
| `game_files_modded/`                    | no  | patched game output for testing |
| `UndertaleModTool_v*/`, `UTMT_CLI_v*/`  | no  | UndertaleModTool GUI and CLI |
| `logs/`                                 | no  | script output |

## Manual checks

These need `PicayuneDreams_extract/`, so they can't run in CI. Both accept
file names (`.gml` optional) or glob patterns to limit what they check.

```sh
uv run scripts/check_extract.py              # extract still matches scripts/extract.sha256?
uv run scripts/check_extract.py --update     # re-baseline after a fresh extract
uv run scripts/diff_edit.py                  # logs/diff/<file>.diff for every _edited file
uv run scripts/diff_edit.py "*skillpoint*" --print
```

## Building the patched game

```sh
uv run scripts/build.py                      # game_files/game + PicayuneDreams_edited -> game_files_modded/
uv run scripts/build.py --fresh-save         # also reset game_files_modded/save/game.sav from the template
```

## Tests

```sh
uv run pytest
```

GitHub Actions runs these on every push (`.github/workflows/tests.yml`).
