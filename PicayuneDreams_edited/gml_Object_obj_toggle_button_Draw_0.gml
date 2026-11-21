var hover_alph = 1;

if (instance_place(x, y, obj_mouse))
{
    depth = dep - 1;
    
    if (hovering == false)
    {
        hovering = true;
        playsnd(global.sounds.snd_opt_rebind_select_option, 0.8, false, 0.3);
    }
    
    hover_alph = 0.6;
    
    if (mouse_check_button(mb_left) || global.gp_accept)
        hover_alph = 0.3;

    if (mouse_check_button_released(mb_left) || global.gp_accept_pressed)
    {
        // The click-to-restore-save and hold-to-nuke-save buttons are not supported by this Archipelago build.
        if (toggled == 0)
        {
            toggled = 1;
            
            if (variable == "christmas")
                global.event = 1;
            
            playsnd(global.sounds.snd_opt_toggle_true, 1, 0, 1);
        }
        else if (toggled == 1)
        {
            toggled = 0;
            
            if (variable == "christmas")
                global.event = 0;
            
            playsnd(global.sounds.snd_opt_toggle_false, 1, 0, 1);
        }
        
        ini_open(global.save_options);
        
        if (variable == "christmas")
            ini_write_real("other", "event", global.event);
        
        ini_close();
    }
}
else
{
    depth = dep;
    hovering = false;
}

if (toggled == false)
    ico_blend = 8421504;
else
    ico_blend = 16777215;

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_black, 1);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, hover_alph);
draw_sprite_ext(global.sprites.spr_toggle_icos, ico_ind, x, y, image_xscale, image_yscale, 0, ico_blend, 1);

if (hovering == true)
{
    draw_set_halign(fa_right);
    var rain = c_rainbow(get_timer() / 10000);
    
    outline_text_ext(string(title) + " [" + string(toggled) + "/1]", obj_mouse.x + 12, obj_mouse.y + 16, rain, 0, 1, -1, 99999, 1, 1, 0);
    
    outline_text_ext(string(desc), obj_mouse.x + 12, obj_mouse.y + 12 + 16, 16777215, 0, 1, -1, 200, 1, 1, 0);
    draw_set_halign(fa_left);
}
