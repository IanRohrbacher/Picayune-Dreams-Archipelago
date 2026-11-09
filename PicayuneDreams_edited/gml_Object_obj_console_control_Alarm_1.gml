var addtxt = "";
var random_warnnum = irandom_range(10, 50);
var random_criterror = irandom_range(3, 10);
var enemieskilled = 0;
var bosseskilled = 0;
var survivaltime = 0;
var recordsurvivaltime = 0;
var level = 0;
var recordlevel = 0;
var upgradecount = 0;
var recordupgradecount = 0;

if (init_num == 0)
{
    addtxt = "// WARNING, there are several issues that need to be resolved.";
    text_breaktime = 30;
    text_typespeed = 1;
}
else if (init_num == 1)
{
    addtxt = "SYSTEM: Circulatory. STATUS: NOT RESPONDING. MECHANICAL ERROR.";
    text_breaktime = 1;
    text_typespeed = 60;
}
else if (init_num == 2)
{
    addtxt = "SYSTEM: Digestive. STATUS: NOT RESPONDING. ORGANIC ERROR.";
}
else if (init_num == 3)
{
    addtxt = "SYSTEM: Endocrine. STATUS: NOT RESPONDING. AUGMENTED ERROR.";
}
else if (init_num == 4)
{
    addtxt = "SYSTEM: Integumentary. STATUS: NOT RESPONDING. ORGANIC ERROR.";
}
else if (init_num == 5)
{
    addtxt = "SYSTEM: Immune. STATUS: NOT RESPONDING. ORGANIC ERROR.";
}
else if (init_num == 6)
{
    addtxt = "SYSTEM: Muscular. STATUS: NOT RESPONDING. AUGMENTED ERROR.";
}
else if (init_num == 7)
{
    addtxt = "SYSTEM: Nervous. STATUS: NOT RESPONDING. ORGANIC ERROR.";
}
else if (init_num == 8)
{
    addtxt = "SYSTEM: Renal. STATUS: NOT RESPONDING. ORGANIC ERROR.";
}
else if (init_num == 9)
{
    addtxt = "SYSTEM: Reproductive. STATUS: NOT RESPONDING. AUGMENTED ERROR.";
}
else if (init_num == 10)
{
    addtxt = "SYSTEM: Respiratory. STATUS: NOT RESPONDING. MECHANICAL ERROR.";
}
else if (init_num == 11)
{
    addtxt = "SYSTEM: Skeletal. STATUS: NOT RESPONDING. AUGMENTED ERROR.";
}
else if (init_num == 12)
{
    addtxt = "... AND " + string(random_criterror) + " OTHER CRITICAL ERRORS. " + string(random_warnnum) + " WARNINGS.";
}
else if (init_num == 13)
{
    addtxt = "Now attempting to automatically resolve critical errors.";
}
else if (init_num == 14)
{
    addtxt = "Do you consent? Y/N?";
    text_breaktime = 60;
    text_typespeed = 10;
}
else if (init_num == 15)
{
    if (global.willingly_ended_run == 0)
        addtxt = "CONSENT OVERRIDDEN, GOVERNMENT MANDATED REASONING: ''MISSION ISN'T COMPLETE''";
    else
        addtxt = "CONSENT OVERRIDDEN, GOVERNMENT MANDATED REASONING: ''MISSION COMPLETE, VESSEL OUT OF JURISDICTION''";
    
    text_breaktime = 1;
    text_typespeed = 10;
}
else if (init_num == 16)
{
    addtxt = "Y";
    text_breaktime = 30;
    text_typespeed = 1;
}
else if (init_num == 17)
{
    addtxt = "3...";
}
else if (init_num == 18)
{
    addtxt = "2...";
}
else if (init_num == 19)
{
    addtxt = "1...";
    text_breaktime = 30;
    text_typespeed = 1;
}
else if (init_num == 20)
{
    addtxt = "CRITICAL ISSUES RESOLVED.";
    text_breaktime = 30;
    text_typespeed = 1;
}
else if (init_num == 21)
{
    addtxt = "HEARTBEAT PING?";
}
else if (init_num == 22)
{
    addtxt = "PONG.";
}
else if (init_num == 23)
{
    addtxt = "HEARTBEAT PING?";
}
else if (init_num == 24)
{
    addtxt = "PONG.";
}
else if (init_num == 25)
{
    addtxt = "CONDITION STABILIZED. ANALYZING DATA...";
}
else if (init_num == 26)
{
    addtxt = "........................................................................";
    text_breaktime = 1;
    text_typespeed = 20;
}
else if (init_num == 27)
{
    addtxt = "BODY LOCATION: X" + string(global.ds_player_x) + " Y" + string(global.ds_player_y);
}
else if (init_num == 28)
{
    addtxt = "TOTAL ENEMIES SLAIN: " + string(global.ds_enemieskilled);
}
else if (init_num == 29)
{
    addtxt = "TOTAL BOSSES SLAIN: " + string(global.ds_bosseskilled);
}
else if (init_num == 30)
{
    addtxt = "TIME SURVIVED: " + string(global.ds_timesurvivedminutes) + ":" + string(global.ds_timesurvivedseconds) + " [REALTIME: " + string(date_second_span(global.stored_realtime_startrun, date_current_datetime()) / 60) + " MINUTES] [MORTALITY: " + string(global.ds_mortality) + "]";
}
else if (init_num == 31)
{
    addtxt = "OVERDRIVE: " + string(obj_stat_track.overdrive);
}
else if (init_num == 33)
{
    addtxt = "LAST DAMAGED BY: " + string(global.killed_by) + ".";
}
else if (init_num == 34)
{
    addtxt = "UPGRADES: " + string(global.ds_upgrades);
}
else if (init_num == 35)
{
    addtxt = "........................................................................";
    text_breaktime = 1;
    text_typespeed = 20;
}
else if (init_num == 36)
{
    addtxt = "";
    var listsize = ds_list_size(global.ds_itemsandstats);
    
    if (listsize > item_counted && listsize > 0)
    {
        var getdslist = ds_list_find_value(global.ds_itemsandstats, item_counted);
        var codeofwep = ds_list_find_value(getdslist, 0);
        var nameofwep = ds_list_find_value(getdslist, 1);
        var wepcount = ds_list_find_value(getdslist, 8);
        var getweaponid = ds_list_find_value(getdslist, 7);
        var wepdamage = get_weapon_stat(getweaponid, 0);
        var wepkills = get_weapon_stat(getweaponid, 1);
        var addtotxt = "";
        
        if (wepdamage > 0)
            addtotxt = " [DAMAGE: " + string(wepdamage) + "]; [KILLS: " + string(wepkills) + "];";
        
        addtxt = nameofwep + " [x" + string(wepcount) + "];" + addtotxt;
        item_counted += 1;
        init_num = 35;
        update_weapon_count_stats(codeofwep, wepcount);
    }
}
else if (init_num == 37)
{
    addtxt = "........................................................................";
    text_breaktime = 1;
    text_typespeed = 20;
}
else if (init_num == 38)
{
    addtxt = "OLD PROFILE LVL & XP: " + string(global.profile_level) + " (" + string(global.profile_xp) + ")";
}
else if (init_num == 39)
{
    obj_stat_track.stat_total_kills += global.ds_enemieskilled;
    obj_stat_track.stat_upgrades_chosen += global.ds_upgrades;
    obj_stat_track.stat_total_xp += global.ds_xpearned;
    obj_stat_track.stat_total_mortality += global.ds_mortality;
    obj_stat_track.stat_bosses_killed += global.ds_bosseskilled;
    obj_stat_track.stat_total_runtime += round((global.ds_timesurvivedseconds / 60) + global.ds_timesurvivedminutes);
    
    if (((global.ds_timesurvivedseconds / 60) + global.ds_timesurvivedminutes) > obj_stat_track.stat_highest_runtime)
        obj_stat_track.stat_highest_runtime = (global.ds_timesurvivedseconds / 60) + global.ds_timesurvivedminutes;
    
    if (global.ds_mortality > obj_stat_track.stat_highest_mortality)
        obj_stat_track.stat_highest_mortality = global.ds_mortality;
    
    if (global.ds_mortality > 25)
        obj_stat_track.stat_total_kills += 1;
    
    global.ds_xpearned = round(global.ds_xpearned);
    var prestige_add = 0;
    
    if (global.prestige > 0)
    {
        prestige_add = round((global.ds_xpearned / 10) * global.prestige);
        addtxt = "XP EARNED: " + string(global.ds_xpearned) + " + [PRESTIGE " + string(global.prestige) + " BONUS: " + string(prestige_add) + " XP]";
        global.ds_xpearned += prestige_add;
    }
    else
    {
        addtxt = "XP EARNED: " + string(global.ds_xpearned);
    }

    repeat (25)
    {
        if (global.profile_level < global.game_level_cap)
        {
            global.profile_xp += global.ds_xpearned;
            global.ds_xpearned = 0;
            var amount_to_level = global.profile_level * global.level_mod * (1 + (global.profile_level / 20));
            
            if (global.profile_xp > amount_to_level)
            {
                global.profile_xp -= amount_to_level;
                global.profile_level += 1;
            }
        }
        else
        {
            addtxt = "XP EARNED: " + string(global.ds_xpearned) + " ... [HOWEVER, MAXIMUM PROFILE LEVEL HAS BEEN REACHED!]";
            global.profile_level = global.game_level_cap;
            global.profile_xp = global.profile_level * global.level_mod;
        }
    }
    
    xptonext = (global.profile_level * global.level_mod * (1 + (global.profile_level / 20))) - global.profile_xp;
}
else if (init_num == 40)
{
    addtxt = "NEW PROFILE LVL & XP: " + string(global.profile_level) + " (" + string(global.profile_xp) + ")";
}
else if (init_num == 41)
{
    var odam = clamp(obj_stat_track.overdrive_max - 1, 0, 9999);
    addtxt = "XP UNTIL NEXT LEVEL: " + string(xptonext) + ", " + string((global.profile_level - global.points_spent) + odam) + " UNSPENT POINT(/S).";
}
else if (init_num == 42)
{
    addtxt = "........................................................................";
}
else if (init_num == 43)
{
    if (global.memorygrabbed == "None")
        addtxt = "PRESS [SPACE] OR [START] TO RESTART SYSTEM...";
    else
        addtxt = "MEMORY FILE WAS LOCATED ON DRIVE! PRESS [SPACE]/[START] TO PLAY MEMORY, OR [ESCAPE]/[SELECT] TO RETURN TO MENU...";
    
    anykey = true;
    finalmess = 1;
    global.total_runs += 1;
    global.ds_itemsandstats = 0;
    
    ini_open(global.save);
    ini_write_real("stats", "profile_level", global.profile_level);
    ini_write_real("stats", "profile_xp", global.profile_xp);
    ini_write_real("stats", "total_runs", global.total_runs);
    ini_write_real("stats", "prestige", global.prestige);
    ini_close();
    global.points_avaliable = global.profile_level + clamp(obj_stat_track.overdrive_max - 1, 0, 9999);
    add_damage_to_stats();
    submit_highscores();
}

if (finalmess != 2)
{
    if (finalmess == 1)
        finalmess = 2;
    
    if (addtxt != "")
        ds_list_add(textlist, addtxt);
    
    written_letters = 0;
    callnewtxt = false;
    init_num += 1;
}
