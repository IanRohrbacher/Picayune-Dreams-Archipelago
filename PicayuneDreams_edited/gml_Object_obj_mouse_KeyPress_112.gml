// The console opens with Tab + F1 only while dev tools are on.
if (global.ap_debug_tools)
{
    if (keyboard_check(vk_tab))
    {
        if (global.debug == false)
        {
            instance_create_depth(0, 0, -15001, obj_console);
            attempt_to_unlock_achievement("Im_in");
            global.debug = true;
            global.cheater = true;
            show_debug_overlay(true);
        }
        else
        {
            global.debug = false;
            global.cheater = true;
            instance_destroy(obj_console);
            show_debug_overlay(false);
        }
    }
}
