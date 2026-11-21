if (!instance_exists(obj_settings))
{
    if (instance_place(x, y, obj_mouse))
    {
        if (hover == false)
            scale = 0.9;
        
        hover = true;
        
        if (sprite_index != highspr)
        {
            sprite_index = highspr;
            playsnd_at(global.sounds.snd_menu_hover, 1, false, 1, obj_mouse.x, obj_mouse.y);
        }
        
        if (mouse_check_button_released(mb_left) || global.gp_accept_released)
        {
            playsnd_at(global.sounds.snd_menu_click, 1, false, 1, obj_mouse.x, obj_mouse.y, 0);
            
            if (locked == false)
            {
                // room buttons
                if (butt == "start")
                {
                    var ftr = instance_create_depth(x, y, -99999999, obj_fadetoroom);
                    ftr.rm = rm_fadetogame;
                    global.gamestart_ind = 0;
                    global.gamemode = "normal";
                }
                
                if (butt == "credits")
                {
                    var ftr = instance_create_depth(x, y, -99999999, obj_fadetoroom);
                    ftr.rm = rm_credits;
                }
                
                if (butt == "loadout")
                {
                    var ftr = instance_create_depth(x, y, -99999999, obj_fadetoroom);
                    ftr.rm = rm_loadout;
                }
                
                if (butt == "collection")
                {
                    var ftr = instance_create_depth(x, y, -99999999, obj_fadetoroom);
                    ftr.rm = rm_collection;
                }
                
                if (butt == "config")
                    instance_create_layer(global.screenh / 2, global.screenw / 2, "Instances", obj_settings);
                
                // Exit returns to the slot screen in debug mode and quits the game otherwise.
                if (butt == "exit")
                    if (global.ap_debug_tools) {
                        ap_connect_cancel();
                        var ftr = instance_create_depth(x, y, -99999999, obj_fadetoroom);
                        ftr.rm = rm_ap_connect;
                    } else 
                        game_end();
            }
        }
    }
    else
    {
        hover = false;
        
        if (sprite_index != idlespr)
            sprite_index = idlespr;
    }
}

if (locked == true)
    image_blend = c_gray;

scale = approach(scale, 1, 0.025);
draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, image_angle, image_blend, image_alpha);
