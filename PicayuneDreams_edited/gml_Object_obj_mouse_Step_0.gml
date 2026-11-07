var camgetx = global.camx;
var camgety = global.camy;
var screenwid = global.screenw;
var screenhig = global.screenh;
x = clamp(x, camgetx, camgetx + screenwid);
y = clamp(y, camgety, camgety + screenhig);

if (global.gp_autoaimdeadzone == true)
{
    if ((abs(global.r_analog_h) + abs(global.r_analog_v)) == 0)
        autoaim_gamepad = true;
    else
        autoaim_gamepad = false;
}

if (global.using_gamepad == false)
{
    if (keyboard_check_pressed(global.kb_togaa) && !instance_exists(obj_settings))
        autoaim_mouse = !autoaim_mouse;
    
    if (autoaim_mouse == false)
    {
        x = mouse_x;
        y = mouse_y;
        allow_auto_aim = false;
    }
    else if (room != rm_test || obj_control.levelupscreen == true || instance_exists(obj_settings) || global.paused == true)
    {
        x = mouse_x;
        y = mouse_y;
        allow_auto_aim = false;
    }
    else
    {
        allow_auto_aim = true;
    }
}
else
{
    if (gamepad_button_check_pressed(0, global.gpd_togaa) && !instance_exists(obj_settings))
        autoaim_gamepad = !autoaim_gamepad;
    
    if (room != rm_test || (room == rm_test && obj_control.levelupscreen == true) || instance_exists(obj_settings) || global.paused == true)
    {
        var move_power = global.gpd_sens;
        var movemod_x = clamp(global.l_analog_h, -1, 1);
        var movemod_y = clamp(global.l_analog_v, -1, 1);
        x += (movemod_x * move_power);
        y += (movemod_y * move_power);
        allow_auto_aim = false;
        
        if (global.gp_allowmouse == true && obj_gamepad_manager.moving_mouse == true)
        {
            x = mouse_x;
            y = mouse_y;
            var haxis = abs(movemod_x);
            var vaxis = abs(movemod_y);
            var axistotl = movemod_x + movemod_y;
            
            if (axistotl > 0.15)
            {
                obj_gamepad_manager.cur_mouse_x = mouse_x - global.camx;
                obj_gamepad_manager.cur_mouse_y = mouse_y - global.camy;
                gamepad_goal_x = x;
                gamepad_goal_y = y;
            }
        }
    }
    else if (autoaim_gamepad == false)
    {
        if (instance_exists(obj_player))
        {
            allow_auto_aim = false;
            
            if (point_distance(0, 0, 0 + (global.r_analog_h * 30), 0 + (global.r_analog_v * 30)) > 5)
            {
                gamepad_goal_x = global.r_analog_h;
                gamepad_goal_y = global.r_analog_v;
            }
            
            var gp_pd = point_direction(0, 0, 0 + gamepad_goal_x, 0 + gamepad_goal_y);
            stick_direction = approach_the_angle(stick_direction, gp_pd, 1 + abs(angle_difference(stick_direction, gp_pd) / 3));
            care_about_hori = lengthdir_x(150, stick_direction);
            care_about_vert = lengthdir_y(150, stick_direction);
            
            if (obj_gamepad_manager.moving_mouse == true && global.gp_allowmouse == true)
            {
                x = mouse_x;
                y = mouse_y;
            }
            else
            {
                x = obj_player.x + care_about_hori;
                y = obj_player.y + care_about_vert;
            }
        }
    }
    else
    {
        allow_auto_aim = true;
    }
}

if (room == rm_test && allow_auto_aim == true)
{
    if ((autoaim_mouse == true && global.using_gamepad == false) || (autoaim_gamepad == true && global.using_gamepad == true))
    {
        obj_control.has_used_autoaim = true;
        using_autoaim = true;
        x = clamp(x, camgetx + 8, (camgetx + screenwid) - 8);
        y = clamp(y, camgety + 8, (camgety + screenhig) - 8);
        var nearenem = -4;
        
        if (instance_exists(obj_enemy_parent))
            nearenem = instance_nearest(obj_player.x, obj_player.y, obj_enemy_parent);
        
        if (nearenem != -4)
        {
            var gs = clamp(obj_control.gameSpeed, 1, 999);
            var distance_to_en = point_distance(x, y, nearenem.x, nearenem.y);
            x = approach(x, nearenem.x, (5 + (distance_to_en / 10)) * gs);
            y = approach(y, nearenem.y, (5 + (distance_to_en / 10)) * gs);
            monster_name = object_get_name(nearenem.object_index);
        }
        else
        {
            x = approach(x, obj_player.x + lengthdir_x(64, get_timer() / 10000), 10);
            y = approach(y, obj_player.y + lengthdir_y(64, get_timer() / 10000), 10);
            monster_name = "";
        }
    }
    else
    {
        using_autoaim = false;
    }
}
else
{
    using_autoaim = false;
}

steam_update();

if (steam_is_screenshot_requested())
{
    var file = global.save_dir + "PICAYUNE_DREAMS_" + string(date_get_second(date_current_datetime())) + string(global.day) + string(global.month) + string(global.year) + string(irandom(999999)) + ".png";
    screen_save(file);
    steam_send_screenshot(file, window_get_width(), window_get_height());
}

if (global.steam_api == 2)
{
}
else if (global.steam_api == 0)
{
    if (steam_initialised())
    {
        global.steam_api = 1;
        show_debug_message("STEAM LINKED!!!");
    }
}
else if (global.steam_api == 1)
{
    if (steam_stats_ready())
    {
        global.steam_api = 2;
        show_debug_message("STEAM STATS LINKED!!!");
        attempt_to_unlock_achievement("Hello_World");
    }
}
