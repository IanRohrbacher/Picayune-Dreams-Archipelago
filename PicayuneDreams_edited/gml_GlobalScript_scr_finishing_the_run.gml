function scr_finishing_the_run()
{
    if (obj_control.daily_run_complete == false)
    {
        obj_control.daily_run_complete = true;
        
        obj_stat_track.stat_runs_completed += 1;
        
        if (obj_stat_track.overdrive == obj_stat_track.overdrive_max)
            obj_stat_track.overdrive_max += 1;
        
        ini_open(global.save);
        
        if (global.gamemode == "daily")
        {
            global.daily_runs_won += 1;
            ini_write_real("daily", "daily_runs_won", global.daily_runs_won);
            var txt = instance_create_layer(obj_player.x, obj_player.y, "Overlay", obj_text_popup);
            txt.txt = "RUN COMPLETE!";
            txt.shake = 1;
            
            if (global.cheater == false)
            {
                steam_upload_score("daily_" + string(global.get_cur_seed) + "_mortality", obj_control.diff_gameminutes);
                steam_upload_score("daily_" + string(global.get_cur_seed) + "_kills", global.ds_enemieskilled);
                steam_upload_score("daily_" + string(global.get_cur_seed) + "_speed", (obj_control.sessionMinutes * 60) + obj_control.sessionSeconds);
            }
        }
        
        if (global.gamemode == "monthly")
        {
            global.monthly_runs_won += 1;
            ini_write_real("daily", "monthly_runs_won", global.monthly_runs_won);
            var txt = instance_create_layer(obj_player.x, obj_player.y, "Overlay", obj_text_popup);
            txt.txt = "RUN COMPLETE!";
            txt.shake = 1;
            
            if (global.cheater == false)
            {
                steam_upload_score("monthly_" + string(global.get_cur_seed_monthly) + "_mortality", obj_control.diff_gameminutes);
                steam_upload_score("monthly_" + string(global.get_cur_seed_monthly) + "_kills", global.ds_enemieskilled);
                steam_upload_score("monthly_" + string(global.get_cur_seed_monthly) + "_speed", (obj_control.sessionMinutes * 60) + obj_control.sessionSeconds);
            }
        }
        
        if (global.cheater == false)
            steam_upload_score("global_speed", (obj_control.sessionMinutes * 60) + obj_control.sessionSeconds);
        
        ini_close();
        
        if (obj_stat_track.overdrive >= 1)
            attempt_to_unlock_achievement("Coder");
        
        if (obj_stat_track.overdrive >= 2)
            attempt_to_unlock_achievement("Scripter");
        
        if (obj_stat_track.overdrive >= 3)
            attempt_to_unlock_achievement("Debugger");
        
        if (obj_stat_track.overdrive >= 4)
            attempt_to_unlock_achievement("Modder");
        
        if (obj_stat_track.overdrive >= 5)
            attempt_to_unlock_achievement("Maestro");
        
        beat_the_run_achievements();
    }
}
