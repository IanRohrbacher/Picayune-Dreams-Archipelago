function try_to_unlock_achievements()
{
    // if (global.gamemode != "freeplay")
    // {
    //     if (obj_stat_track.stat_total_kills >= 10000)
    //         attempt_to_unlock_achievement("Slayer");
        
    //     if (obj_stat_track.stat_total_kills >= 25000)
    //         attempt_to_unlock_achievement("Exterminator");
        
    //     if (obj_stat_track.stat_total_kills >= 50000)
    //         attempt_to_unlock_achievement("Annihilator");
        
    //     if (obj_stat_track.stat_total_kills >= 100000)
    //         attempt_to_unlock_achievement("Vorpal");
        
    //     if (obj_stat_track.stat_total_kills >= 500000)
    //         attempt_to_unlock_achievement("Apex");
        
    //     if (obj_stat_track.stat_total_kills >= 1000000)
    //         attempt_to_unlock_achievement("Behemoth");
        
    //     if (obj_stat_track.stat_bosses_killed >= 25)
    //         attempt_to_unlock_achievement("Bossbane");
        
    //     if (obj_stat_track.stat_upgrades_chosen >= 100)
    //         attempt_to_unlock_achievement("Augmentation_Adept");
        
    //     if (obj_stat_track.stat_upgrades_chosen >= 500)
    //         attempt_to_unlock_achievement("Enhancement_Enthusiast");
        
    //     if (obj_stat_track.stat_upgrades_chosen >= 1000)
    //         attempt_to_unlock_achievement("Modification_Maven");
        
    //     if (obj_stat_track.stat_highest_mortality >= 30)
    //         attempt_to_unlock_achievement("Deja_Vu");
        
    //     if (obj_stat_track.stat_highest_mortality >= 40)
    //         attempt_to_unlock_achievement("Into_The_Unknown");
        
    //     if (obj_stat_track.stat_highest_mortality >= 50)
    //         attempt_to_unlock_achievement("Conqueror_Of_The_Abyss");
        
    //     if (obj_stat_track.stat_dice_pickup >= 10)
    //         attempt_to_unlock_achievement("Cubist");
        
    //     if (obj_stat_track.stat_hpvial_pickup >= 10)
    //         attempt_to_unlock_achievement("Vitalist");
        
    //     if (obj_stat_track.stat_grenade_pickup >= 10)
    //         attempt_to_unlock_achievement("Dynamite");
        
    //     if (obj_stat_track.stat_blackhole_pickup >= 10)
    //         attempt_to_unlock_achievement("Graviton");
        
    //     if (obj_stat_track.stat_magnet_pickup >= 10)
    //         attempt_to_unlock_achievement("Purge");
        
    //     if (obj_stat_track.stat_floppy_pickup >= 10)
    //         attempt_to_unlock_achievement("Diskette");
        
    //     if (obj_stat_track.stat_drill_pickup >= 10)
    //         attempt_to_unlock_achievement("Acupuncturist");
        
    //     if (global.profile_level >= 5)
    //         attempt_to_unlock_achievement("USB");
        
    //     if (global.profile_level >= 10)
    //         attempt_to_unlock_achievement("Hard Drive");
        
    //     if (global.profile_level >= 15)
    //         attempt_to_unlock_achievement("Server");
        
    //     if (global.profile_level >= 20)
    //         attempt_to_unlock_achievement("Mainframe");
        
    //     if (global.profile_level >= 25)
    //         attempt_to_unlock_achievement("Defense_System");
        
    //     if (obj_stat_track.stat_core_high >= 8)
    //         attempt_to_unlock_achievement("CORE_Expert");
        
    //     if (obj_stat_track.stat_chainbelt_high >= 8)
    //         attempt_to_unlock_achievement("Chainbelt_Expert");
        
    //     if (obj_stat_track.stat_daggerglove_high >= 8)
    //         attempt_to_unlock_achievement("Dagger_Glove_Expert");
        
    //     if (obj_stat_track.stat_eye2_high >= 8)
    //         attempt_to_unlock_achievement("Eye2_Expert");
        
    //     if (obj_stat_track.stat_injection_high >= 8)
    //         attempt_to_unlock_achievement("Injection_Expert");
        
    //     if (obj_stat_track.stat_battery_high >= 8)
    //         attempt_to_unlock_achievement("Energizing_Battery_Expert");
        
    //     if (obj_stat_track.stat_ivbag_high >= 8)
    //         attempt_to_unlock_achievement("IV_Bag_Expert");
        
    //     if (obj_stat_track.stat_crown_high >= 8)
    //         attempt_to_unlock_achievement("Crown_Expert");
        
    //     if (obj_stat_track.stat_plaguemask_high >= 8)
    //         attempt_to_unlock_achievement("Mask_Of_Plague_Expert");
        
    //     if (obj_stat_track.stat_legsaw_high >= 8)
    //         attempt_to_unlock_achievement("Legsaw_Expert");
        
    //     if (obj_stat_track.stat_missilepack_high >= 8)
    //         attempt_to_unlock_achievement("Missile_Pack_Expert");
        
    //     if (obj_stat_track.stat_parasight_high >= 8)
    //         attempt_to_unlock_achievement("Parasight_Expert");
        
    //     if (obj_stat_track.stat_yoyo_high >= 8)
    //         attempt_to_unlock_achievement("Yoyo_Rack_Expert");
        
    //     if (obj_stat_track.stat_bow_high >= 8)
    //         attempt_to_unlock_achievement("Hunters_Bow_Expert");
        
    //     if (obj_stat_track.stat_ninja_high >= 8)
    //         attempt_to_unlock_achievement("Shinobi_Equipment_Expert");
        
    //     if (obj_stat_track.stat_horns_high >= 8)
    //         attempt_to_unlock_achievement("Horns_Expert");
        
    //     if (obj_stat_track.stat_hydro_high >= 8)
    //         attempt_to_unlock_achievement("Hydrocillator_Expert");
        
    //     if (obj_stat_track.stat_flamethrower_high >= 8)
    //         attempt_to_unlock_achievement("Flame_Thrower_Expert");
        
    //     if (obj_stat_track.stat_snowglobe_high >= 8)
    //         attempt_to_unlock_achievement("Frost_Globe_Expert");
        
    //     if (obj_stat_track.stat_plasmaglobe_high >= 8)
    //         attempt_to_unlock_achievement("Plasma_Lamp_Expert");
        
    //     if (obj_stat_track.stat_satellite_high >= 8)
    //         attempt_to_unlock_achievement("Static_Satellite_Expert");
        
    //     if (obj_stat_track.stat_headphones_high >= 8)
    //         attempt_to_unlock_achievement("Wicked_Walkman_Expert");
        
    //     if (obj_stat_track.stat_spear_high >= 8)
    //         attempt_to_unlock_achievement("Soul_Spear_Expert");
        
    //     if (obj_stat_track.stat_turret_high >= 8)
    //         attempt_to_unlock_achievement("Defense_Turret_Expert");
        
    //     if (obj_stat_track.stat_halo_high >= 8)
    //         attempt_to_unlock_achievement("Halo_Expert");
        
    //     if (obj_stat_track.stat_remote_high >= 8)
    //         attempt_to_unlock_achievement("Strike_Call_Expert");
        
    //     if (obj_stat_track.stat_angelwings_high >= 8)
    //         attempt_to_unlock_achievement("Angel_Wings_Expert");
        
    //     if (obj_stat_track.stat_batwings_high >= 8)
    //         attempt_to_unlock_achievement("Demon_Wings_Expert");
        
    //     if (obj_stat_track.stat_digiwatch_high >= 8)
    //         attempt_to_unlock_achievement("Digiwatch_Expert");
        
    //     if (obj_stat_track.stat_engine_high >= 8)
    //         attempt_to_unlock_achievement("Overcharged_Engine_Expert");
        
    //     if (obj_stat_track.stat_C4_high >= 8)
    //         attempt_to_unlock_achievement("Volatile_C4_Expert");
        
    //     if (obj_stat_track.stat_firelighter_high >= 8)
    //         attempt_to_unlock_achievement("Fire_Lighter_Expert");
        
    //     if (obj_stat_track.stat_icecream_high >= 8)
    //         attempt_to_unlock_achievement("Frosty_Cone_Expert");
        
    //     if (obj_stat_track.stat_eel_high >= 8)
    //         attempt_to_unlock_achievement("Electric_Eel_Expert");
        
    //     if (obj_stat_track.stat_gem_high >= 8)
    //         attempt_to_unlock_achievement("Element_Crystal_Expert");
        
    //     if (obj_stat_track.stat_shottyvest_high >= 8)
    //         attempt_to_unlock_achievement("Shrapnel_Shells_Expert");
        
    //     if (obj_stat_track.stat_telecom_high >= 8)
    //         attempt_to_unlock_achievement("Telecom_Expert");
        
    //     if (obj_stat_track.stat_slimespike_high >= 8)
    //         attempt_to_unlock_achievement("Slime_Spike_Expert");
        
    //     if (obj_stat_track.stat_ultrabuster_high >= 8)
    //         attempt_to_unlock_achievement("Ultrabuster_Expert");
        
    //     if (global.daily_runs_won >= 1)
    //         attempt_to_unlock_achievement("Revolution");
        
    //     if (global.has_beaten_game > 0)
    //         attempt_to_unlock_achievement("Awaken");
        
    //     if (global.has_beaten_game > 1)
    //         attempt_to_unlock_achievement("Well_Rested");
        
    //     if (global.demon_memory == 1)
    //         attempt_to_unlock_achievement("Seen_It_All");
        
    //     if (obj_stat_track.stat_bunny_kills > 0)
    //         attempt_to_unlock_achievement("boss_rabbit");
        
    //     if (obj_stat_track.stat_worm_kills > 0)
    //         attempt_to_unlock_achievement("boss_worm");
        
    //     if (obj_stat_track.stat_biker_kills > 0)
    //         attempt_to_unlock_achievement("boss_biker");
        
    //     if (obj_stat_track.stat_demon_kills > 0)
    //         attempt_to_unlock_achievement("boss_demon");
        
    //     if (obj_stat_track.stat_picayune_kills > 0)
    //         attempt_to_unlock_achievement("boss_picayune");
        
    //     if (obj_stat_track.stat_ghost_kills > 0)
    //         attempt_to_unlock_achievement("boss_ghost");
        
    //     if (obj_stat_track.stat_yuki_kills > 0)
    //         attempt_to_unlock_achievement("boss_yuki");
        
    //     if (obj_stat_track.overdrive_max >= 2)
    //         attempt_to_unlock_achievement("Coder");
        
    //     if (obj_stat_track.overdrive_max >= 3)
    //         attempt_to_unlock_achievement("Scripter");
        
    //     if (obj_stat_track.overdrive_max >= 4)
    //         attempt_to_unlock_achievement("Debugger");
        
    //     if (obj_stat_track.overdrive_max >= 5)
    //         attempt_to_unlock_achievement("Modder");
        
    //     if (obj_stat_track.overdrive_max >= 6)
    //         attempt_to_unlock_achievement("Maestro");
        
    //     if (obj_stat_track.stat_runs_attempted > 0)
    //         attempt_to_unlock_achievement("Dreaming");
        
    //     if (global.monthly_runs_tried > 0)
    //         attempt_to_unlock_achievement("Lunation");
        
    //     if (obj_stat_track.stat_ab_bunny_flawless + obj_stat_track.stat_ab_worm_flawless + obj_stat_track.stat_ab_biker_flawless + obj_stat_track.stat_ab_demon_flawless + obj_stat_track.stat_ab_picayune_flawless)
    //         attempt_to_unlock_achievement("Dauntless");
        
    //     if (obj_stat_track.stat_fishstockrun > 0)
    //         attempt_to_unlock_achievement("Investor");
        
    //     if (obj_stat_track.stat_killedallrun > 0)
    //         attempt_to_unlock_achievement("Rigorous");
        
    //     if (obj_stat_track.stat_blackholes_used_onerun >= 20)
    //         attempt_to_unlock_achievement("Absorbent");
        
    //     if (obj_stat_track.unlocked_trophy > 0)
    //         attempt_to_unlock_achievement("Delivery");
        
    //     if (obj_stat_track.stat_most_xp_worth >= 1.5)
    //         attempt_to_unlock_achievement("Valuable");
        
    //     if (obj_stat_track.stat_sacrificed_crowns >= 25)
    //         attempt_to_unlock_achievement("Bankrupt");
        
    //     if (obj_stat_track.stat_lowest_skills <= 5)
    //         attempt_to_unlock_achievement("Frugal");
        
    //     if (obj_stat_track.stat_outofbounds > 0)
    //         attempt_to_unlock_achievement("Transgress");
        
    //     if (obj_stat_track.unlocked_suit_glass > 0)
    //         attempt_to_unlock_achievement("Invincible");
        
    //     if (obj_stat_track.stat_lowerthanfiftycd > 0)
    //         attempt_to_unlock_achievement("Slug");
        
    //     if (obj_stat_track.stat_highest_upgrades >= 300)
    //         attempt_to_unlock_achievement("Savant");
        
    //     if (obj_stat_track.stat_highest_items >= 20)
    //         attempt_to_unlock_achievement("Dexterous");
        
    //     if (obj_stat_track.stat_lowest_items <= 4)
    //         attempt_to_unlock_achievement("Organized");
        
    //     if (obj_stat_track.stat_lowest_items <= 2)
    //         attempt_to_unlock_achievement("Minimalist");
        
    //     if (obj_stat_track.stat_most_direct_hits_in_one_run >= 50)
    //         attempt_to_unlock_achievement("Wall");
        
    //     if (obj_stat_track.stat_fastest_boss_death <= 1200)
    //         attempt_to_unlock_achievement("Fleet");
        
    //     if (obj_stat_track.stat_elemental_run > 0)
    //         attempt_to_unlock_achievement("Condensation");
        
    //     if (obj_stat_track.stat_chainsword_high >= 8)
    //         attempt_to_unlock_achievement("Chainsword Expert");
        
    //     if (obj_stat_track.stat_firewall_high >= 8)
    //         attempt_to_unlock_achievement("Pop Up Firewall Expert");
        
    //     if (obj_stat_track.stat_death_high >= 8)
    //         attempt_to_unlock_achievement("Reaper Scythe Expert");
        
    //     if (obj_stat_track.stat_corrupt_high >= 8)
    //         attempt_to_unlock_achievement("Corrupt Tentacle Expert");
        
    //     if (obj_stat_track.stat_cigar_high >= 8)
    //         attempt_to_unlock_achievement("Fancy Cigar Expert");
        
    //     if (obj_stat_track.stat_dynamite_high >= 8)
    //         attempt_to_unlock_achievement("Blastin Sticks Expert");
        
    //     if (obj_stat_track.stat_award_high >= 8)
    //         attempt_to_unlock_achievement("Mising Award Expert");
        
    //     if (obj_stat_track.stat_carrot_high >= 8)
    //         attempt_to_unlock_achievement("Funky Carrot Expert");
        
    //     if (obj_stat_track.stat_bees_high >= 8)
    //         attempt_to_unlock_achievement("Lots Of Bees Expert");
        
    //     if (obj_stat_track.stat_monkey_high >= 8)
    //         attempt_to_unlock_achievement("Blessed Monkey Expert");
        
    //     if (obj_stat_track.stat_midas_high >= 8)
    //         attempt_to_unlock_achievement("Midas Hand Expert");
        
    //     if (obj_stat_track.stat_fish_high >= 8)
    //         attempt_to_unlock_achievement("DaggerFish Conch Expert");
        
    //     if (obj_stat_track.stat_cheese_high >= 8)
    //         attempt_to_unlock_achievement("Stinky Cheese Expert");
        
    //     if (obj_stat_track.stat_psycho_high >= 8)
    //         attempt_to_unlock_achievement("Psycho Helmet Expert");
    // }
}
