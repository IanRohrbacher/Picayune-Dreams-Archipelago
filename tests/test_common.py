from common import match_names

NAMES = ["obj_a.gml", "obj_b.gml", "scr_c.gml"]


def test_no_patterns_selects_everything():
    assert match_names(NAMES, []) == (NAMES, [])


def test_name_without_extension():
    assert match_names(NAMES, ["obj_a"]) == (["obj_a.gml"], [])


def test_glob_and_duplicates():
    assert match_names(NAMES, ["obj_*", "obj_a.gml"]) == (["obj_a.gml", "obj_b.gml"], [])


def test_path_uses_file_name():
    assert match_names(NAMES, ["some/dir/scr_c.gml"]) == (["scr_c.gml"], [])


def test_unmatched_pattern_is_reported():
    assert match_names(NAMES, ["nope"]) == ([], ["nope.gml"])
