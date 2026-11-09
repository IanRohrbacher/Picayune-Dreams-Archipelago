function beat_the_run_achievements()
{
    if (ds_list_find_index(obj_player.equipped_items, obj_control.item_slimespike) != -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_chainbelt) != -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_legsaw) != -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_hydro) != -1)
        attempt_to_unlock_achievement("Mob_Grinder");
    
    if (ds_list_find_index(obj_player.equipped_items, obj_control.item_core) != -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_ultrabuster) != -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_eye2) != -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_bow) != -1)
        attempt_to_unlock_achievement("Lightgun");
    
    if (obj_control.has_used_autoaim == false)
    {
        attempt_to_unlock_achievement("Manual");
        obj_stat_track.stat_noautoaim = true;
    }
    
    if (global.skill_fishstockdmg == true && global.skill_fishstockradius == true && global.skill_fishstockscale == true && global.skill_fishstockxpmod == true)
        obj_stat_track.stat_fishstockrun = true;
    
    if (obj_control.has_killed_diver == true && obj_control.has_killed_diver == true && obj_control.has_killed_umi == true && obj_control.has_killed_yuki == true && obj_control.has_killed_ghost == true)
        obj_stat_track.stat_killedallrun = true;
    
    if (scr_get_skill_num() < obj_stat_track.stat_lowest_skills)
        obj_stat_track.stat_lowest_skills = scr_get_skill_num();
    
    if (scr_get_skill_num() > obj_stat_track.stat_highest_skills)
        obj_stat_track.stat_highest_skills = scr_get_skill_num();
    
    if (ds_list_size(obj_player.equipped_items) < obj_stat_track.stat_lowest_items)
        obj_stat_track.stat_lowest_items = ds_list_size(obj_player.equipped_items);
    
    if (ds_list_size(obj_player.equipped_items) > obj_stat_track.stat_highest_items)
        obj_stat_track.stat_highest_items = ds_list_size(obj_player.equipped_items);
    
    if (ds_list_find_index(obj_player.equipped_items, obj_control.item_ivbag) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_halo) == -1)
        attempt_to_unlock_achievement("Offensive");
    
    if (ds_list_find_index(obj_player.equipped_items, obj_control.item_core) == -1)
        attempt_to_unlock_achievement("Experimental");
    
    if (ds_list_find_index(obj_player.equipped_items, obj_control.item_core) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_angelwings) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_batwings) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_chainbelt) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_daggerglove) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_eye2) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_horns) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_hydro) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_missile) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_parasight) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_slimespike) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_telecom) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_ultrabuster) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_puckrack) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_c4) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_satellite) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_walkman) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_spear) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_turret) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_ninja) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_shrapnel) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_strikecall) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_sword) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_popup) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_corrupt) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_dynamite) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_splash) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_bees) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_midas) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_fish) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_cheese) == -1 && ds_list_find_index(obj_player.equipped_items, obj_control.item_psycho) == -1)
        obj_stat_track.stat_elemental_run = true;
    
    if (global.hpmax >= 200)
        attempt_to_unlock_achievement("Bleed");
    
    if (obj_player.movement_mod_final >= 2)
        attempt_to_unlock_achievement("Speed");
    
    if (obj_player.weapon_size_final >= 2)
        attempt_to_unlock_achievement("Enlarge");
    
    if (obj_player.pickupradius_mod_final >= 2)
        attempt_to_unlock_achievement("Reach");
    
    if (obj_player.projectile_spd_final >= 2)
        attempt_to_unlock_achievement("Bullet");
    
    if (obj_control.blackholemax >= 10)
        attempt_to_unlock_achievement("Armed");
    
    if (obj_control.true_flawless == true)
        attempt_to_unlock_achievement("Flawless");
    
    if (obj_player.cooldown_mod_final <= 0.75)
        obj_stat_track.stat_lowerthanfiftycd = true;
    
    var get_highest_upgrades = 0;
    
    for (var i = 0; i < ds_list_size(obj_player.equipped_items); i += 1)
    {
        var get_item = ds_list_find_value(obj_player.equipped_items, i);
        var upg_var = ds_list_find_value(get_item, 2);
        var oldnum_of_upgrade = variable_instance_get(obj_player.id, upg_var);
        get_highest_upgrades += oldnum_of_upgrade;
    }
    
    if (get_highest_upgrades > obj_stat_track.stat_highest_upgrades)
        obj_stat_track.stat_highest_upgrades = get_highest_upgrades;
    
    if (obj_control.directhits >= obj_stat_track.stat_most_direct_hits_in_one_run)
        obj_stat_track.stat_most_direct_hits_in_one_run = obj_control.directhits;
    
    if (obj_control.blackhole_used_this_game > obj_stat_track.stat_blackholes_used_onerun)
        obj_stat_track.stat_blackholes_used_onerun = obj_control.blackhole_used_this_game;
    
    if (obj_control.diff_gameminutes >= 25)
    {
        if (obj_control.xp_mod_final > obj_stat_track.stat_most_xp_worth)
            obj_stat_track.stat_most_xp_worth = obj_control.xp_mod_final;
    }
}
