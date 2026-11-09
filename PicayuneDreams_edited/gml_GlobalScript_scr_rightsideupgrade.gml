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
