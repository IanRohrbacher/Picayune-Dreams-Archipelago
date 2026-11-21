// Wrapper for gm-apclientpp.dll (https://github.com/black-sliver/gm-apclientpp). The DLL sits next to the exe and
// its version is global.gm_apclientpp_version. Each apclient_* function below is one DLL call.

// Loads the DLL, defines every call and the AP_* constants, and starts the client library (API version 2,
// GMS2 string handling). Returns true when the DLL is ready; call it once at startup.
function apclient_setup()
{
    global.ap_dll_ready = false;
    global.apclient_dll = program_directory + "gm-apclientpp.dll";

    if (!file_exists(global.apclient_dll))
    {
        log("gm-apclientpp.dll not found next to the exe", 2);
        return false;
    }

    global.AP_RENDER_FORMAT_TEXT = 0;
    global.AP_RENDER_FORMAT_HTML = 1;
    global.AP_RENDER_FORMAT_ANSI = 2;
    global.AP_STATE_DISCONNECTED = 0;
    global.AP_STATE_SOCKET_CONNECTING = 1;
    global.AP_STATE_SOCKET_CONNECTED = 2;
    global.AP_STATE_ROOM_INFO = 3;
    global.AP_STATE_SLOT_CONNECTED = 4;
    global.AP_CLIENT_STATUS_UNKNOWN = 0;
    global.AP_CLIENT_STATUS_CONNECTED = 5;
    global.AP_CLIENT_STATUS_READY = 10;
    global.AP_CLIENT_STATUS_PLAYING = 20;
    global.AP_CLIENT_STATUS_GOAL = 30;
    global.AP_PERMISSION_DISABLED = 0;
    global.AP_PERMISSION_ENABLED = 1;
    global.AP_PERMISSION_GOAL = 2;
    global.AP_PERMISSION_FORCED = 4;
    global.AP_PERMISSION_AUTO = 6;
    global.AP_PERMISSION_AUTO_ENABLED = 7;
    global.AP_JSON_MISSING = -1;
    global.AP_JSON_OBJECT = 0;
    global.AP_JSON_ARRAY = 1;
    global.AP_JSON_STRING = 2;
    global.AP_JSON_NUMBER = 3;
    global.AP_JSON_NULL = 4;

    // [name, result type, argument types]
    var defs =
    [
        ["apclient_init", ty_real, [ty_real]],
        ["apclient_deinit", ty_real, []],
        ["apclient_connect", ty_real, [ty_string, ty_string, ty_string]],
        ["apclient_poll", ty_string, []],
        ["apclient_disconnect", ty_real, []],
        ["apclient_reset", ty_real, []],
        ["apclient_get_player_alias", ty_string, [ty_real]],
        ["apclient_get_player_game", ty_string, [ty_real]],
        ["apclient_get_game", ty_string, []],
        ["apclient_get_location_name", ty_string, [ty_real, ty_string]],
        ["apclient_get_location_id", ty_real, [ty_string]],
        ["apclient_get_item_name", ty_string, [ty_real, ty_string]],
        ["apclient_get_item_id", ty_real, [ty_string]],
        ["apclient_render_json", ty_string, [ty_string, ty_real]],
        ["apclient_get_state", ty_real, []],
        ["apclient_get_seed", ty_string, []],
        ["apclient_get_slot", ty_string, []],
        ["apclient_get_player_number", ty_real, []],
        ["apclient_get_team_number", ty_real, []],
        ["apclient_get_hint_points", ty_real, []],
        ["apclient_get_hint_cost_points", ty_real, []],
        ["apclient_get_hint_cost_percent", ty_real, []],
        ["apclient_is_data_package_valid", ty_real, []],
        ["apclient_get_server_time", ty_real, []],
        ["apclient_has_password", ty_real, []],
        ["apclient_get_permission", ty_real, [ty_string]],
        ["apclient_get_checked_locations", ty_string, []],
        ["apclient_get_checked_locations_json", ty_string, []],
        ["apclient_get_missing_locations", ty_string, []],
        ["apclient_get_missing_locations_json", ty_string, []],
        ["apclient_set_items_handling", ty_real, [ty_real]],
        ["apclient_set_version", ty_real, [ty_real, ty_real, ty_real]],
        ["apclient_say", ty_real, [ty_string]],
        ["apclient_connect_slot", ty_real, [ty_string, ty_string, ty_string]],
        ["apclient_connect_update_items_handling", ty_real, []],
        ["apclient_connect_update", ty_real, [ty_string]],
        ["apclient_sync", ty_real, []],
        ["apclient_status_update", ty_real, [ty_real]],
        ["apclient_location_checks", ty_real, [ty_string]],
        ["apclient_location_scouts", ty_real, [ty_string, ty_real]],
        ["apclient_bounce", ty_real, [ty_string]],
        ["apclient_set_bounce_targets", ty_real, [ty_string, ty_string, ty_string]],
        ["apclient_death_link", ty_real, [ty_string]],
        ["apclient_json_proxy", ty_real, [ty_real, ty_string]],
        ["apclient_json_exists", ty_real, [ty_real, ty_string]],
        ["apclient_json_typeof", ty_real, [ty_real]],
        ["apclient_json_size", ty_real, [ty_real]],
        ["apclient_json_get_string", ty_string, [ty_real]],
        ["apclient_json_string_at", ty_string, [ty_real, ty_string]],
        ["apclient_json_get_number", ty_real, [ty_real]],
        ["apclient_json_number_at", ty_real, [ty_real, ty_string]],
        ["apclient_json_dump", ty_string, [ty_real]],
        ["apclient_json_source", ty_string, []]
    ];

    global.apclient_ext = {};

    try
    {
        for (var i = 0; i < array_length(defs); i += 1)
            variable_struct_set(global.apclient_ext, defs[i][0], apclient_define(defs[i][0], defs[i][1], defs[i][2]));

        global.ap_dll_ready = apclient_init(202) > 0.5;
    }
    catch (error)
    {
        log("gm-apclientpp.dll could not be loaded: " + string(error), 2);
        return false;
    }

    log("gm-apclientpp " + global.gm_apclientpp_version + " loaded, ready=" + string(global.ap_dll_ready));
    return global.ap_dll_ready;
}

// external_define takes its argument types one by one, so each count has its own call.
function apclient_define(name, result, arg_types)
{
    var dll = global.apclient_dll;

    switch (array_length(arg_types))
    {
        case 0:
            return external_define(dll, name, dll_cdecl, result, 0);

        case 1:
            return external_define(dll, name, dll_cdecl, result, 1, arg_types[0]);

        case 2:
            return external_define(dll, name, dll_cdecl, result, 2, arg_types[0], arg_types[1]);

        default:
            return external_define(dll, name, dll_cdecl, result, 3, arg_types[0], arg_types[1], arg_types[2]);
    }
}

// Arrays go to the DLL as JSON text; wrappers accept either an array or ready-made JSON.
function apclient_json_arg(value)
{
    return is_array(value) ? json_stringify(value) : value;
}

function apclient_init(api_version)
{
    return external_call(global.apclient_ext.apclient_init, api_version);
}

function apclient_deinit()
{
    return external_call(global.apclient_ext.apclient_deinit);
}

function apclient_connect(uuid, game, host)
{
    return external_call(global.apclient_ext.apclient_connect, uuid, game, host);
}

function apclient_poll()
{
    return external_call(global.apclient_ext.apclient_poll);
}

function apclient_disconnect()
{
    return external_call(global.apclient_ext.apclient_disconnect);
}

function apclient_reset()
{
    return external_call(global.apclient_ext.apclient_reset);
}

function apclient_get_player_alias(slot)
{
    return external_call(global.apclient_ext.apclient_get_player_alias, slot);
}

function apclient_get_player_game(slot)
{
    return external_call(global.apclient_ext.apclient_get_player_game, slot);
}

function apclient_get_game()
{
    return external_call(global.apclient_ext.apclient_get_game);
}

function apclient_get_location_name(id, game)
{
    return external_call(global.apclient_ext.apclient_get_location_name, id, game);
}

function apclient_get_location_id(name)
{
    return external_call(global.apclient_ext.apclient_get_location_id, name);
}

function apclient_get_item_name(id, game)
{
    return external_call(global.apclient_ext.apclient_get_item_name, id, game);
}

function apclient_get_item_id(name)
{
    return external_call(global.apclient_ext.apclient_get_item_id, name);
}

function apclient_render_json(json, format)
{
    return external_call(global.apclient_ext.apclient_render_json, json, format);
}

function apclient_get_state()
{
    return external_call(global.apclient_ext.apclient_get_state);
}

function apclient_get_seed()
{
    return external_call(global.apclient_ext.apclient_get_seed);
}

function apclient_get_slot()
{
    return external_call(global.apclient_ext.apclient_get_slot);
}

function apclient_get_player_number()
{
    return external_call(global.apclient_ext.apclient_get_player_number);
}

function apclient_get_team_number()
{
    return external_call(global.apclient_ext.apclient_get_team_number);
}

function apclient_get_hint_points()
{
    return external_call(global.apclient_ext.apclient_get_hint_points);
}

function apclient_get_hint_cost_points()
{
    return external_call(global.apclient_ext.apclient_get_hint_cost_points);
}

function apclient_get_hint_cost_percent()
{
    return external_call(global.apclient_ext.apclient_get_hint_cost_percent);
}

function apclient_is_data_package_valid()
{
    return external_call(global.apclient_ext.apclient_is_data_package_valid);
}

function apclient_get_server_time()
{
    return external_call(global.apclient_ext.apclient_get_server_time);
}

function apclient_has_password()
{
    return external_call(global.apclient_ext.apclient_has_password);
}

function apclient_get_permission(key)
{
    return external_call(global.apclient_ext.apclient_get_permission, key);
}

// Returns GML text meant for execute_string, which GameMaker no longer has; use the _json call instead.
function apclient_get_checked_locations()
{
    return external_call(global.apclient_ext.apclient_get_checked_locations);
}

function apclient_get_checked_locations_json()
{
    return external_call(global.apclient_ext.apclient_get_checked_locations_json);
}

// Returns GML text meant for execute_string, which GameMaker no longer has; use the _json call instead.
function apclient_get_missing_locations()
{
    return external_call(global.apclient_ext.apclient_get_missing_locations);
}

function apclient_get_missing_locations_json()
{
    return external_call(global.apclient_ext.apclient_get_missing_locations_json);
}

function apclient_set_items_handling(items_handling)
{
    return external_call(global.apclient_ext.apclient_set_items_handling, items_handling);
}

function apclient_set_version(major, minor, revision)
{
    return external_call(global.apclient_ext.apclient_set_version, major, minor, revision);
}

function apclient_say(message)
{
    return external_call(global.apclient_ext.apclient_say, message);
}

function apclient_connect_slot(name, password, tags)
{
    return external_call(global.apclient_ext.apclient_connect_slot, name, password, apclient_json_arg(tags));
}

function apclient_connect_update_items_handling()
{
    return external_call(global.apclient_ext.apclient_connect_update_items_handling);
}

function apclient_connect_update(tags)
{
    return external_call(global.apclient_ext.apclient_connect_update, apclient_json_arg(tags));
}

function apclient_sync()
{
    return external_call(global.apclient_ext.apclient_sync);
}

function apclient_status_update(status)
{
    return external_call(global.apclient_ext.apclient_status_update, status);
}

function apclient_location_checks(locations)
{
    return external_call(global.apclient_ext.apclient_location_checks, apclient_json_arg(locations));
}

function apclient_location_scouts(locations, create_as_hints)
{
    return external_call(global.apclient_ext.apclient_location_scouts, apclient_json_arg(locations), create_as_hints);
}

function apclient_bounce(data)
{
    return external_call(global.apclient_ext.apclient_bounce, apclient_json_arg(data));
}

function apclient_set_bounce_targets(games, slots, tags)
{
    return external_call(global.apclient_ext.apclient_set_bounce_targets, apclient_json_arg(games), apclient_json_arg(slots), apclient_json_arg(tags));
}

function apclient_death_link(cause)
{
    return external_call(global.apclient_ext.apclient_death_link, cause);
}

function apclient_json_proxy(proxy, key)
{
    return external_call(global.apclient_ext.apclient_json_proxy, proxy, key);
}

function apclient_json_exists(proxy, key)
{
    return external_call(global.apclient_ext.apclient_json_exists, proxy, key);
}

function apclient_json_typeof(proxy)
{
    return external_call(global.apclient_ext.apclient_json_typeof, proxy);
}

function apclient_json_size(proxy)
{
    return external_call(global.apclient_ext.apclient_json_size, proxy);
}

function apclient_json_get_string(proxy)
{
    return external_call(global.apclient_ext.apclient_json_get_string, proxy);
}

function apclient_json_string_at(proxy, key)
{
    return external_call(global.apclient_ext.apclient_json_string_at, proxy, key);
}

function apclient_json_get_number(proxy)
{
    return external_call(global.apclient_ext.apclient_json_get_number, proxy);
}

function apclient_json_number_at(proxy, key)
{
    return external_call(global.apclient_ext.apclient_json_number_at, proxy, key);
}

function apclient_json_dump(proxy)
{
    return external_call(global.apclient_ext.apclient_json_dump, proxy);
}

function apclient_json_source()
{
    return external_call(global.apclient_ext.apclient_json_source);
}

// Handles the events the DLL has queued; call it every step. apclient_poll returns GML text for
// execute_string, which GameMaker no longer has, so each event is read from its JSON instead
// (apclient_json_source names the event, apclient_json_dump(0) holds its data).
function apclient_poll_events()
{
    if (!global.ap_dll_ready)
        return;

    for (var handled = 0; handled < 32; handled += 1)
    {
        apclient_poll();
        var source = apclient_json_source();

        if (source == "")
            break;

        var raw = apclient_json_dump(0);
        var data = {};

        try
        {
            data = json_parse(raw);
        }
        catch (error)
        {
            log("apclient: bad JSON for " + source + ": " + raw, 1);
        }

        switch (source)
        {
            case "ap_room_info":
                ap_on_room_info(data, raw);
                break;

            case "ap_slot_refused":
                ap_on_slot_refused(data, raw);
                break;

            case "ap_slot_connected":
                ap_on_slot_connected(data, raw);
                break;

            case "ap_items_received":
                ap_on_items_received(data, raw);
                break;

            case "ap_location_info":
                ap_on_location_info(data, raw);
                break;

            case "ap_location_checked":
                ap_on_location_checked(data, raw);
                break;

            case "ap_print_json":
                ap_on_print_json(data, raw);
                break;

            case "ap_socket_connected":
                ap_on_socket_connected(data, raw);
                break;

            case "ap_socket_disconnected":
                ap_on_socket_disconnected(data, raw);
                break;

            case "ap_socket_error":
                ap_on_socket_error(data, raw);
                break;

            case "ap_bounced":
                ap_on_bounced(data, raw);
                break;

            case "show_message":
                log("apclient: " + string(raw), 2);
                break;

            default:
                log("apclient: unhandled event " + source, 1);
                break;
        }
    }
}

// Event handlers: each one logs its event. The connection ones also set the connect state the connect
// screen shows (2 connected, 3 failed).
function ap_on_room_info(data, raw)
{
    log("apclient: room info received");
}

function ap_on_slot_refused(data, raw)
{
    var reasons = "";

    for (var i = 0; i < array_length(data.reasons); i += 1)
        reasons += ((i > 0) ? ", " : "") + string(data.reasons[i]);

    global.ap_connect_state = 3;
    global.ap_error = "Connection refused: " + reasons;
    log("apclient: slot refused: " + reasons, 1);
}

function ap_on_slot_connected(data, raw)
{
    global.ap_connect_state = 2;
    global.ap_slot_data = data;
    log("apclient: slot connected");
}

function ap_on_items_received(data, raw)
{
    log("apclient: " + string(data.len) + " item(s) received from index " + string(data.index));
}

function ap_on_location_info(data, raw)
{
    log("apclient: location info for " + string(data.len) + " location(s)");
}

function ap_on_location_checked(data, raw)
{
    log("apclient: " + string(data.len) + " location(s) checked");
}

function ap_on_print_json(data, raw)
{
    log("apclient: " + apclient_render_json(raw, global.AP_RENDER_FORMAT_TEXT));
}

function ap_on_socket_connected(data, raw)
{
    log("apclient: socket connected");
}

function ap_on_socket_disconnected(data, raw)
{
    log("apclient: socket disconnected", 1);
}

function ap_on_socket_error(data, raw)
{
    log("apclient: socket error: " + string(data.message), 1);
}

function ap_on_bounced(data, raw)
{
    log("apclient: bounced: " + raw);
}
