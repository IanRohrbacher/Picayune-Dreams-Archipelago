if (instance_exists(obj_settings))
    exit;

draw_set_font(fnt_freddy);
var st = state;
var pressed = mouse_check_button_pressed(mb_left);
var field_clicked = false;

ap_ui_status();

if (st == "list")
{
    var count = array_length(infos) + 1;
    var act_delete = -1;
    var act_play = -1;
    var act_new = false;
    ap_ui_backdrop(172, 82, 788, 494, 0.55);
    ap_ui_heading(480, 52, "ARCHIPELAGO");

    for (var n = 0; n < 3; n += 1)
    {
        var idx = scroll + n;

        if (idx >= count)
            break;

        var top = 92 + (n * 120);
        ap_ui_panel(182, top, 754, top + 116, 1, ap_ui_green());

        if (idx < array_length(infos))
        {
            var info = infos[idx];
            ap_ui_text(192, top + 19, info.save_name, c_lime, fa_left);
            ap_ui_text(192, top + 43, "Last saved: " + info.last_saved, ap_ui_green(), fa_left);
            ap_ui_text(192, top + 67, "MultiWorld player count: " + string(info.player_count), ap_ui_green(), fa_left);
            ap_ui_text(743, top + 19, "Locations: " + string(info.locations_checked) + "/" + string(info.locations_total), ap_ui_green(), fa_right);
            ap_ui_text(743, top + 43, "Items: " + string(info.items_received) + "/" + string(info.items_total), ap_ui_green(), fa_right);
            ap_ui_text(743, top + 67, "Goal Progress: " + string(info.goal_progress) + "/" + string(info.goal_total), ap_ui_green(), fa_right);

            if (ap_ui_button(194, top + 81, 262, top + 108, (delete_armed == info.key) ? "Sure?" : "Delete", 70))
                act_delete = idx;

            if (ap_ui_button(602, top + 81, 742, top + 108, "Play", 110))
                act_play = idx;
        }
        else if (ap_ui_button(398, top + 45, 538, top + 72, "New Game", 110))
        {
            act_new = true;
        }
    }

    var thumb_h = 356;
    var thumb_y = 92;
    var max_scroll = max(0, count - 3);
    ap_ui_panel(758, 92, 778, 448, 0.5, ap_ui_dim());

    if (max_scroll > 0)
    {
        thumb_h = 356 * 3 / count;
        thumb_y = 92 + ((356 - thumb_h) * scroll / max_scroll);

        if (pressed && ap_ui_hover(758, 92, 778, 448))
            scroll = clamp(round(max_scroll * (device_mouse_y_to_gui(0) - 92) / 356), 0, max_scroll);
    }

    ap_ui_panel(758, thumb_y, 778, thumb_y + thumb_h, 1, ap_ui_green());

    if (ap_ui_button(638, 457, 778, 484, "Quit", 110))
        game_end();

    if (pressed && act_delete < 0)
        delete_armed = "";

    if (act_delete >= 0)
    {
        var key = infos[act_delete].key;

        if (delete_armed == key)
        {
            ap_slot_delete(key);
            delete_armed = "";
            refresh();
        }
        else
        {
            delete_armed = key;
        }
    }

    if (act_play >= 0)
        play(act_play);

    if (act_new)
        new_game();
}
else if (st == "name")
{
    ap_ui_heading(480, 190, "NEW GAME");
    ap_ui_panel(301, 223, 659, 317, 1, ap_ui_green());
    ap_ui_text(317, 237, "Save Name:", ap_ui_green(), fa_left);

    if (ap_ui_field(313, 250, 647, 278, fields[0], focus == 0, false))
    {
        focus_field(0);
        field_clicked = true;
    }

    if (ap_ui_button(316, 290, 403, 311, "Back", 70))
    {
        global.ap_error = "";
        state = "list";
        focus_field(-1);
    }

    if (ap_ui_button(526, 290, 643, 311, "Next", 110))
        go_next();
}
else if (st == "connect")
{
    ap_ui_heading(480, 100, "CONNECT");
    ap_ui_panel(301, 130, 659, 410, 1, ap_ui_green());
    var labels = ["", "Host Name:", "Port:", "Slot Name:", "Password:"];

    for (var f = 1; f <= 4; f += 1)
    {
        var fy = 144 + ((f - 1) * 60);
        ap_ui_text(317, fy, labels[f], ap_ui_green(), fa_left);

        if (ap_ui_field(313, fy + 13, 647, fy + 41, fields[f], focus == f, f == 4))
        {
            focus_field(f);
            field_clicked = true;
        }
    }

    if (ap_ui_button(316, 383, 403, 403, "Back", 70))
    {
        global.ap_error = "";
        state = editing ? "list" : "name";
        focus_field(editing ? -1 : 0);
    }

    if (ap_ui_button(526, 383, 643, 403, "Connect", 110))
        go_connect();
}
else if (st == "connecting")
{
    ap_ui_panel(301, 223, 659, 317, 1, ap_ui_green());
    ap_ui_text(480, 270, "Connecting...", c_lime, fa_center);
}

if (pressed && !field_clicked && (st == "name" || st == "connect"))
    focus_field(-1);

if (ap_ui_button(854, 500, 944, 527, "Settings", 70))
{
    instance_create_layer(global.screenh / 2, global.screenw / 2, "Instances", obj_settings);
    focus_field(-1);
}
