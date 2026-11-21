function update_weapon_count_stats(arg0, arg1)
{
    // Weapon counts are always updated; there is no freeplay mode that skips them.
    if (arg0 == "Core")
    {
        obj_stat_track.stat_core_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_core_high)
            obj_stat_track.stat_core_high = arg1;
    }
    
    if (arg0 == "AngelWings")
    {
        obj_stat_track.stat_angelwings_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_angelwings_high)
            obj_stat_track.stat_angelwings_high = arg1;
    }
    
    if (arg0 == "BatWings")
    {
        obj_stat_track.stat_batwings_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_batwings_high)
            obj_stat_track.stat_batwings_high = arg1;
    }
    
    if (arg0 == "ChainBelt")
    {
        obj_stat_track.stat_chainbelt_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_chainbelt_high)
            obj_stat_track.stat_chainbelt_high = arg1;
    }
    
    if (arg0 == "DaggerGlove")
    {
        obj_stat_track.stat_daggerglove_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_daggerglove_high)
            obj_stat_track.stat_daggerglove_high = arg1;
    }
    
    if (arg0 == "Eye2")
    {
        obj_stat_track.stat_eye2_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_eye2_high)
            obj_stat_track.stat_eye2_high = arg1;
    }
    
    if (arg0 == "Halo")
    {
        obj_stat_track.stat_halo_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_halo_high)
            obj_stat_track.stat_halo_high = arg1;
    }
    
    if (arg0 == "Horns")
    {
        obj_stat_track.stat_horns_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_horns_high)
            obj_stat_track.stat_horns_high = arg1;
    }
    
    if (arg0 == "Hydrocillator")
    {
        obj_stat_track.stat_hydro_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_hydro_high)
            obj_stat_track.stat_hydro_high = arg1;
    }
    
    if (arg0 == "LegSaw")
    {
        obj_stat_track.stat_legsaw_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_legsaw_high)
            obj_stat_track.stat_legsaw_high = arg1;
    }
    
    if (arg0 == "MissilePack")
    {
        obj_stat_track.stat_missilepack_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_missilepack_high)
            obj_stat_track.stat_missilepack_high = arg1;
    }
    
    if (arg0 == "ParaSight")
    {
        obj_stat_track.stat_parasight_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_parasight_high)
            obj_stat_track.stat_parasight_high = arg1;
    }
    
    if (arg0 == "SlimeSpike")
    {
        obj_stat_track.stat_slimespike_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_slimespike_high)
            obj_stat_track.stat_slimespike_high = arg1;
    }
    
    if (arg0 == "Telecom")
    {
        obj_stat_track.stat_telecom_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_telecom_high)
            obj_stat_track.stat_telecom_high = arg1;
    }
    
    if (arg0 == "UltraBuster")
    {
        obj_stat_track.stat_ultrabuster_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_ultrabuster_high)
            obj_stat_track.stat_ultrabuster_high = arg1;
    }
    
    if (arg0 == "Rotator")
    {
        obj_stat_track.stat_yoyo_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_yoyo_high)
            obj_stat_track.stat_yoyo_high = arg1;
    }
    
    if (arg0 == "IVBag")
    {
        obj_stat_track.stat_ivbag_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_ivbag_high)
            obj_stat_track.stat_ivbag_high = arg1;
    }
    
    if (arg0 == "Crown")
    {
        obj_stat_track.stat_crown_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_crown_high)
            obj_stat_track.stat_crown_high = arg1;
    }
    
    if (arg0 == "DigiWatch")
    {
        obj_stat_track.stat_digiwatch_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_digiwatch_high)
            obj_stat_track.stat_digiwatch_high = arg1;
    }
    
    if (arg0 == "Engine")
    {
        obj_stat_track.stat_engine_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_engine_high)
            obj_stat_track.stat_engine_high = arg1;
    }
    
    if (arg0 == "Injection")
    {
        obj_stat_track.stat_injection_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_injection_high)
            obj_stat_track.stat_injection_high = arg1;
    }
    
    if (arg0 == "Battery")
    {
        obj_stat_track.stat_battery_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_battery_high)
            obj_stat_track.stat_battery_high = arg1;
    }
    
    if (arg0 == "C4")
    {
        obj_stat_track.stat_C4_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_C4_high)
            obj_stat_track.stat_C4_high = arg1;
    }
    
    if (arg0 == "PlagueMask")
    {
        obj_stat_track.stat_plaguemask_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_plaguemask_high)
            obj_stat_track.stat_plaguemask_high = arg1;
    }
    
    if (arg0 == "FireLighter")
    {
        obj_stat_track.stat_firelighter_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_firelighter_high)
            obj_stat_track.stat_firelighter_high = arg1;
    }
    
    if (arg0 == "IceCream")
    {
        obj_stat_track.stat_icecream_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_icecream_high)
            obj_stat_track.stat_icecream_high = arg1;
    }
    
    if (arg0 == "Eel")
    {
        obj_stat_track.stat_eel_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_eel_high)
            obj_stat_track.stat_eel_high = arg1;
    }
    
    if (arg0 == "Gem")
    {
        obj_stat_track.stat_gem_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_gem_high)
            obj_stat_track.stat_gem_high = arg1;
    }
    
    if (arg0 == "Bow")
    {
        obj_stat_track.stat_bow_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_bow_high)
            obj_stat_track.stat_bow_high = arg1;
    }
    
    if (arg0 == "Flamethrower")
    {
        obj_stat_track.stat_flamethrower_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_flamethrower_high)
            obj_stat_track.stat_flamethrower_high = arg1;
    }
    
    if (arg0 == "SnowGlobe")
    {
        obj_stat_track.stat_snowglobe_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_snowglobe_high)
            obj_stat_track.stat_snowglobe_high = arg1;
    }
    
    if (arg0 == "Plasma")
    {
        obj_stat_track.stat_plasmaglobe_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_plasmaglobe_high)
            obj_stat_track.stat_plasmaglobe_high = arg1;
    }
    
    if (arg0 == "Satellite")
    {
        obj_stat_track.stat_satellite_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_satellite_high)
            obj_stat_track.stat_satellite_high = arg1;
    }
    
    if (arg0 == "Headphones")
    {
        obj_stat_track.stat_headphones_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_headphones_high)
            obj_stat_track.stat_headphones_high = arg1;
    }
    
    if (arg0 == "Spear")
    {
        obj_stat_track.stat_spear_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_spear_high)
            obj_stat_track.stat_spear_high = arg1;
    }
    
    if (arg0 == "Turret")
    {
        obj_stat_track.stat_turret_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_turret_high)
            obj_stat_track.stat_turret_high = arg1;
    }
    
    if (arg0 == "Ninja")
    {
        obj_stat_track.stat_ninja_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_ninja_high)
            obj_stat_track.stat_ninja_high = arg1;
    }
    
    if (arg0 == "ShottyVest")
    {
        obj_stat_track.stat_shottyvest_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_shottyvest_high)
            obj_stat_track.stat_shottyvest_high = arg1;
    }
    
    if (arg0 == "Remote")
    {
        obj_stat_track.stat_remote_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_remote_high)
            obj_stat_track.stat_remote_high = arg1;
    }
    
    if (arg0 == "Sword")
    {
        obj_stat_track.stat_chainsword_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_chainsword_high)
            obj_stat_track.stat_chainsword_high = arg1;
    }
    
    if (arg0 == "Firewall")
    {
        obj_stat_track.stat_firewall_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_firewall_high)
            obj_stat_track.stat_firewall_high = arg1;
    }
    
    if (arg0 == "Death")
    {
        obj_stat_track.stat_death_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_death_high)
            obj_stat_track.stat_death_high = arg1;
    }
    
    if (arg0 == "Corrupt")
    {
        obj_stat_track.stat_corrupt_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_corrupt_high)
            obj_stat_track.stat_corrupt_high = arg1;
    }
    
    if (arg0 == "Cigar")
    {
        obj_stat_track.stat_cigar_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_cigar_high)
            obj_stat_track.stat_cigar_high = arg1;
    }
    
    if (arg0 == "Dynamite")
    {
        obj_stat_track.stat_dynamite_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_dynamite_high)
            obj_stat_track.stat_dynamite_high = arg1;
    }
    
    if (arg0 == "Award")
    {
        obj_stat_track.stat_award_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_award_high)
            obj_stat_track.stat_award_high = arg1;
    }
    
    if (arg0 == "Carrot")
    {
        obj_stat_track.stat_carrot_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_carrot_high)
            obj_stat_track.stat_carrot_high = arg1;
    }
    
    if (arg0 == "Bees")
    {
        obj_stat_track.stat_bees_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_bees_high)
            obj_stat_track.stat_bees_high = arg1;
    }
    
    if (arg0 == "Monkey")
    {
        obj_stat_track.stat_monkey_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_monkey_high)
            obj_stat_track.stat_monkey_high = arg1;
    }
    
    if (arg0 == "Midas")
    {
        obj_stat_track.stat_midas_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_midas_high)
            obj_stat_track.stat_midas_high = arg1;
    }
    
    if (arg0 == "Fish")
    {
        obj_stat_track.stat_fish_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_fish_high)
            obj_stat_track.stat_fish_high = arg1;
    }
    
    if (arg0 == "Cheese")
    {
        obj_stat_track.stat_cheese_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_cheese_high)
            obj_stat_track.stat_cheese_high = arg1;
    }
    
    if (arg0 == "Psycho")
    {
        obj_stat_track.stat_psycho_picked += arg1;
        
        if (arg1 > obj_stat_track.stat_psycho_high)
            obj_stat_track.stat_psycho_high = arg1;
    }
}
