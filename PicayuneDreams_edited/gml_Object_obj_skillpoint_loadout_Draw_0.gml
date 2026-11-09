draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, angl, c_white, alph);
draw_set_font(fnt_freddy);
draw_text_setup(65280, 0, 1, fnt_freddy);
draw_text_outline(x + 1, y - 4, string(loadout_num), -1, 9999, text_col, 0, 1);
draw_text_reset();

if (obj_skillpoint_menu.current_loadout == loadout_num)
    alph = 1;
else
    alph = 0.25;

if (instance_place(x, y, obj_mouse))
{
    depth = dep - 1;
    
    if (hovering == false)
    {
        hovering = true;
        playsnd(global.sounds.snd_opt_rebind_select_option, 0.8, false, 0.3);
    }
    
    alph = wave(0.6, 1, 0.25, 0);
    
    if (mouse_check_button_released(mb_left) || global.gp_accept_pressed)
    {
        if (obj_skillpoint_menu.current_loadout != loadout_num)
        {
            playsnd(global.sounds.snd_Upgrade_Purchase, 2, false, 0.5);
            playsnd(global.sounds.snd_Menu_Open_1, 2, false, 1);
            screenshake(10, 10);
            image_xscale = 0.25;
            image_yscale = 0.25;
            file_delete(global.save_dir + "loadout" + string(obj_skillpoint_menu.current_loadout));
            ini_open(global.save_dir + "loadout" + string(obj_skillpoint_menu.current_loadout));
            var skillc = instance_number(obj_skillpoint) + 1;
            var skill = -4;
            
            for (var i = 0; i < skillc; i += 1)
            {
                skill = instance_nth_nearest(obj_skillpoint_menu.x_offset + 478, obj_skillpoint_menu.y_offset + 270, obj_skillpoint, i);
                
                if (instance_exists(skill))
                {
                    with (skill)
                    {
                        if (points_spent > 0)
                            ini_write_real("skills", skillname, 1);
                    }
                }
            }
            
            ini_write_real("skills", "skillpointsspent", global.points_spent);
            ini_close();
            
            with (obj_skillpoint)
            {
                if (points_spent > 0)
                {
                    points_spent = 0;
                    skill_inc(-1);
                }
            }
            
            global.points_spent = 0;
            ini_open(global.save_dir + "loadout" + string(loadout_num));
            
            with (obj_skillpoint_loadout)
                alarm[0] = 1;
            
            skillc = instance_number(obj_skillpoint) + 1;
            skill = -4;
            
            for (var i = 0; i < skillc; i += 1)
            {
                skill = instance_nth_nearest(obj_skillpoint_menu.x_offset + 478, obj_skillpoint_menu.y_offset + 270, obj_skillpoint, i);
                
                if (instance_exists(skill))
                {
                    with (skill)
                    {
                        var has_skill = ini_read_real("skills", skillname, 0);
                        
                        if (has_skill > 0 && points_spent == 0 && global.points_spent < global.points_avaliable)
                        {
                            global.points_spent += 1;
                            points_spent = 1;
                            skill_inc(1);
                        }
                    }
                }
            }
            
            ini_close();
            var lvl_up_eff = instance_create_depth(global.screenw / 2, global.screenh / 2, -9999, obj_anim_delete);
            lvl_up_eff.sprite_index = global.sprites.spr_screen_upgrade_grid;
            obj_skillpoint_menu.current_loadout = loadout_num;
            ini_open(global.save);
            ini_write_real("stats", "loadout", obj_skillpoint_menu.current_loadout);
            ini_close();
        }
    }
    else
    {
        title = "Loadout " + string(loadout_num);
        
        if (obj_skillpoint_menu.current_loadout != loadout_num)
        {
            if (global.points_avaliable >= skillpointsspent)
            {
                desc = "Swap to Loadout " + string(loadout_num) + "?\n[" + string(skillpointsspent) + "/" + string(global.points_avaliable) + "] points spent!";
                text_col = 65280;
            }
            else
            {
                text_col = 255;
                desc = "Swap to Loadout " + string(loadout_num) + "?\n<!> [" + string(skillpointsspent) + "/" + string(global.points_avaliable) + "] points spent, but you have less available! Be afraid!";
            }
        }
        else
        {
            desc = "[SELECTED]!";
        }
    }
}
else
{
    title = "Loadout " + string(loadout_num);
    
    if (obj_skillpoint_menu.current_loadout != loadout_num)
    {
        if (global.points_avaliable >= skillpointsspent)
        {
            desc = "Swap to Loadout " + string(loadout_num) + "?\n[" + string(skillpointsspent) + "/" + string(global.points_avaliable) + "] points spent!";
            text_col = 65280;
        }
        else
        {
            text_col = 255;
            desc = "Swap to Loadout " + string(loadout_num) + "?\n<!> [" + string(skillpointsspent) + "/" + string(global.points_avaliable) + "] points spent, but you have less available! Be afraid!";
        }
    }
    else
    {
        desc = "[SELECTED]!";
    }
    
    depth = dep;
    hovering = false;
}

if (hovering == true)
{
    draw_set_halign(fa_right);
    outline_text_ext(string(title), obj_mouse.x + 12, obj_mouse.y + 16, text_col, 0, 1, -1, 99999, 1, 1, 0);
    outline_text_ext(string(desc), obj_mouse.x + 12, obj_mouse.y + 12 + 16, 16777215, 0, 1, -1, 200, 1, 1, 0);
    draw_set_halign(fa_left);
}
