function scr_rightsideupgrade(arg0)
{
    var width_of_screen = global.screenw;
    var height_of_screen = global.screenh;
    var var_Camx = global.camx;
    var var_Camy = global.camy;
    var newmovepoint;
    
    if (arg0 == "upgrade")
    {
        newmovepoint = upgrade_menu_move;
        showtabmen = false;
    }
    else
    {
        newmovepoint = tabmenuprog;
        showtabmen = true;
    }
    
    var true_bgleftx = width_of_screen - ((sprite_get_width(global.sprites.spr_bodyscan) / 2) + 20);
    var show_bgleftx = (true_bgleftx - 9) + (9 / newmovepoint);
    draw_sprite_ext(bodyscan_sprite, bodyscan_img_index, show_bgleftx, (height_of_screen / 2) + 6, 1, 1, 0, c_white, 1);
    bodyscan_img_index = draw_animated_index(bodyscan_img_index, 1, bodyscan_sprite);
    
    if (bodyscan_phase == -1)
    {
        bodyscan_sprite = global.sprites.spr_bodyscan_spawn;
        
        if (bodyscan_img_index == (sprite_get_number(bodyscan_sprite) - 1))
        {
            bodyscan_phase = 0;
            bodyscan_sprite = global.sprites.spr_bodyscan;
        }
    }
    
    var banned_len = ds_list_size(obj_control.ban_list);
    
    if (banned_len > 0)
    {
        for (var i = 0; i < banned_len; i += 1)
        {
            hue = 700;
            hue_start();
            var find_item = ds_list_find_value(obj_control.ban_list, i);
            var item_sprite_holo = ds_list_find_value(find_item, 4);
            draw_sprite_ext(item_sprite_holo, get_timer() / 100000, show_bgleftx - 258, height_of_screen - (22 + (26 * i)), 0.25, 0.25, image_angle, c_lime, 1);
            hue_end();
        }
    }
    
    draw_text_setup(65280, 2, 0, fnt_freddy);
    var equipped_len = ds_list_size(obj_player.equipped_items);
    
    if (equipped_len > 0)
    {
        var nearplayerr = instance_nearest(x, y, obj_player);
        var getted_timer = get_timer() / 100000;
        var wav = 0;
        
        if (equipped_len > 14)
        {
            var amm = equipped_len - 14;
            wav = wave(0, amm * 26, 20, 0);
        }
        
        for (var i = 0; i < equipped_len; i += 1)
        {
            var find_item = ds_list_find_value(obj_player.equipped_items, i);
            var get_equip_spr = ds_list_find_value(find_item, 6);
            
            if (get_equip_spr != -1)
                draw_sprite_ext(get_equip_spr, 4, show_bgleftx, height_of_screen / 2, 1, 1, 0, c_white, 0.5);
            
            var item_sprite_holo = ds_list_find_value(find_item, 4);
            var item_sprite_solid = ds_list_find_value(find_item, 5);
            draw_sprite_ext(item_sprite_holo, getted_timer, show_bgleftx - 160, (wav + height_of_screen) - (22 + (26 * i)), 0.25, 0.25, image_angle, image_blend, wave(1, 0, 5, i / 15));
            draw_sprite_ext(item_sprite_solid, getted_timer, show_bgleftx - 160, (wav + height_of_screen) - (22 + (26 * i)), 0.25, 0.25, image_angle, image_blend, wave(0, 1, 5, i / 15));
            var upgrade_index = ds_list_find_value(find_item, 2);
            var upgrade_name = variable_instance_get(nearplayerr, upgrade_index);
            draw_text_outline(show_bgleftx - 140, (wav + height_of_screen) - (4 + (26 * i)), "x" + string(upgrade_name), -1, 999, 65280, 0, 1);
            var get_weapon_id = ds_list_find_value(find_item, 7);
            
            if (get_weapon_id > 0 && get_weapon_id < 9999)
            {
                var dps = ds_list_find_value(find_item, 11);
                var get_weapon_kills = get_weapon_stat(get_weapon_id, 1);
                draw_set_halign(fa_right);
                draw_text_outline(show_bgleftx - 190, (wav + height_of_screen) - (4 + (26 * i)), "DPS: " + string(dps), -1, 999, 65280, 0, 1);
                draw_text_outline(show_bgleftx - 190, (wav + height_of_screen) - (12 + (26 * i)), "KILL: " + string(get_weapon_kills), -1, 999, 65280, 0, 1);
                draw_set_halign(fa_left);
            }
        }
        
        draw_text_outline(show_bgleftx - 175, (wav + height_of_screen) - (4 + (26 * equipped_len)), "max(" + string(equipped_len) + "," + string(obj_control.max_items) + ");", -1, 999, 65280, 0, 1);
    }
    
    draw_text_setup(65280, 0, 0, fnt_freddy);
    var addmod = 19;
    var appspd = 2;
    var bodyscan_x = 755.5 + (9 / newmovepoint);
    obj_control.hp_mod = return_percent(1, global.hpmax, obj_control.default_hp);
    obj_control.spd_mod = return_percent(1, obj_player.spd_max, obj_control.default_spd);
    obj_control.scale_mod = return_percent(1, obj_player.weapon_size_final, 1);
    obj_control.pickup_mod = return_percent(1, obj_player.pickupradius, obj_player.pickupradius_start);
    obj_control.cd_mod = return_percent(1, obj_player.cooldown_mod_final, 1);
    obj_control.projspd_mod = return_percent(1, obj_player.projectile_spd_final, 1);
    hpstat = approach(hpstat, return_percent(176, obj_control.hp_mod, 4), appspd);
    draw_sprite_part_ext(global.sprites.spr_bodyscan_stat, 0, 0, 0, hpstat, 12, bodyscan_x, 411, 1, 1, c_white, 1);
    spdstat = approach(spdstat, return_percent(176, obj_control.spd_mod, 4), appspd);
    draw_sprite_part_ext(global.sprites.spr_bodyscan_stat, 0, 0, 0, spdstat, 12, bodyscan_x, 411 + (addmod * 1), 1, 1, c_white, 1);
    scalestat = approach(scalestat, return_percent(176, obj_control.scale_mod, 4), appspd);
    draw_sprite_part_ext(global.sprites.spr_bodyscan_stat, 0, 0, 0, scalestat, 12, bodyscan_x, 411 + (addmod * 2), 1, 1, c_white, 1);
    pickstat = approach(pickstat, return_percent(176, obj_control.pickup_mod, 4), appspd);
    draw_sprite_part_ext(global.sprites.spr_bodyscan_stat, 0, 0, 0, pickstat, 12, bodyscan_x, 411 + (addmod * 3), 1, 1, c_white, 1);
    cdstat = approach(cdstat, return_percent(176, obj_control.cd_mod, 4), appspd);
    draw_sprite_part_ext(global.sprites.spr_bodyscan_stat, 0, 0, 0, cdstat, 12, bodyscan_x, 411 + (addmod * 4), 1, 1, c_white, 1);
    projspdstat = approach(projspdstat, return_percent(176, obj_control.projspd_mod, 4), appspd);
    draw_sprite_part_ext(global.sprites.spr_bodyscan_stat, 0, 0, 0, projspdstat, 12, bodyscan_x, 411 + (addmod * 5), 1, 1, c_white, 1);
    outline_text(string(global.hpmax) + "%", bodyscan_x + 2, 413, 65280, 0, 1, -1, 9999);
    outline_text(string(floor((obj_control.spd_mod / 1) * 100)) + "%", bodyscan_x + 2, 413 + (addmod * 1), 65280, 0, 1, -1, 9999);
    outline_text(string(floor((obj_control.scale_mod / 1) * 100)) + "%", bodyscan_x + 2, 413 + (addmod * 2), 65280, 0, 1, -1, 9999);
    outline_text(string(floor((obj_control.pickup_mod / 1) * 100)) + "%", bodyscan_x + 2, 413 + (addmod * 3), 65280, 0, 1, -1, 9999);
    outline_text(string(floor((obj_control.cd_mod / 1) * 100)) + "%", bodyscan_x + 2, 413 + (addmod * 4), 65280, 0, 1, -1, 9999);
    outline_text(string(floor((obj_control.projspd_mod / 1) * 100)) + "%", bodyscan_x + 2, 413 + (addmod * 5), 65280, 0, 1, -1, 9999);
    draw_set_color(c_white);
    
    if (upgrade_hover_preview_sprite != -1)
    {
        draw_sprite_ext(upgrade_hover_preview_sprite, upgrade_hover_preview_index, show_bgleftx, height_of_screen / 2, 1, 1, 0, c_black, 1);
        draw_sprite_ext(upgrade_hover_preview_sprite, upgrade_hover_preview_index, show_bgleftx, height_of_screen / 2, 1, 1, 0, c_white, wave(0.5, 1, 0.5, 0));
        upgrade_hover_preview_index = approach(upgrade_hover_preview_index, sprite_get_number(upgrade_hover_preview_sprite) - 1, 0.25);
    }
    
    if (global.debug == true)
    {
        var gap_between = 17;
        var but_amm = 16;
        var get_visual_alph = 1;
        var allow_hold = false;
        
        for (var i = 0; i < but_amm; i += 1)
        {
            var cheat_butt_x = ((width_of_screen / 2) + (i * gap_between)) - (but_amm * (gap_between / 2));
            var cheat_butt_y = height_of_screen - (32 + wave(-1, 1, 2, i / 10));
            var image_alph = 0.5;
            
            if (point_in_rectangle(mouse_x, mouse_y, (var_Camx + cheat_butt_x) - 8, (var_Camy + cheat_butt_y) - 8, var_Camx + cheat_butt_x + 8, var_Camy + cheat_butt_y + 8))
            {
                image_alph = 1;
                var cam_get_x = camera_get_view_x(view_camera[0]);
                var cam_get_y = camera_get_view_y(view_camera[0]);
                var realmousexx = mouse_x - cam_get_x;
                var realmouseyy = mouse_y - cam_get_y;
                var title = "TITLE!";
                var desc = "Test";
                
                if (i == 0)
                {
                    title = "GODMODE [" + string(obj_view.godmode) + "]";
                    desc = "When this is enabled, you are immune to all damage.";
                }
                
                if (i == 1)
                {
                    title = "HYPER-REGEN [" + string(obj_view.super_regen) + "]";
                    desc = "When this is enabled, your health will rapidly regenerate to its maximum.";
                }
                
                if (i == 2)
                {
                    title = "LEVEL UP";
                    desc = "Clicking this will spawn a Floppy Disk pickup at your position.";
                    allow_hold = true;
                }
                
                if (i == 3)
                {
                    title = "ADJUST MORTALITY [" + string(obj_control.diff_gameminutes) + "]";
                    desc = "Left Clicking this will raise the Mortality level. Right Clicking will lower it.";
                    allow_hold = true;
                }
                
                if (i == 4)
                {
                    title = "PAUSE MORTALITY [" + string(obj_view.mortality_pause) + "]";
                    desc = "Clicking this will stop the Mortality from rising. You can click it again to resume.";
                }
                
                if (i == 5)
                {
                    title = "ADJUST BOSSES_KILLED [" + string(obj_control.bosses_killed) + "]";
                    desc = "Left Clicking this will raise the MAINLINE bosses you have killed. Right Clicking will lower it.";
                    allow_hold = true;
                }
                
                if (i == 6)
                {
                    title = "ADJUST REROLLS [" + string(obj_control.rerolls) + "]";
                    desc = "Left Clicking this will give you a reroll. Right Clicking will remove one.";
                    allow_hold = true;
                }
                
                if (i == 7)
                {
                    title = "ADJUST BLACKHOLES [" + string(obj_control.blackhole) + "/" + string(obj_control.blackholemax) + "]";
                    desc = "Left Clicking this will give you a Blackhole Bomb. Right Clicking will remove one. It will also adjust your Maximum Blackholes accordingly.";
                    allow_hold = true;
                }
                
                if (i == 8)
                {
                    title = "ADJUST MAX_ITEMS [" + string(obj_control.max_items) + "]";
                    desc = "Left Clicking this will give you an additional upgrade slot. Right Clicking will remove one.";
                    allow_hold = true;
                }
                
                if (i == 9)
                {
                    title = "NUKE ENEMIES";
                    desc = "Clicking this will set all enemies currently alive to 1 HP.";
                }
                
                if (i == 10)
                {
                    title = "ALLOW ENEMY SPAWNS [" + string(obj_control.spawnenemies) + "]";
                    desc = "Clicking this will toggle enemy spawns on and off. This will automatically change before and after boss fights. Also makes Mortality rise.";
                }
                
                if (i == 11)
                {
                    title = "ADJUST SPAWNCAP [" + string(obj_view.spawncap_cheat) + "x]";
                    desc = "Left Clicking this will raise the % of enemies allowed to spawn at the current Mortality. Right Clicking will lower it.";
                    allow_hold = true;
                }
                
                if (i == 12)
                {
                    title = "ADJUST MOVESPEED [" + string(obj_view.movespeed_cheat) + "x]";
                    desc = "Left Clicking this will raise the % of Cyl's movement speed. Right Clicking will lower it.";
                    allow_hold = true;
                }
                
                if (i == 13)
                {
                    title = "ADJUST XP_MOD [" + string(obj_control.xp_mod_final) + "x]";
                    desc = "Left Clicking this will raise the efficiency of XP. Right Clicking will lower it.";
                    allow_hold = true;
                }
                
                if (i == 14)
                {
                    title = "LOCK LEVEL [" + string(obj_view.levelupstop_cheat) + "]";
                    desc = "Clicking this will stop the level up screen from triggering.";
                }
                
                if (i == 15)
                {
                    title = "ADJUST GAMESPEED [" + string(obj_control.fast_forward_mod) + "]";
                    desc = "Left Clicking this will raise the fastforwarded GameSpeed. Right Clicking will lower it.";
                    allow_hold = true;
                }
                
                draw_set_halign(fa_center);
                var rain = c_rainbow(get_timer() / 10000);
                outline_text_ext(string(title), realmousexx + 12, realmouseyy - 80, rain, 0, 1, -1, 99999, 1, 1, 0);
                outline_text_ext(string(desc), realmousexx + 12, realmouseyy - 64, 16777215, 0, 1, -1, 200, 1, 1, 0);
                draw_set_halign(fa_left);
                var mouse_check_press = 0;
                
                if (allow_hold == true)
                    mouse_check_press = mouse_check_button(mb_left) - mouse_check_button(mb_right);
                else
                    mouse_check_press = mouse_check_button_pressed(mb_left) - mouse_check_button_pressed(mb_right);
                
                if (mouse_check_press != 0)
                {
                    if (click_timer <= 0)
                    {
                        click_timer = click_delay;
                        
                        if (click_delay > 0)
                            click_delay -= 1;
                        
                        playsnd(global.sounds.snd_menu_click, 2, false, 0.3);
                        image_alph = 0.1;
                        cheat_butt_y -= 4;
                        
                        if (i == 0)
                            obj_view.godmode = !obj_view.godmode;
                        
                        if (i == 1)
                            obj_view.super_regen = !obj_view.super_regen;
                        
                        if (i == 2)
                        {
                            var pickup = instance_create_layer(obj_player.x, obj_player.y, "Effects", obj_unique_pickup);
                            pickup.sprite_index = global.sprites.spr_pickup_floppy;
                        }
                        
                        if (i == 3)
                        {
                            obj_control.diff_gameminutes += mouse_check_press;
                            obj_control.diff_gameminutes = round(obj_control.diff_gameminutes);
                        }
                        
                        if (i == 4)
                            obj_view.mortality_pause = !obj_view.mortality_pause;
                        
                        if (i == 5)
                            obj_control.bosses_killed += mouse_check_press;
                        
                        if (i == 6)
                            obj_control.rerolls += mouse_check_press;
                        
                        if (i == 7)
                        {
                            obj_control.blackhole += mouse_check_press;
                            
                            if (obj_control.blackhole > obj_control.blackholemax)
                                obj_control.blackholemax += 1;
                            
                            if (obj_control.blackhole < obj_control.blackholemax)
                                obj_control.blackholemax -= 1;
                        }
                        
                        if (i == 8)
                            obj_control.max_items += mouse_check_press;
                        
                        if (i == 9)
                        {
                            if (instance_exists(obj_enemy_parent))
                            {
                                with (obj_enemy_parent)
                                    hp = 1;
                            }
                        }
                        
                        if (i == 10)
                            obj_control.spawnenemies = !obj_control.spawnenemies;
                        
                        if (i == 11)
                            obj_view.spawncap_cheat += mouse_check_press * 0.01;
                        
                        if (i == 12)
                            obj_view.movespeed_cheat += mouse_check_press * 0.01;
                        
                        if (i == 13)
                            obj_control.xp_mod += mouse_check_press * 0.01;
                        
                        if (i == 14)
                            obj_view.levelupstop_cheat = !obj_view.levelupstop_cheat;
                        
                        if (i == 15)
                            obj_control.fast_forward_mod += mouse_check_press * 0.02;
                    }
                    else
                    {
                        click_timer -= 1;
                    }
                }
                else
                {
                    click_timer = 0;
                    click_delay = 15;
                }
            }
            
            draw_sprite_ext(global.sprites.spr_freeplay_buttons, i, cheat_butt_x, cheat_butt_y, 1, 1, 0, c_white, clamp(image_alph * get_visual_alph, 0, 1));
        }
    }
    
    draw_text_setup(65280, 0, 2, fnt_freddy);
    var first_num = 32;
    var add_num = 8;
    var minmod = 128;
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 0), string(abs(obj_player.xspd * 3) + abs(obj_player.yspd * 3)) + "mph", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 1), string(obj_player.crit_chance) + "%", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 2), string(obj_player.dodge_final) + "%", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 3), "+" + string(obj_player.add_dmg_final), -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 4), string(round(obj_control.xp_mod_final * 100)) + "%", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 5), string(obj_player.drills), -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 7), string(obj_player.poison_chance) + "%", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 8), string(obj_player.fire_chance) + "%", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 9), string(obj_player.slow_chance) + "%", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 10), string(obj_player.stun_chance) + "%", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 12), string(obj_stat_track.overdrive), -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 13), string(obj_control.directhits), -1, 999, 65280, 0, 1);
    draw_text_setup(65280, 0, 0, fnt_freddy);
    minmod = 212;
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 0), "SPEED:     ", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 1), "CRIT:      ", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 2), "DODGE:     ", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 3), "ADD_DMG:  ", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 4), "XP_MOD:    ", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 5), "DRILLS:    ", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 7), "POISON:    ", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 8), "FIRE:    ", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 9), "ICE:    ", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 10), "SHOCK:    ", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 12), "OVERDRIVE:    ", -1, 999, 65280, 0, 1);
    draw_text_outline(show_bgleftx - minmod, first_num + (add_num * 13), "HITS:    ", -1, 999, 65280, 0, 1);
}
