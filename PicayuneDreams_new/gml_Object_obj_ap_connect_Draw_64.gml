if (instance_exists(obj_settings))
    exit;

draw_set_font(fnt_freddy);
var st = state;
var pressed = mouse_check_button_pressed(mb_left);
var field_clicked = false;

global.ap_ui_captured = dragging || edit.dragging;
ap_ui_status();

if (st == "list")
{
    var count = array_length(infos) + 1;
    var limit = scroll_limit();
    var offset = round(scroll_px);
    var act_delete = -1;
    var act_play = -1;
    var act_new = false;
    ap_ui_nine(160, 70, 800, 502, 1);
    ap_ui_heading(480, 38, "ARCHIPELAGO");

    var view_x = 182;
    var view_y = 92;
    var view_w = 573;
    var view_h = 357;

    ap_ui_backdrop(180, 90, 756, 450, 0.3);

    if (!surface_exists(list_surface))
        list_surface = surface_create(view_w * 2, view_h * 2);

    surface_set_target(list_surface);
    draw_clear_alpha(c_black, 0);
    gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha);
    matrix_set(matrix_world, matrix_build(-view_x * 2, -view_y * 2, 0, 0, 0, 0, 2, 2, 1));
    global.ap_ui_clip_y1 = view_y;
    global.ap_ui_clip_y2 = view_y + view_h - 1;

    for (var idx = 0; idx < count; idx += 1)
    {
        var top = 92 + (idx * card_pitch) - offset;

        if (top + card_h < view_y || top > view_y + view_h)
            continue;

        ap_ui_nine(182, top, 754, top + card_h, 1);

        if (idx < array_length(infos))
        {
            var info = infos[idx];
            ap_ui_text(192, top + 19, info.save_name, c_lime, fa_left);
            ap_ui_text(743, top + 19, "Locations: " + string(info.locations_checked) + "/" + string(info.locations_total), ap_ui_green(), fa_right);
            ap_ui_text(192, top + 43, "Last saved: " + info.last_saved, ap_ui_green(), fa_left);
            ap_ui_text(743, top + 43, "Items: " + string(info.items_received) + "/" + string(info.items_total), ap_ui_green(), fa_right);
            ap_ui_text(192, top + 67, "MultiWorld player count: " + string(info.player_count), ap_ui_green(), fa_left);
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

    global.ap_ui_clip_y1 = -100000;
    global.ap_ui_clip_y2 = 100000;
    matrix_set(matrix_world, matrix_build_identity());
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
    draw_surface_ext(list_surface, view_x, view_y, 0.5, 0.5, 0, c_white, 1);
    gpu_set_blendmode(bm_normal);
    ap_ui_border(178, 88, 758, 452);

    var thumb_h = 356;
    var thumb_y = 92;
    ap_ui_panel(762, 92, 782, 448, 0.5, ap_ui_dim());

    if (limit > 0)
    {
        thumb_h = max(30, 356 * 356 / (limit + 356));
        thumb_y = 92 + ((356 - thumb_h) * scroll_px / limit);
        var mouse_y_gui = device_mouse_y_to_gui(0);

        if (pressed && ap_ui_hover(762, 92, 782, 448))
        {
            if (mouse_y_gui >= thumb_y && mouse_y_gui <= thumb_y + thumb_h)
            {
                dragging = true;
                drag_offset = mouse_y_gui - thumb_y;
            }
            else
            {
                scroll_target = clamp(scroll_target + ((mouse_y_gui < thumb_y) ? -300 : 300), 0, limit);
            }
        }

        if (dragging && !mouse_check_button(mb_left))
            dragging = false;

        if (dragging)
        {
            var travel = 356 - thumb_h;
            scroll_target = clamp(((mouse_y_gui - 92 - drag_offset) / travel) * limit, 0, limit);
            scroll_px = scroll_target;
            thumb_y = 92 + (travel * scroll_px / limit);
        }
    }

    ap_ui_panel(762, thumb_y, 782, thumb_y + thumb_h, 1, (dragging || ap_ui_hover(762, thumb_y, 782, thumb_y + thumb_h)) ? c_lime : ap_ui_green());

    if (ap_ui_button(642, 457, 782, 484, "Quit", 110))
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

    if (ap_ui_field(313, 250, 647, 278, fields[0], focus == 0, false, edit))
    {
        click_field(0);
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

        if (ap_ui_field(313, fy + 13, 647, fy + 41, fields[f], focus == f, f == 4, edit))
        {
            click_field(f);
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
