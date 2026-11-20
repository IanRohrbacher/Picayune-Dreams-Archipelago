function scr_saveallgamestats()
{
    global.ds_player_x = x;
    global.ds_player_y = y;
    global.ds_timesurvivedminutes = obj_control.sessionMinutes;
    global.ds_timesurvivedseconds = obj_control.sessionSeconds;
    global.ds_mortality = obj_control.diff_gameminutes;
    global.ds_xpearned = obj_control.ds_xpearned;
    global.dialog_lastkilledby = global.facing_boss;
    obj_stat_track.stat_times_died += 1;
    
    ini_open(global.save);
    ini_write_string("boss", "lastkilledby", global.dialog_lastkilledby);
    ini_write_string("boss", "gremlin_timesvisit", global.dialog_gremlin_visits);
    ini_write_string("boss", "worm_timesvisit", global.dialog_worm_visits);
    ini_write_string("boss", "ghost_timesvisit", global.dialog_ghost_visits);
    ini_write_string("boss", "biker_timesvisit", global.dialog_biker_visits);
    ini_write_string("boss", "demon_timesvisit", global.dialog_demon_visits);
    ini_write_string("boss", "picayune_timesvisit", global.dialog_picayune_visits);
    ini_write_string("boss", "diver_timesvisit", global.dialog_diver_visits);
    ini_write_string("boss", "umi_timesvisit", global.dialog_umi_visits);
    ini_write_string("boss", "ab_gremlin_timesvisit", global.dialog_ab_gremlin_visits);
    ini_write_string("boss", "ab_worm_timesvisit", global.dialog_ab_worm_visits);
    ini_write_string("boss", "ab_biker_timesvisit", global.dialog_ab_biker_visits);
    ini_write_string("boss", "ab_demon_timesvisit", global.dialog_ab_demon_visits);
    ini_write_string("boss", "ab_picayune_timesvisit", global.dialog_ab_picayune_visits);
    ini_close();
    var mort = obj_control.diff_gameminutes;
    var od = obj_stat_track.overdrive;
    
    if (obj_player.outfit == "default")
    {
        if (mort > obj_stat_track.stat_suit_default_mortality)
            obj_stat_track.stat_suit_default_mortality = mort;
        
        if (mort >= 25 && od > obj_stat_track.stat_suit_default_overdrive)
            obj_stat_track.stat_suit_default_overdrive = od;
        
        show_debug_message("mort: " + string(mort));
        show_debug_message("od: " + string(od));
    }
    
    if (obj_player.outfit == "glass")
    {
        if (mort > obj_stat_track.stat_suit_glass_mortality)
            obj_stat_track.stat_suit_glass_mortality = mort;
        
        if (mort >= 25 && od > obj_stat_track.stat_suit_glass_overdrive)
            obj_stat_track.stat_suit_glass_overdrive = od;
    }
    
    if (obj_player.outfit == "worn")
    {
        if (mort > obj_stat_track.stat_suit_worn_mortality)
            obj_stat_track.stat_suit_worn_mortality = mort;
        
        if (mort >= 25 && od > obj_stat_track.stat_suit_worn_overdrive)
            obj_stat_track.stat_suit_worn_overdrive = od;
    }
    
    if (obj_player.outfit == "absorb")
    {
        if (mort > obj_stat_track.stat_suit_absorb_mortality)
            obj_stat_track.stat_suit_absorb_mortality = mort;
        
        if (mort >= 25 && od > obj_stat_track.stat_suit_absorb_overdrive)
            obj_stat_track.stat_suit_absorb_overdrive = od;
    }
    
    if (obj_player.outfit == "picayune")
    {
        if (mort > obj_stat_track.stat_suit_picayune_mortality)
            obj_stat_track.stat_suit_picayune_mortality = mort;
        
        if (mort >= 25 && od > obj_stat_track.stat_suit_picayune_overdrive)
            obj_stat_track.stat_suit_picayune_overdrive = od;
    }
    
    if (obj_player.outfit == "versatile")
    {
        if (mort > obj_stat_track.stat_suit_efficient_mortality)
            obj_stat_track.stat_suit_efficient_mortality = mort;
        
        if (mort >= 25 && od > obj_stat_track.stat_suit_efficient_overdrive)
            obj_stat_track.stat_suit_efficient_overdrive = od;
    }
    
    if (obj_player.outfit == "optimized")
    {
        if (mort > obj_stat_track.stat_suit_optimized_mortality)
            obj_stat_track.stat_suit_optimized_mortality = mort;
        
        if (mort >= 25 && od > obj_stat_track.stat_suit_optimized_overdrive)
            obj_stat_track.stat_suit_optimized_overdrive = od;
    }
    
    if (obj_player.outfit == "perfected")
    {
        if (mort > obj_stat_track.stat_suit_perfected_mortality)
            obj_stat_track.stat_suit_perfected_mortality = mort;
        
        if (mort >= 25 && od > obj_stat_track.stat_suit_perfected_overdrive)
            obj_stat_track.stat_suit_perfected_overdrive = od;
    }
    
    if (obj_player.outfit == "tank")
    {
        if (mort > obj_stat_track.stat_suit_tank_mortality)
            obj_stat_track.stat_suit_tank_mortality = mort;
        
        if (mort >= 25 && od > obj_stat_track.stat_suit_tank_overdrive)
            obj_stat_track.stat_suit_tank_overdrive = od;
    }
    
    if (obj_player.outfit == "spammer")
    {
        if (mort > obj_stat_track.stat_suit_spammer_mortality)
            obj_stat_track.stat_suit_spammer_mortality = mort;
        
        if (mort >= 25 && od > obj_stat_track.stat_suit_spammer_overdrive)
            obj_stat_track.stat_suit_spammer_overdrive = od;
    }
    
    if (obj_player.outfit == "elemental")
    {
        if (mort > obj_stat_track.stat_suit_elemental_mortality)
            obj_stat_track.stat_suit_elemental_mortality = mort;
        
        if (mort >= 25 && od > obj_stat_track.stat_suit_elemental_overdrive)
            obj_stat_track.stat_suit_elemental_overdrive = od;
    }
}

function scr_copygamedata()
{
    var nearplayer = instance_nearest(x, y, obj_player);
    ds_list_clear(global.ds_itemsandstats);
    ds_list_copy(global.ds_itemsandstats, obj_player.equipped_items);
    
    for (var i = 0; i < ds_list_size(global.ds_itemsandstats); i += 1)
    {
        var getdslist = ds_list_find_value(global.ds_itemsandstats, i);
        var variableofwep = ds_list_find_value(getdslist, 2);
        var upgrade_number = variable_instance_get(nearplayer, variableofwep);
        ds_list_replace(getdslist, 8, upgrade_number);
    }
}
