var hover_alph = 1;

if (instance_place(x, y, obj_mouse))
{
    depth = dep - 1;
    
    if (hovering == false)
    {
        hovering = true;
        playsnd(global.sounds.snd_opt_rebind_select_option, 0.8, false, 0.3);
    }
    
    hover_alph = 0.6;
    
    if (mouse_check_button(mb_left) || global.gp_accept)
    {
        hover_alph = 0.3;
        
        if (hold == true)
        {
            if (!audio_is_playing(global.sounds.snd_bunny_jump))
                playsnd(global.sounds.snd_bunny_jump, 0.75, true, 0.5);
            
            audio_sound_pitch(global.sounds.snd_bunny_jump, 0.75 + (hold_timer / 4));
            hold_timer += 0.1;
            screenshake(hold_timer / 10, 10);
            title = "HOLD TO NUKE YOUR SAVE!!!";
            
            if (hold_timer > 30)
            {
                hold_timer = 0;
                playsnd(global.sounds.snd_opt_toggle_true, 1, 0, 1);
                audio_stop_sound(global.sounds.snd_bunny_jump);
                playsnd(global.sounds.snd_Menu_Open_1, 1, false, 1);
                screenshake(10, 30);
                file_rename(global.save, global.save_dir + string(irandom(99999999)));
                game_end();
            }
        }
    }
    else if (hold == true)
    {
        title = "!! SAVE NUKE !!";
        hold_timer = 0;
        audio_stop_sound(global.sounds.snd_bunny_jump);
        audio_sound_pitch(global.sounds.snd_bunny_jump, 1);
    }
    
    if (mouse_check_button_released(mb_left) || global.gp_accept_pressed)
    {
        if (button == true)
        {
            image_xscale = 0.25;
            image_yscale = 0.25;
            playsnd(global.sounds.snd_opt_toggle_true, 1, 0, 1);
            
            if (variable == "saverestore")
            {
                ini_open(global.save);
                
                if (steam_get_achievement("boss_rabbit"))
                {
                    obj_stat_track.stat_bunny_kills = max(1, obj_stat_track.stat_bunny_kills);
                    obj_stat_track.stat_highest_mortality = max(6, obj_stat_track.stat_highest_mortality);
                    global.bunny_memory = 1;
                }
                
                ini_write_real("boss", "bunny_memory", global.bunny_memory);
                
                if (steam_get_achievement("boss_worm"))
                {
                    obj_stat_track.stat_worm_kills = max(1, obj_stat_track.stat_worm_kills);
                    obj_stat_track.stat_highest_mortality = max(11, obj_stat_track.stat_highest_mortality);
                    global.worm_memory = 1;
                }
                
                ini_write_real("boss", "worm_memory", global.worm_memory);
                
                if (steam_get_achievement("boss_biker"))
                {
                    obj_stat_track.stat_biker_kills = max(1, obj_stat_track.stat_biker_kills);
                    obj_stat_track.stat_highest_mortality = max(16, obj_stat_track.stat_highest_mortality);
                    global.biker_memory = 1;
                }
                
                ini_write_real("boss", "biker_memory", global.biker_memory);
                
                if (steam_get_achievement("boss_demon"))
                {
                    obj_stat_track.stat_demon_kills = max(1, obj_stat_track.stat_demon_kills);
                    obj_stat_track.stat_highest_mortality = max(21, obj_stat_track.stat_highest_mortality);
                    global.demon_memory = 1;
                }
                
                ini_write_real("boss", "demon_memory", global.demon_memory);
                
                if (steam_get_achievement("boss_picayune"))
                {
                    obj_stat_track.stat_picayune_kills = max(1, obj_stat_track.stat_picayune_kills);
                    obj_stat_track.stat_highest_mortality = max(26, obj_stat_track.stat_highest_mortality);
                }
                
                if (steam_get_achievement("boss_ghost"))
                    obj_stat_track.stat_ghost_kills = max(1, obj_stat_track.stat_ghost_kills);
                
                if (steam_get_achievement("boss_yuki"))
                    obj_stat_track.stat_yuki_kills = max(1, obj_stat_track.stat_yuki_kills);
                
                if (steam_get_achievement("Seen_It_All"))
                    obj_stat_track.stat_memories_visited = max(4, obj_stat_track.stat_memories_visited);
                
                if (steam_get_achievement("Awaken"))
                    global.has_beaten_game = max(1, global.has_beaten_game);
                
                if (steam_get_achievement("Well_Rested"))
                    global.has_beaten_game = max(2, global.has_beaten_game);
                
                ini_write_real("stats", "profile_level", global.has_beaten_game);
                
                if (steam_get_achievement("Coder"))
                    obj_stat_track.overdrive_max = max(2, obj_stat_track.overdrive_max);
                
                if (steam_get_achievement("Scripter"))
                    obj_stat_track.overdrive_max = max(3, obj_stat_track.overdrive_max);
                
                if (steam_get_achievement("Debugger"))
                    obj_stat_track.overdrive_max = max(4, obj_stat_track.overdrive_max);
                
                if (steam_get_achievement("Modder"))
                    obj_stat_track.overdrive_max = max(5, obj_stat_track.overdrive_max);
                
                if (steam_get_achievement("Maestro"))
                    obj_stat_track.overdrive_max = max(6, obj_stat_track.overdrive_max);
                
                if (steam_get_achievement("Slayer"))
                    obj_stat_track.stat_total_kills = max(10000, obj_stat_track.stat_total_kills);
                
                if (steam_get_achievement("Exterminator"))
                    obj_stat_track.stat_total_kills = max(25000, obj_stat_track.stat_total_kills);
                
                if (steam_get_achievement("Annihilator"))
                    obj_stat_track.stat_total_kills = max(50000, obj_stat_track.stat_total_kills);
                
                if (steam_get_achievement("Vorpal"))
                    obj_stat_track.stat_total_kills = max(100000, obj_stat_track.stat_total_kills);
                
                if (steam_get_achievement("Apex"))
                    obj_stat_track.stat_total_kills = max(500000, obj_stat_track.stat_total_kills);
                
                if (steam_get_achievement("Behemoth"))
                    obj_stat_track.stat_total_kills = max(1000000, obj_stat_track.stat_total_kills);
                
                if (steam_get_achievement("Bossbane"))
                    obj_stat_track.stat_bosses_killed = max(25, obj_stat_track.stat_bosses_killed);
                
                if (steam_get_achievement("Enhancement_Enthusiast"))
                    obj_stat_track.stat_upgrades_chosen = max(500, obj_stat_track.stat_upgrades_chosen);
                
                if (steam_get_achievement("Modification_Maven"))
                    obj_stat_track.stat_upgrades_chosen = max(1000, obj_stat_track.stat_upgrades_chosen);
                
                if (steam_get_achievement("Deja_Vu"))
                    obj_stat_track.stat_highest_mortality = max(30, obj_stat_track.stat_highest_mortality);
                
                if (steam_get_achievement("Into_The_Unknown"))
                    obj_stat_track.stat_highest_mortality = max(40, obj_stat_track.stat_highest_mortality);
                
                if (steam_get_achievement("Conqueror_Of_The_Abyss"))
                    obj_stat_track.stat_highest_mortality = max(50, obj_stat_track.stat_highest_mortality);
                
                if (steam_get_achievement("Cubist"))
                    obj_stat_track.stat_dice_pickup = max(10, obj_stat_track.stat_dice_pickup);
                
                if (steam_get_achievement("Vitalist"))
                    obj_stat_track.stat_hpvial_pickup = max(10, obj_stat_track.stat_hpvial_pickup);
                
                if (steam_get_achievement("Dynamite"))
                    obj_stat_track.stat_grenade_pickup = max(10, obj_stat_track.stat_grenade_pickup);
                
                if (steam_get_achievement("Graviton"))
                    obj_stat_track.stat_blackhole_pickup = max(10, obj_stat_track.stat_blackhole_pickup);
                
                if (steam_get_achievement("Purge"))
                    obj_stat_track.stat_magnet_pickup = max(10, obj_stat_track.stat_magnet_pickup);
                
                if (steam_get_achievement("Diskette"))
                    obj_stat_track.stat_floppy_pickup = max(10, obj_stat_track.stat_floppy_pickup);
                
                if (steam_get_achievement("Acupuncturist"))
                    obj_stat_track.stat_drill_pickup = max(10, obj_stat_track.stat_drill_pickup);
                
                if (global.prestige == 0)
                {
                    if (steam_get_achievement("USB"))
                        global.profile_level = max(5, global.profile_level);
                    
                    if (steam_get_achievement("Hard Drive"))
                        global.profile_level = max(10, global.profile_level);
                    
                    if (steam_get_achievement("Server"))
                        global.profile_level = max(15, global.profile_level);
                    
                    if (steam_get_achievement("Mainframe"))
                        global.profile_level = max(20, global.profile_level);
                    
                    if (steam_get_achievement("Defense_System"))
                        global.profile_level = max(25, global.profile_level);
                    
                    ini_write_real("stats", "profile_level", global.profile_level);
                    global.points_avaliable = global.profile_level + clamp(obj_stat_track.overdrive_max - 1, 0, 9999);
                }
                
                if (steam_get_achievement("CORE_Expert"))
                {
                    obj_stat_track.stat_core_high = max(8, obj_stat_track.stat_core_high);
                    obj_stat_track.stat_core_picked = max(8, obj_stat_track.stat_core_picked);
                }
                
                if (steam_get_achievement("Chainbelt_Expert"))
                {
                    obj_stat_track.stat_chainbelt_high = max(8, obj_stat_track.stat_chainbelt_high);
                    obj_stat_track.stat_chainbelt_picked = max(8, obj_stat_track.stat_chainbelt_picked);
                }
                
                if (steam_get_achievement("Dagger_Glove_Expert"))
                {
                    obj_stat_track.stat_daggerglove_high = max(8, obj_stat_track.stat_daggerglove_high);
                    obj_stat_track.stat_daggerglove_picked = max(8, obj_stat_track.stat_daggerglove_picked);
                }
                
                if (steam_get_achievement("Eye2_Expert"))
                {
                    obj_stat_track.stat_eye2_high = max(8, obj_stat_track.stat_eye2_high);
                    obj_stat_track.stat_eye2_picked = max(8, obj_stat_track.stat_eye2_picked);
                }
                
                if (steam_get_achievement("Injection_Expert"))
                {
                    obj_stat_track.stat_injection_high = max(8, obj_stat_track.stat_injection_high);
                    obj_stat_track.stat_injection_picked = max(8, obj_stat_track.stat_injection_picked);
                }
                
                if (steam_get_achievement("Energizing_Battery_Expert"))
                {
                    obj_stat_track.stat_battery_high = max(8, obj_stat_track.stat_battery_high);
                    obj_stat_track.stat_battery_picked = max(8, obj_stat_track.stat_battery_picked);
                }
                
                if (steam_get_achievement("IV_Bag_Expert"))
                {
                    obj_stat_track.stat_ivbag_high = max(8, obj_stat_track.stat_ivbag_high);
                    obj_stat_track.stat_ivbag_picked = max(8, obj_stat_track.stat_ivbag_picked);
                }
                
                if (steam_get_achievement("Crown_Expert"))
                {
                    obj_stat_track.stat_crown_high = max(8, obj_stat_track.stat_crown_high);
                    obj_stat_track.stat_crown_picked = max(8, obj_stat_track.stat_crown_picked);
                }
                
                if (steam_get_achievement("Mask_Of_Plague_Expert"))
                {
                    obj_stat_track.stat_plaguemask_high = max(8, obj_stat_track.stat_plaguemask_high);
                    obj_stat_track.stat_plaguemask_picked = max(8, obj_stat_track.stat_plaguemask_picked);
                }
                
                if (steam_get_achievement("Legsaw_Expert"))
                {
                    obj_stat_track.stat_legsaw_high = max(8, obj_stat_track.stat_legsaw_high);
                    obj_stat_track.stat_legsaw_picked = max(8, obj_stat_track.stat_legsaw_picked);
                }
                
                if (steam_get_achievement("Missile_Pack_Expert"))
                {
                    obj_stat_track.stat_missilepack_high = max(8, obj_stat_track.stat_missilepack_high);
                    obj_stat_track.stat_missilepack_picked = max(8, obj_stat_track.stat_missilepack_picked);
                }
                
                if (steam_get_achievement("Parasight_Expert"))
                {
                    obj_stat_track.stat_parasight_high = max(8, obj_stat_track.stat_parasight_high);
                    obj_stat_track.stat_parasight_picked = max(8, obj_stat_track.stat_parasight_picked);
                }
                
                if (steam_get_achievement("Yoyo_Rack_Expert"))
                {
                    obj_stat_track.stat_yoyo_high = max(8, obj_stat_track.stat_yoyo_high);
                    obj_stat_track.stat_yoyo_picked = max(8, obj_stat_track.stat_yoyo_picked);
                }
                
                if (steam_get_achievement("Hunters_Bow_Expert"))
                {
                    obj_stat_track.stat_bow_high = max(8, obj_stat_track.stat_bow_high);
                    obj_stat_track.stat_bow_picked = max(8, obj_stat_track.stat_bow_picked);
                }
                
                if (steam_get_achievement("Shinobi_Equipment_Expert"))
                {
                    obj_stat_track.stat_ninja_high = max(8, obj_stat_track.stat_ninja_high);
                    obj_stat_track.stat_ninja_picked = max(8, obj_stat_track.stat_ninja_picked);
                }
                
                if (steam_get_achievement("Horns_Expert"))
                {
                    obj_stat_track.stat_horns_high = max(8, obj_stat_track.stat_horns_high);
                    obj_stat_track.stat_horns_picked = max(8, obj_stat_track.stat_horns_picked);
                }
                
                if (steam_get_achievement("Hydrocillator_Expert"))
                {
                    obj_stat_track.stat_hydro_high = max(8, obj_stat_track.stat_hydro_high);
                    obj_stat_track.stat_hydro_picked = max(8, obj_stat_track.stat_hydro_picked);
                }
                
                if (steam_get_achievement("Flame_Thrower_Expert"))
                {
                    obj_stat_track.stat_flamethrower_high = max(8, obj_stat_track.stat_flamethrower_high);
                    obj_stat_track.stat_flamethrower_picked = max(8, obj_stat_track.stat_flamethrower_picked);
                }
                
                if (steam_get_achievement("Frost_Globe_Expert"))
                {
                    obj_stat_track.stat_snowglobe_high = max(8, obj_stat_track.stat_snowglobe_high);
                    obj_stat_track.stat_snowglobe_picked = max(8, obj_stat_track.stat_snowglobe_picked);
                }
                
                if (steam_get_achievement("Plasma_Lamp_Expert"))
                {
                    obj_stat_track.stat_plasmaglobe_high = max(8, obj_stat_track.stat_plasmaglobe_high);
                    obj_stat_track.stat_plasmaglobe_picked = max(8, obj_stat_track.stat_plasmaglobe_picked);
                }
                
                if (steam_get_achievement("Static_Satellite_Expert"))
                {
                    obj_stat_track.stat_satellite_high = max(8, obj_stat_track.stat_satellite_high);
                    obj_stat_track.stat_satellite_picked = max(8, obj_stat_track.stat_satellite_picked);
                }
                
                if (steam_get_achievement("Wicked_Walkman_Expert"))
                {
                    obj_stat_track.stat_headphones_high = max(8, obj_stat_track.stat_headphones_high);
                    obj_stat_track.stat_headphones_picked = max(8, obj_stat_track.stat_headphones_picked);
                }
                
                if (steam_get_achievement("Soul_Spear_Expert"))
                {
                    obj_stat_track.stat_spear_high = max(8, obj_stat_track.stat_spear_high);
                    obj_stat_track.stat_spear_picked = max(8, obj_stat_track.stat_spear_picked);
                }
                
                if (steam_get_achievement("Defense_Turret_Expert"))
                {
                    obj_stat_track.stat_turret_high = max(8, obj_stat_track.stat_turret_high);
                    obj_stat_track.stat_turret_picked = max(8, obj_stat_track.stat_turret_picked);
                }
                
                if (steam_get_achievement("Halo_Expert"))
                {
                    obj_stat_track.stat_halo_high = max(8, obj_stat_track.stat_halo_high);
                    obj_stat_track.stat_halo_picked = max(8, obj_stat_track.stat_halo_picked);
                }
                
                if (steam_get_achievement("Strike_Call_Expert"))
                {
                    obj_stat_track.stat_statues_used = max(10, obj_stat_track.stat_statues_used);
                    obj_stat_track.stat_remote_high = max(8, obj_stat_track.stat_remote_high);
                    obj_stat_track.stat_remote_picked = max(8, obj_stat_track.stat_remote_picked);
                }
                
                if (steam_get_achievement("Angel_Wings_Expert"))
                {
                    obj_stat_track.stat_time_spent_still = max(50000, obj_stat_track.stat_time_spent_still);
                    obj_stat_track.stat_angelwings_high = max(8, obj_stat_track.stat_angelwings_high);
                    obj_stat_track.stat_angelwings_picked = max(8, obj_stat_track.stat_angelwings_picked);
                }
                
                if (steam_get_achievement("Demon_Wings_Expert"))
                {
                    obj_stat_track.stat_batwings_high = max(8, obj_stat_track.stat_batwings_high);
                    obj_stat_track.stat_batwings_picked = max(8, obj_stat_track.stat_batwings_picked);
                }
                
                if (steam_get_achievement("Digiwatch_Expert"))
                {
                    obj_stat_track.stat_digiwatch_high = max(8, obj_stat_track.stat_digiwatch_high);
                    obj_stat_track.stat_digiwatch_picked = max(8, obj_stat_track.stat_digiwatch_picked);
                }
                
                if (steam_get_achievement("Overcharged_Engine_Expert"))
                {
                    obj_stat_track.stat_engine_high = max(8, obj_stat_track.stat_engine_high);
                    obj_stat_track.stat_engine_picked = max(8, obj_stat_track.stat_engine_picked);
                }
                
                if (steam_get_achievement("Volatile_C4_Expert"))
                {
                    obj_stat_track.stat_C4_high = max(8, obj_stat_track.stat_C4_high);
                    obj_stat_track.stat_C4_picked = max(8, obj_stat_track.stat_C4_picked);
                }
                
                if (steam_get_achievement("Fire_Lighter_Expert"))
                {
                    obj_stat_track.stat_firelighter_high = max(8, obj_stat_track.stat_firelighter_high);
                    obj_stat_track.stat_firelighter_picked = max(8, obj_stat_track.stat_firelighter_picked);
                }
                
                if (steam_get_achievement("Frosty_Cone_Expert"))
                {
                    obj_stat_track.stat_icecream_high = max(8, obj_stat_track.stat_icecream_high);
                    obj_stat_track.stat_icecream_picked = max(8, obj_stat_track.stat_icecream_picked);
                }
                
                if (steam_get_achievement("Electric_Eel_Expert"))
                {
                    obj_stat_track.stat_eel_high = max(8, obj_stat_track.stat_eel_high);
                    obj_stat_track.stat_eel_picked = max(8, obj_stat_track.stat_eel_picked);
                }
                
                if (steam_get_achievement("Element_Crystal_Expert"))
                {
                    obj_stat_track.stat_gem_high = max(8, obj_stat_track.stat_gem_high);
                    obj_stat_track.stat_gem_picked = max(8, obj_stat_track.stat_gem_picked);
                }
                
                if (steam_get_achievement("Shrapnel_Shells_Expert"))
                {
                    obj_stat_track.stat_shottyvest_high = max(8, obj_stat_track.stat_shottyvest_high);
                    obj_stat_track.stat_shottyvest_picked = max(8, obj_stat_track.stat_shottyvest_picked);
                }
                
                if (steam_get_achievement("Telecom_Expert"))
                {
                    obj_stat_track.stat_telecom_high = max(8, obj_stat_track.stat_telecom_high);
                    obj_stat_track.stat_telecom_picked = max(8, obj_stat_track.stat_telecom_picked);
                }
                
                if (steam_get_achievement("Slime_Spike_Expert"))
                {
                    obj_stat_track.stat_slimespike_high = max(8, obj_stat_track.stat_slimespike_high);
                    obj_stat_track.stat_slimespike_picked = max(8, obj_stat_track.stat_slimespike_picked);
                }
                
                if (steam_get_achievement("Ultrabuster_Expert"))
                {
                    obj_stat_track.stat_ultrabuster_high = max(8, obj_stat_track.stat_ultrabuster_high);
                    obj_stat_track.stat_ultrabuster_picked = max(8, obj_stat_track.stat_ultrabuster_picked);
                }
                
                if (steam_get_achievement("boss_umi"))
                    obj_stat_track.stat_umi_kills = max(1, obj_stat_track.stat_umi_kills);
                
                if (steam_get_achievement("boss_diver"))
                    obj_stat_track.stat_diver_kills = max(1, obj_stat_track.stat_diver_kills);
                
                if (steam_get_achievement("instance_destroy(obj_ab_rabbit)"))
                {
                    obj_stat_track.stat_ab_bunny_kills = max(1, obj_stat_track.stat_ab_bunny_kills);
                    obj_stat_track.stat_highest_mortality = max(31, obj_stat_track.stat_highest_mortality);
                }
                
                if (steam_get_achievement("instance_destroy(obj_ab_worm)"))
                {
                    obj_stat_track.stat_ab_worm_kills = max(1, obj_stat_track.stat_ab_worm_kills);
                    obj_stat_track.stat_highest_mortality = max(36, obj_stat_track.stat_highest_mortality);
                }
                
                if (steam_get_achievement("instance_destroy(obj_ab_biker)"))
                {
                    obj_stat_track.stat_ab_biker_kills = max(1, obj_stat_track.stat_ab_biker_kills);
                    obj_stat_track.stat_highest_mortality = max(41, obj_stat_track.stat_highest_mortality);
                }
                
                if (steam_get_achievement("instance_destroy(obj_ab_demon)"))
                {
                    obj_stat_track.stat_ab_demon_kills = max(1, obj_stat_track.stat_ab_demon_kills);
                    obj_stat_track.stat_highest_mortality = max(46, obj_stat_track.stat_highest_mortality);
                }
                
                if (steam_get_achievement("instance_exists(picayune)"))
                {
                    obj_stat_track.stat_ab_picayune_kills = max(1, obj_stat_track.stat_ab_picayune_kills);
                    obj_stat_track.stat_highest_mortality = max(51, obj_stat_track.stat_highest_mortality);
                    global.has_seen_bad_ending = true;
                }
                
                if (steam_get_achievement("Lunation"))
                    global.monthly_runs_tried = max(1, global.monthly_runs_tried);
                
                if (steam_get_achievement("Dauntless"))
                    obj_stat_track.stat_ab_bunny_flawless = max(1, obj_stat_track.stat_ab_bunny_flawless);
                
                if (steam_get_achievement("Investor"))
                    obj_stat_track.stat_fishstockrun = max(1, obj_stat_track.stat_fishstockrun);
                
                if (steam_get_achievement("Rigorous"))
                    obj_stat_track.stat_killedallrun = max(1, obj_stat_track.stat_killedallrun);
                
                if (steam_get_achievement("Absorbent"))
                    obj_stat_track.stat_blackholes_used_onerun = max(20, obj_stat_track.stat_blackholes_used_onerun);
                
                if (steam_get_achievement("Delivery"))
                    obj_stat_track.stat_goreallyfar = max(1, obj_stat_track.stat_goreallyfar);
                
                if (steam_get_achievement("Valuable"))
                    obj_stat_track.stat_most_xp_worth = max(1.5, obj_stat_track.stat_most_xp_worth);
                
                if (steam_get_achievement("Bankrupt"))
                    obj_stat_track.stat_sacrificed_crowns = max(25, obj_stat_track.stat_sacrificed_crowns);
                
                if (steam_get_achievement("Frugal"))
                    obj_stat_track.stat_lowest_skills = min(4, obj_stat_track.stat_lowest_skills);
                
                if (steam_get_achievement("Transgress"))
                    obj_stat_track.stat_outofbounds = max(1, obj_stat_track.stat_outofbounds);
                
                if (steam_get_achievement("Slug"))
                    obj_stat_track.stat_lowerthanfiftycd = max(1, obj_stat_track.stat_lowerthanfiftycd);
                
                if (steam_get_achievement("Savant"))
                    obj_stat_track.stat_highest_upgrades = max(300, obj_stat_track.stat_highest_upgrades);
                
                if (steam_get_achievement("Dexterous"))
                    obj_stat_track.stat_highest_items = max(20, obj_stat_track.stat_highest_items);
                
                if (steam_get_achievement("Organized"))
                    obj_stat_track.stat_lowest_items = min(4, obj_stat_track.stat_lowest_items);
                
                if (steam_get_achievement("Minimalist"))
                    obj_stat_track.stat_lowest_items = min(2, obj_stat_track.stat_lowest_items);
                
                if (steam_get_achievement("Wall"))
                    obj_stat_track.stat_most_direct_hits_in_one_run = max(50, obj_stat_track.stat_most_direct_hits_in_one_run);
                
                if (steam_get_achievement("Fleet"))
                    obj_stat_track.stat_fastest_boss_death = min(1140, obj_stat_track.stat_fastest_boss_death);
                
                if (steam_get_achievement("Condensation"))
                    obj_stat_track.stat_elemental_run = max(1, obj_stat_track.stat_elemental_run);
                
                if (steam_get_achievement("Chainsword Expert"))
                {
                    obj_stat_track.stat_chainsword_high = max(8, obj_stat_track.stat_chainsword_high);
                    obj_stat_track.stat_chainsword_picked = max(8, obj_stat_track.stat_chainsword_picked);
                }
                
                if (steam_get_achievement("Pop Up Firewall Expert"))
                {
                    obj_stat_track.stat_firewall_high = max(8, obj_stat_track.stat_firewall_high);
                    obj_stat_track.stat_firewall_picked = max(8, obj_stat_track.stat_firewall_picked);
                }
                
                if (steam_get_achievement("Reaper Scythe Expert"))
                {
                    obj_stat_track.stat_death_high = max(8, obj_stat_track.stat_death_high);
                    obj_stat_track.stat_death_picked = max(8, obj_stat_track.stat_death_picked);
                }
                
                if (steam_get_achievement("Corrupt Tentacle Expert"))
                {
                    obj_stat_track.stat_corrupt_high = max(8, obj_stat_track.stat_corrupt_high);
                    obj_stat_track.stat_corrupt_picked = max(8, obj_stat_track.stat_corrupt_picked);
                }
                
                if (steam_get_achievement("Fancy Cigar Expert"))
                {
                    obj_stat_track.stat_cigar_high = max(8, obj_stat_track.stat_cigar_high);
                    obj_stat_track.stat_cigar_picked = max(8, obj_stat_track.stat_cigar_picked);
                }
                
                if (steam_get_achievement("Blastin Sticks Expert"))
                {
                    obj_stat_track.stat_dynamite_high = max(8, obj_stat_track.stat_dynamite_high);
                    obj_stat_track.stat_dynamite_picked = max(8, obj_stat_track.stat_dynamite_picked);
                }
                
                if (steam_get_achievement("Mising Award Expert"))
                {
                    obj_stat_track.stat_award_high = max(8, obj_stat_track.stat_award_high);
                    obj_stat_track.stat_award_picked = max(8, obj_stat_track.stat_award_picked);
                }
                
                if (steam_get_achievement("Funky Carrot Expert"))
                {
                    obj_stat_track.stat_carrot_high = max(8, obj_stat_track.stat_carrot_high);
                    obj_stat_track.stat_carrot_picked = max(8, obj_stat_track.stat_carrot_picked);
                }
                
                if (steam_get_achievement("Lots Of Bees Expert"))
                {
                    obj_stat_track.stat_bees_high = max(8, obj_stat_track.stat_bees_high);
                    obj_stat_track.stat_bees_picked = max(8, obj_stat_track.stat_bees_picked);
                }
                
                if (steam_get_achievement("Blessed Monkey Expert"))
                {
                    obj_stat_track.stat_monkey_high = max(8, obj_stat_track.stat_monkey_high);
                    obj_stat_track.stat_monkey_picked = max(8, obj_stat_track.stat_monkey_picked);
                }
                
                if (steam_get_achievement("Midas Hand Expert"))
                {
                    obj_stat_track.stat_midas_high = max(8, obj_stat_track.stat_midas_high);
                    obj_stat_track.stat_midas_picked = max(8, obj_stat_track.stat_midas_picked);
                }
                
                if (steam_get_achievement("DaggerFish Conch Expert"))
                {
                    obj_stat_track.stat_fish_high = max(8, obj_stat_track.stat_fish_high);
                    obj_stat_track.stat_fish_picked = max(8, obj_stat_track.stat_fish_picked);
                }
                
                if (steam_get_achievement("Stinky Cheese Expert"))
                {
                    obj_stat_track.stat_cheese_high = max(8, obj_stat_track.stat_cheese_high);
                    obj_stat_track.stat_cheese_picked = max(8, obj_stat_track.stat_cheese_picked);
                }
                
                if (steam_get_achievement("Psycho Helmet Expert"))
                {
                    obj_stat_track.stat_psycho_high = max(8, obj_stat_track.stat_psycho_high);
                    obj_stat_track.stat_psycho_picked = max(8, obj_stat_track.stat_psycho_picked);
                }
                
                if (steam_get_achievement("Manual"))
                    obj_stat_track.stat_noautoaim = 1;
                
                if (steam_get_achievement("Duck_Hunt"))
                {
                    if (obj_stat_track.stat_soul_kills < 1)
                        obj_stat_track.stat_soul_kills = 1;
                    
                    if (obj_stat_track.stat_fish_kills < 1)
                        obj_stat_track.stat_fish_kills = 1;
                    
                    if (obj_stat_track.stat_glove_kills < 1)
                        obj_stat_track.stat_glove_kills = 1;
                    
                    if (obj_stat_track.stat_skull_kills < 1)
                        obj_stat_track.stat_skull_kills = 1;
                    
                    if (obj_stat_track.stat_face_kills < 1)
                        obj_stat_track.stat_face_kills = 1;
                    
                    if (obj_stat_track.stat_cornchip_kills < 1)
                        obj_stat_track.stat_cornchip_kills = 1;
                    
                    if (obj_stat_track.stat_wibbler_kills < 1)
                        obj_stat_track.stat_wibbler_kills = 1;
                    
                    if (obj_stat_track.stat_burger_kills < 1)
                        obj_stat_track.stat_burger_kills = 1;
                    
                    if (obj_stat_track.stat_droid_kills < 1)
                        obj_stat_track.stat_droid_kills = 1;
                    
                    if (obj_stat_track.stat_spider_kills < 1)
                        obj_stat_track.stat_spider_kills = 1;
                    
                    if (obj_stat_track.stat_shielder_kills < 1)
                        obj_stat_track.stat_shielder_kills = 1;
                    
                    if (obj_stat_track.stat_face_kills < 1)
                        obj_stat_track.stat_face_kills = 1;
                    
                    if (obj_stat_track.stat_exploder_kills < 1)
                        obj_stat_track.stat_exploder_kills = 1;
                    
                    if (obj_stat_track.stat_warper_kills < 1)
                        obj_stat_track.stat_warper_kills = 1;
                    
                    if (obj_stat_track.stat_wisp_kills < 1)
                        obj_stat_track.stat_wisp_kills = 1;
                    
                    if (obj_stat_track.stat_peapod_kills < 1)
                        obj_stat_track.stat_peapod_kills = 1;
                    
                    if (obj_stat_track.stat_centa_kills < 1)
                        obj_stat_track.stat_centa_kills = 1;
                    
                    if (obj_stat_track.stat_sniper_kills < 1)
                        obj_stat_track.stat_sniper_kills = 1;
                    
                    if (obj_stat_track.stat_lob_kills < 1)
                        obj_stat_track.stat_lob_kills = 1;
                    
                    if (obj_stat_track.stat_bishop_kills < 1)
                        obj_stat_track.stat_bishop_kills = 1;
                    
                    if (obj_stat_track.stat_elude_kills < 1)
                        obj_stat_track.stat_elude_kills = 1;
                    
                    if (obj_stat_track.stat_lidean_kills < 1)
                        obj_stat_track.stat_lidean_kills = 1;
                    
                    if (obj_stat_track.stat_whisker_kills < 1)
                        obj_stat_track.stat_whisker_kills = 1;
                }
                
                ini_close();
                
                with (obj_stat_track)
                    scr_save_all_stat();
            }
        }
        else if (toggled == 0)
        {
            toggled = 1;
            
            if (variable == "christmas")
                global.event = 1;
            
            playsnd(global.sounds.snd_opt_toggle_true, 1, 0, 1);
        }
        else if (toggled == 1)
        {
            toggled = 0;
            
            if (variable == "christmas")
                global.event = 0;
            
            playsnd(global.sounds.snd_opt_toggle_false, 1, 0, 1);
        }
        
        ini_open(global.save);
        
        if (variable == "christmas")
            ini_write_real("other", "event", global.event);
        
        ini_close();
    }
}
else
{
    if (hold == true)
    {
        title = "!! SAVE NUKE !!";
        hold_timer = 0;
        audio_stop_sound(global.sounds.snd_bunny_jump);
        audio_sound_pitch(global.sounds.snd_bunny_jump, 1);
    }
    
    depth = dep;
    hovering = false;
}

if (button == false)
{
    if (toggled == false)
        ico_blend = 8421504;
    else
        ico_blend = 16777215;
}
else
{
    image_xscale = approach(image_xscale, 1, 0.1);
    image_yscale = approach(image_yscale, 1, 0.1);
    
    if (hovering == false)
        ico_blend = 8421504;
    else
        ico_blend = 16777215;
}

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_black, 1);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, hover_alph);
draw_sprite_ext(global.sprites.spr_toggle_icos, ico_ind, x, y, image_xscale, image_yscale, 0, ico_blend, 1);

if (hovering == true)
{
    draw_set_halign(fa_right);
    var rain = c_rainbow(get_timer() / 10000);
    
    if (button == true)
        outline_text_ext(string(title), obj_mouse.x + 12, obj_mouse.y + 16, rain, 0, 1, -1, 99999, 1, 1, 0);
    else if (hold == true)
        outline_text_ext(string(title), obj_mouse.x + 12 + random_range(-1, 1), obj_mouse.y + 16 + random_range(-1, 1), 255, 0, 1, -1, 99999, 1, 1, 0);
    else
        outline_text_ext(string(title) + " [" + string(toggled) + "/1]", obj_mouse.x + 12, obj_mouse.y + 16, rain, 0, 1, -1, 99999, 1, 1, 0);
    
    outline_text_ext(string(desc), obj_mouse.x + 12, obj_mouse.y + 12 + 16, 16777215, 0, 1, -1, 200, 1, 1, 0);
    draw_set_halign(fa_left);
}
