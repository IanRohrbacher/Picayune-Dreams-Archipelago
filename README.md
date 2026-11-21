# Picayune-Dreams-Archipelago

## Setup

Requires [uv](https://docs.astral.sh/uv/).

```sh
uv sync
uv run scripts/setup.py
```

`setup.py` asks for the game install and save folders (detected paths are offered; Enter accepts), then:

1. copies the whitelisted game files into `game_files/game`
2. copies your whole save folder into `game_files/save` (the real one is only read)
3. downloads the `gm-apclientpp` release named by `global.gm_apclientpp_version` in `obj_init` into `game_files/gm-apclientpp/<tag>`
4. downloads the UndertaleModTool GUI and CLI
5. decompiles `game_files/game/data.win` into `PicayuneDreams_extract` and checks it against `scripts/extract.sha256`

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
uv run scripts/build.py --fresh-save         # also delete game_files_modded/save/ (game starts from its defaults)
uv run scripts/build.py --transfer-options   # also copy your [options] from game_files/save/game.sav, leaving other saves alone
```

The build also copies `gm-apclientpp.dll` (the release set by `global.gm_apclientpp_version` in `obj_init`, downloaded
by `setup.py`) into `game_files_modded/`, but only when it is missing or a different release is installed there.
To use another release, change that tag and run `uv run scripts/setup.py` to download it.

## Tests

```sh
uv run pytest
```

GitHub Actions runs these on every push (`.github/workflows/tests.yml`).
