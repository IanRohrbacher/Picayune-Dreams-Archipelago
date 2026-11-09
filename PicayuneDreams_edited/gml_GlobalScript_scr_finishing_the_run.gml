function scr_finishing_the_run()
{
    obj_stat_track.stat_runs_completed += 1;
    
    if (obj_stat_track.overdrive == obj_stat_track.overdrive_max)
        obj_stat_track.overdrive_max += 1;
    
    ini_open(global.save);
    
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
