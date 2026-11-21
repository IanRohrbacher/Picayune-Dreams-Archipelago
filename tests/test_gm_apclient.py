import common
import pytest
import setup


def write_init(tmp_path, text):
    path = tmp_path / "init.gml"
    path.write_text(text)
    return path


def test_read_version_finds_the_tag_among_other_globals(tmp_path):
    init = write_init(tmp_path, 'global.ap_version = "AP 1";\nglobal.gm_apclientpp_version = "v0.6.6";\n')

    assert common.read_gm_apclient_version(init) == "v0.6.6"


def test_read_version_accepts_spaces_and_crlf(tmp_path):
    init = write_init(tmp_path, 'global.gm_apclientpp_version   =   "v0.7.0-rc1" ;\r\n')

    assert common.read_gm_apclient_version(init) == "v0.7.0-rc1"


def test_read_version_needs_the_variable(tmp_path):
    init = write_init(tmp_path, 'global.ap_version = "AP 1";\n')

    with pytest.raises(ValueError, match="gm_apclientpp_version"):
        common.read_gm_apclient_version(init)


@pytest.mark.parametrize("tag", ["", "../x", "v1/../../x", "v1 0", "v1.0.0?x=1"])
def test_read_version_rejects_tags_that_are_not_safe_in_a_url_or_folder(tmp_path, tag):
    init = write_init(tmp_path, f'global.gm_apclientpp_version = "{tag}";\n')

    with pytest.raises(ValueError, match="invalid"):
        common.read_gm_apclient_version(init)


def test_the_real_init_file_sets_a_release_tag():
    assert common.read_gm_apclient_version().startswith("v")


def test_install_downloads_the_win64_release_of_the_tag(tmp_path, monkeypatch):
    calls = []
    monkeypatch.setattr(setup, "GM_APCLIENT_DIR", tmp_path / "apclient")
    monkeypatch.setattr(setup, "download_zip", lambda *args: calls.append(args))

    setup.install_gm_apclient("v0.6.6", force=False)

    url = "https://github.com/black-sliver/gm-apclientpp/releases/download/v0.6.6/gm-apclientpp-win64.zip"
    assert calls == [(url, tmp_path / "apclient" / "v0.6.6", "gm-apclientpp.dll", False)]


def test_install_passes_force_on(tmp_path, monkeypatch):
    calls = []
    monkeypatch.setattr(setup, "GM_APCLIENT_DIR", tmp_path)
    monkeypatch.setattr(setup, "download_zip", lambda *args: calls.append(args))

    setup.install_gm_apclient("v1.0.0", force=True)

    assert calls[0][3] is True
