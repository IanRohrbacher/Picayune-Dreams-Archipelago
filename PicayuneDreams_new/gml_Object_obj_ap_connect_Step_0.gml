if (instance_exists(obj_settings))
{
    focus_field(-1);
    exit;
}

if (state == "list")
{
    var max_scroll = max(0, array_length(infos) + 1 - 3);
    scroll = clamp(scroll + mouse_wheel_down() - mouse_wheel_up(), 0, max_scroll);
}

if (focus >= 0)
{
    if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V")))
        keyboard_string += clipboard_get_text();

    var text = string_replace_all(string_copy(keyboard_string, 1, max_length), chr(9), "");

    if (focus == 2)
        text = string_digits(text);

    fields[focus] = text;
    keyboard_string = text;

    if (keyboard_check_pressed(vk_tab) && state == "connect")
        focus_field(focus >= 4 ? 1 : focus + 1);

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
