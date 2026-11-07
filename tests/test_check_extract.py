from check_extract import compare, hash_dir, read_baseline, write_baseline


def test_hash_dir_uses_relative_posix_names(tmp_path):
    (tmp_path / "sub").mkdir()
    (tmp_path / "a.gml").write_text("x")
    (tmp_path / "sub" / "b.gml").write_text("y")

    assert sorted(hash_dir(tmp_path)) == ["a.gml", "sub/b.gml"]


def test_hash_dir_only_named_files(tmp_path):
    (tmp_path / "a.gml").write_text("x")
    (tmp_path / "b.gml").write_text("y")

    assert sorted(hash_dir(tmp_path, ["a.gml", "gone.gml"])) == ["a.gml"]


def test_baseline_round_trip(tmp_path):
    hashes = {"a.gml": "1" * 64, "b c.gml": "2" * 64}
    baseline = tmp_path / "extract.sha256"

    write_baseline(baseline, hashes)

    assert read_baseline(baseline) == hashes


def test_compare_reports_modified_missing_added():
    expected = {"same": "1", "changed": "2", "gone": "3"}
    actual = {"same": "1", "changed": "X", "new": "4"}

    assert compare(expected, actual) == (["changed"], ["gone"], ["new"])
