function ap_save_init()
{
    global.save_options = global.save_dir + "game.sav";
    global.save_slots_dir = global.save_dir + "slots/";

    if (!directory_exists(global.save_slots_dir))
        directory_create(global.save_slots_dir);

    global.ap_slot_key = "default";
    global.save = ap_slot_path(global.ap_slot_key);
}

function ap_slot_sanitize(text)
{
    var result = "";

    for (var i = 1; i <= string_length(text); i += 1)
    {
        var ch = string_char_at(text, i);

        if (string_letters(ch) != "" || string_digits(ch) != "" || ch == "-" || ch == "_")
            result += ch;
        else
            result += "_";
    }

    return result;
}

function ap_slot_key(host, port, slot)
{
    return ap_slot_sanitize(host) + "_" + ap_slot_sanitize(string(port)) + "_" + ap_slot_sanitize(slot);
}

function ap_slot_path(key)
{
    return global.save_slots_dir + key + ".sav";
}

function ap_slot_list()
{
    var keys = [];
    var file = file_find_first(global.save_slots_dir + "*.sav", 0);

    while (file != "")
    {
        array_push(keys, string_copy(file, 1, string_length(file) - 4));
        file = file_find_next();
    }

    file_find_close();
    return keys;
}

function ap_slot_exists(key)
{
    return file_exists(ap_slot_path(key));
}

function ap_slot_delete(key)
{
    if (ap_slot_exists(key))
        file_delete(ap_slot_path(key));
}

function ap_slot_select(key)
{
    global.ap_slot_key = key;
    global.save = ap_slot_path(key);
    ap_profile_load();
}

function ap_slot_info(key)
{
    ini_open(ap_slot_path(key));
    var info =
    {
        key: key,
        save_name: ini_read_string("archipelago", "save_name", key),
        host: ini_read_string("archipelago", "ap_host_name", ""),
        port: ini_read_string("archipelago", "ap_host_port", ""),
        slot: ini_read_string("archipelago", "ap_slot_name", ""),
        password: ini_read_string("archipelago", "ap_slot_password", ""),
        last_saved: ini_read_string("archipelago", "last_saved", ""),
        player_count: ini_read_real("archipelago", "player_count", 0),
        locations_checked: ini_read_real("archipelago", "locations_checked", 0),
        locations_total: ini_read_real("archipelago", "locations_total", 0),
        items_received: ini_read_real("archipelago", "items_received", 0),
        items_total: ini_read_real("archipelago", "items_total", 0),
        goal_progress: ini_read_real("archipelago", "goal_progress", 0),
        goal_total: ini_read_real("archipelago", "goal_total", 0)
    };
    ini_close();
    return info;
}

function ap_slot_infos(keys)
{
    var infos = [];

    for (var i = 0; i < array_length(keys); i += 1)
        array_push(infos, ap_slot_info(keys[i]));

    return infos;
}

function ap_pad2(value)
{
    return (value < 10 ? "0" : "") + string(value);
}

function ap_timestamp()
{
    var now = date_current_datetime();
    return ap_pad2(date_get_day(now)) + "-" + ap_pad2(date_get_month(now)) + "-" + string(date_get_year(now)) + " " + ap_pad2(date_get_hour(now)) + ":" + ap_pad2(date_get_minute(now));
}

function ap_profile_save_meta()
{
    ini_write_string("archipelago", "save_name", global.ap_save_name);
    ini_write_string("archipelago", "ap_slot_name", global.ap_slot_name);
    ini_write_string("archipelago", "ap_host_name", global.ap_host_name);
    ini_write_string("archipelago", "ap_host_port", global.ap_host_port);
    ini_write_string("archipelago", "ap_slot_password", global.ap_slot_password);
    ini_write_string("archipelago", "last_saved", ap_timestamp());
    var keys = ap_stats_keys();

    for (var i = 0; i < array_length(keys); i += 1)
        ini_write_real("archipelago", keys[i], variable_struct_get(global.ap_stats, keys[i]));
}

function ap_slot_write_meta()
{
    ini_open(global.save);
    ap_profile_save_meta();
    ini_close();
}

function ap_stats_keys()
{
    return ["player_count", "locations_checked", "locations_total", "items_received", "items_total", "goal_progress", "goal_total"];
}

function ap_stats_set(key, value)
{
    variable_struct_set(global.ap_stats, key, value);

    if (global.ap_slot_key != "default")
        ap_slot_write_meta();
}

function ap_profile_load()
{
    ini_open(global.save);
    global.profile_level = ini_read_real("stats", "profile_level", 1);
    global.profile_xp = ini_read_real("stats", "profile_xp", 0);
    global.total_runs = ini_read_real("stats", "total_runs", 0);
    global.prestige = ini_read_real("stats", "prestige", 0);
    global.game_level_cap = 25 + global.prestige;
    global.dialog_lastkilledby = ini_read_string("boss", "lastkilledby", "none");
    global.dialog_gremlin_visits = ini_read_real("boss", "gremlin_timesvisit", 0);
    global.dialog_worm_visits = ini_read_real("boss", "worm_timesvisit", 0);
    global.dialog_ghost_visits = ini_read_real("boss", "ghost_timesvisit", 0);
    global.dialog_biker_visits = ini_read_real("boss", "biker_timesvisit", 0);
    global.dialog_demon_visits = ini_read_real("boss", "demon_timesvisit", 0);
    global.dialog_picayune_visits = ini_read_real("boss", "picayune_timesvisit", 0);
    global.dialog_diver_visits = ini_read_real("boss", "diver_timesvisit", 0);
    global.dialog_umi_visits = ini_read_real("boss", "umi_timesvisit", 0);
    global.dialog_ab_gremlin_visits = ini_read_real("boss", "ab_gremlin_timesvisit", 0);
    global.dialog_ab_worm_visits = ini_read_real("boss", "ab_worm_timesvisit", 0);
    global.dialog_ab_biker_visits = ini_read_real("boss", "ab_biker_timesvisit", 0);
    global.dialog_ab_demon_visits = ini_read_real("boss", "ab_demon_timesvisit", 0);
    global.dialog_ab_picayune_visits = ini_read_real("boss", "ab_picayune_timesvisit", 0);
    global.bunny_memory = ini_read_real("boss", "bunny_memory", 0);
    global.worm_memory = ini_read_real("boss", "worm_memory", 0);
    global.biker_memory = ini_read_real("boss", "biker_memory", 0);
    global.demon_memory = ini_read_real("boss", "demon_memory", 0);
    global.grody_blackhole_touch = 0;
    global.has_beaten_game = ini_read_real("stats", "has_beaten_game", 0);
    global.has_seen_bad_ending = ini_read_real("stats", "has_seen_bad_ending", 0);
    global.ap_save_name = ini_read_string("archipelago", "save_name", "");
    global.ap_host_name = ini_read_string("archipelago", "ap_host_name", "");
    global.ap_host_port = ini_read_string("archipelago", "ap_host_port", "");
    global.ap_slot_name = ini_read_string("archipelago", "ap_slot_name", "");
    global.ap_slot_password = ini_read_string("archipelago", "ap_slot_password", "");
    global.ap_stats = {};
    var stat_keys = ap_stats_keys();

    for (var i = 0; i < array_length(stat_keys); i += 1)
        variable_struct_set(global.ap_stats, stat_keys[i], ini_read_real("archipelago", stat_keys[i], 0));

    ini_close();

    if (instance_exists(obj_stat_track))
        instance_destroy(obj_stat_track);

    instance_create_layer(0, 0, "Instances", obj_stat_track);
}
