if (instance_exists(obj_settings))
{
    focus_field(-1);
    exit;
}

if (state == "list")
{
    var limit = scroll_limit();
    scroll_target += (mouse_wheel_down() - mouse_wheel_up()) * 60;

    if (ap_ui_repeat(key_timers, vk_down))
        scroll_target += 40;

    if (ap_ui_repeat(key_timers, vk_up))
        scroll_target -= 40;

    if (keyboard_check_pressed(vk_pagedown))
        scroll_target += 300;

    if (keyboard_check_pressed(vk_pageup))
        scroll_target -= 300;

    if (keyboard_check_pressed(vk_home))
        scroll_target = 0;

    if (keyboard_check_pressed(vk_end))
        scroll_target = limit;

    scroll_target = clamp(scroll_target, 0, limit);

    if (dragging)
    {
        scroll_px = scroll_target;
    }
    else
    {
        scroll_px += (scroll_target - scroll_px) * 0.25;

        if (abs(scroll_target - scroll_px) < 0.5)
            scroll_px = scroll_target;
    }
}

if (focus >= 0)
{
    fields[focus] = ap_ui_edit(edit, fields[focus], max_length, focus == 2, key_timers);

    if (keyboard_check_pressed(vk_tab) && state == "connect")
    {
        focus_field(focus >= 4 ? 1 : focus + 1);
        edit.anchor = 0;
    }

    if (keyboard_check_pressed(vk_enter))
    {
        if (state == "name")
            go_next();
        else if (state == "connect")
            go_connect();
    }
}

if (state == "connecting")
{
    connecting_timer += 1;

    if (connecting_timer > 30 && global.ap_connect_state != 1)
    {
        if (global.ap_connect_state == 2 || global.ap_connect_state == 4)
        {
            finish();
        }
        else
        {
            state = "connect";
            focus_field(1);
        }
    }
}
