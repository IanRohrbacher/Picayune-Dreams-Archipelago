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
                
                if (butt == "exit")
                    game_end();
                
                if (butt == "daily" && ready == true && global.cheater == false)
                {
                    random_set_seed(global.get_cur_seed);
                    var ftr = instance_create_depth(x, y, -99999999, obj_fadetoroom);
                    ftr.rm = rm_fadetogame;
                    global.gamestart_ind = 0;
                    global.gamemode = "daily";
                    obj_stat_track.overdrive = 0;
                }
                
                if (butt == "monthly" && ready == true && global.cheater == false)
                {
                    random_set_seed(global.get_cur_seed_monthly);
                    var ftr = instance_create_depth(x, y, -99999999, obj_fadetoroom);
                    ftr.rm = rm_fadetogame;
                    global.gamestart_ind = 0;
                    global.gamemode = "monthly";
                    obj_stat_track.overdrive = 0;
                }
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

if (hover == true)
{
    var sd = 0;
    var runs = "";
    
    if (butt == "daily" || butt == "monthly")
    {
        sd = global.get_cur_seed;
        var txt_add = "DAILY";
        runs = string(global.daily_runs_won) + "/" + string(global.daily_runs_tried);
        
        if (butt == "monthly")
        {
            txt_add = "MONTHLY";
            sd = global.get_cur_seed_monthly;
            runs = string(global.monthly_runs_won) + "/" + string(global.monthly_runs_tried);
        }
        
        draw_text_setup(16777215, 0, 0, fnt_freddy);
        outline_text_ext("Attempted: " + done_run + "\nHours Until Refresh: " + string(hour_diff) + "\nSeed: " + string(sd) + "\nRuns Complete: " + runs + "\nSkills Equipped: [" + string(equipped_skill_num) + "/30]", obj_mouse.x + 12, obj_mouse.y, 16777215, 0, 1, -1, 200, 1, 1, 0);
        
        if (too_many_skills == true)
            outline_text_ext("[ULTRAOVERPOWER! TOO MANY SKILLS!]", obj_mouse.x + 12 + random_range(-1, 1), obj_mouse.y + 75 + random_range(-1, 1), 255, 0, 1, -1, 200, 1, 1, 0);
        
        if (global.cheater == true || struct_names_count(global.mods) > 0)
        {
            locked = true;
            outline_text_ext("[NO CHEATY CHEATS!]", obj_mouse.x + 12 + random_range(-1, 1), obj_mouse.y + 90 + random_range(-1, 1), 255, 0, 1, -1, 200, 1, 1, 0);
        }
        
        outline_text_ext(txt_add + " HIGHSCORES: [" + hs_show + "]", 16, 16, 16777215, 0, 1, -1, 200, 2, 2, 0);
        outline_text_ext("GLOBAL LEADERBOARD:", 16, 36, 16777215, 0, 1, -1, 200, 1, 1, 0);
        var name_ind = "";
        var score_ind = 0;
        
        if (hs_show == "MORTALITY")
        {
            for (var i = 0; i < 90; i += 1)
            {
                name_ind = steam_name_mortality[i];
                score_ind = steam_score_mortality[i];
                var name_col = 16777215;
                
                if (name_ind != "")
                {
                    if (name_ind == username)
                        name_col = 65280;
                    
                    outline_text_ext(" - " + string(name_ind) + ": " + string(score_ind) + "!", 16 + wave(-4, 4, 4, i / 10), 48 + (i * 12), name_col, 0, 1, -1, 2000, 1, 1, 0);
                }
            }
        }
        else if (hs_show == "KILLS")
        {
            for (var i = 0; i < 90; i += 1)
            {
                name_ind = steam_name_kills[i];
                score_ind = steam_score_kills[i];
                var name_col = 16777215;
                
                if (name_ind != "")
                {
                    if (name_ind == username)
                        name_col = 65280;
                    
                    outline_text_ext(" - " + string(name_ind) + ": " + string(score_ind) + "!", 16 + wave(-4, 4, 4, i / 10), 48 + (i * 12), name_col, 0, 1, -1, 2000, 1, 1, 0);
                }
            }
        }
        else if (hs_show == "SPEEDRUN")
        {
            for (var i = 0; i < 90; i += 1)
            {
                name_ind = steam_name_speed[i];
                score_ind = steam_score_speed[i];
                var name_col = 16777215;
                
                if (name_ind != "")
                {
                    if (name_ind == username)
                        name_col = 65280;
                    
                    outline_text_ext(" - " + string(name_ind) + ": " + string(score_ind) + "s.", 16 + wave(-4, 4, 4, i / 10), 48 + (i * 12), name_col, 0, 1, -1, 2000, 1, 1, 0);
                }
            }
        }
    }
    
    if (butt == "start")
    {
        outline_text_ext("HIGHSCORES: [" + hs_show + "]", 16, 16, 16777215, 0, 1, -1, 200, 2, 2, 0);
        outline_text_ext("FRIEND LEADERBOARD:", 16, 36, 16777215, 0, 1, -1, 200, 1, 1, 0);
        var name_ind = "";
        var score_ind = 0;
        
        if (hs_show == "MORTALITY")
        {
            for (var i = 0; i < 90; i += 1)
            {
                name_ind = steam_name_mortality[i];
                score_ind = steam_score_mortality[i];
                var name_col = 16777215;
                
                if (name_ind != "")
                {
                    if (name_ind == username)
                        name_col = 65280;
                    
                    outline_text_ext(" - " + string(name_ind) + ": " + string(score_ind) + "!", 16 + wave(-4, 4, 4, i / 10), 48 + (i * 12), name_col, 0, 1, -1, 2000, 1, 1, 0);
                }
            }
        }
        else if (hs_show == "KILLS")
        {
            for (var i = 0; i < 90; i += 1)
            {
                name_ind = steam_name_kills[i];
                score_ind = steam_score_kills[i];
                var name_col = 16777215;
                
                if (name_ind != "")
                {
                    if (name_ind == username)
                        name_col = 65280;
                    
                    outline_text_ext(" - " + string(name_ind) + ": " + string(score_ind) + "!", 16 + wave(-4, 4, 4, i / 10), 48 + (i * 12), name_col, 0, 1, -1, 2000, 1, 1, 0);
                }
            }
        }
        else if (hs_show == "SPEEDRUN")
        {
            for (var i = 0; i < 90; i += 1)
            {
                name_ind = steam_name_speed[i];
                score_ind = steam_score_speed[i];
                var name_col = 16777215;
                
                if (name_ind != "")
                {
                    if (name_ind == username)
                        name_col = 65280;
                    
                    outline_text_ext(" - " + string(name_ind) + ": " + string(score_ind) + "s.", 16 + wave(-4, 4, 4, i / 10), 48 + (i * 12), name_col, 0, 1, -1, 2000, 1, 1, 0);
                }
            }
        }
    }
}
