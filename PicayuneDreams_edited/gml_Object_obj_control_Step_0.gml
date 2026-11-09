exp_spawned = instance_number(obj_dmg_pickup);
gameSpeed_Multiply = 1 + (10 - (gameSpeed * 10));
gameSpeed_Timer += (gameSpeed * 10);
enemyDefense_mult = (50 + (diff_gameminutes - 25)) / 50;
enemyDefense = 100 + (clamp(diff_gameminutes - 25, 0, 99999) * diff_gameminutes * enemyDefense_mult);
var number_of_enemies = instance_number(obj_enemy_parent);
var gettimer = get_timer();

if (stackoverflow_cd > -1)
    stackoverflow_cd -= gameSpeed;

if (crit_cd > -1)
    crit_cd -= gameSpeed;

var fishstockxpmod = 0;
fishstockxpmod = curr_fishmarket * 0.1;
var player_xp_mod = 0;
player_xp_mod = obj_player.powerup_xpworth / 100;
xp_mod_final = xp_mod + fishstockxpmod + player_xp_mod;
grenade_sound_cd -= gameSpeed;

if (obj_player.allow_overheal == false)
{
    global.hp = clamp(global.hp, 0, global.hpmax);
}
else if (global.hp > global.hpmax)
{
    if (instance_exists(obj_enemy_parent))
    {
        if (obj_player.outfit == "glass")
            ivbag_cd -= (gameSpeed * 10);
        else
            ivbag_cd -= gameSpeed;
    }
    
    if (ivbag_cd < 0)
    {
        global.hp -= 1;
        ivbag_cd = 20 * obj_player.powerup_ivbag;
    }
}
else if (global.hp < 0)
{
    global.hp = 0;
}

if (spawnenemies == true && !instance_exists(obj_platformer))
{
    if (obj_view.mortality_pause == false)
        diff_gameminutes += (0.000277 * gameSpeed);
    
    elite_enemy_timer += gameSpeed;
    
    if (gameSpeed > 0.1)
    {
        var moving_dir = irandom(360);
        
        if (obj_player.walking > 0)
            moving_dir = point_direction(0, 0, 0 + (obj_player.xspd * 4), 0 + (obj_player.yspd * 4)) + wave(-30, 30, 2, 0);
        
        spawnangle = choose(gettimer / 3000, irandom(360), moving_dir);
        
        if (grenade_exists == false)
        {
            if (enemy_bleed_in < 1)
                enemy_bleed_in += (0.0005 * gameSpeed);
            else
                enemy_bleed_in = 1;
            
            if (bomb_spawn_multiplier < 1)
                bomb_spawn_multiplier += (0.0005 * gameSpeed);
            else
                bomb_spawn_multiplier = 1;
            
            var enem_od = 1 + (0.2 * obj_stat_track.overdrive);
            enemyminimum = floor((15 + (diff_gameminutes * 6)) * enemy_bleed_in * bomb_spawn_multiplier * enem_od);
            
            if (mod_swarmers == true)
                enemyminimum *= 2;
            
            if (mod_allcurse == true)
                enemyminimum *= 0.1;
            
            enemyminimum *= obj_view.spawncap_cheat;
            var edeff = enemyDefense / 100;
            
            if (edeff > 1.05)
                enemyminimum *= (0.98 + (edeff / 50));
            
            if (number_of_enemies < enemyminimum)
            {
                var diffbet = enemyminimum - number_of_enemies;
                var arr = ds_list_random_enemy;
                
                if (mod_anyenemy == true)
                    arr = randommod_array_in_use;
                
                repeat (floor(1 + (diffbet / 20)))
                {
                    var random_pull = irandom_range(0, ds_list_size(arr) - 1);
                    var enemy_pulled = ds_list_find_value(arr, random_pull);
                    
                    if (enemy_pulled == obj_enem_droid || enemy_pulled == obj_enem_exploder || enemy_pulled == obj_enem_sniper || enemy_pulled == obj_enem_warper)
                    {
                        if (irandom(100) < 90)
                            random_pull = choose(obj_enem_soul, obj_enem_skull, obj_enem_fish, obj_enem_glove);
                    }
                    
                    var monster = instance_create_layer(obj_player.x + lengthdir_x(600, spawnangle), obj_player.y + lengthdir_y(600, spawnangle), "Enemies", enemy_pulled);
                    monster.direction = spawnangle + 180;
                }
                
                if (elite_enemy_timer > 7200 && can_spawn_rainbow_enemies == true && elite_enemy_counter > elite_enemy_max)
                {
                    can_spawn_an_elite = true;
                    elite_enemy_counter = 0;
                    elite_enemy_timer = 0;
                }
            }
        }
        else if (!instance_exists(obj_wep_nade_explosion))
        {
            grenade_exists = false;
        }
        
        var debadjust = 1;
        
        if (mod_enabled == true)
            debadjust = 1.25;
        
        itemdropcd -= (debadjust * gameSpeed);
        
        if (itemdropcd < 0)
        {
            itemdropcd = itemdropcd_max / (1 + (obj_player.powerup_candy / 10));
            var random_x = obj_player.x + lengthdir_x(600, spawnangle);
            var random_y = obj_player.y + lengthdir_y(600, spawnangle);
            instance_create_layer(random_x, random_y, "Bullets", obj_debris);
        }
    }
}
else
{
    enemy_bleed_in = 0;
}

enemy_effect_timer = gettimer / 100000;
var diag = global.dialog;

if (diff_gameminutes > ((1 + bosses_killed) * 5) && obj_view.show_destins == 0 && !instance_exists(obj_boss_parent) && !instance_exists(obj_boss_die) && !instance_exists(obj_picayune_fight_start))
{
    spawnenemies = false;
    
    if (number_of_enemies == 0)
    {
        if (diag == diag_placeholder)
        {
            if (bosses_killed == 0)
            {
                global.dialog = diag_boss_gremlin_spawn;
            }
            else if (bosses_killed == 1)
            {
                global.dialog = diag_boss_worm_spawn;
            }
            else if (bosses_killed == 2)
            {
                global.dialog = diag_boss_biker_spawn;
            }
            else if (bosses_killed == 3)
            {
                global.dialog = diag_boss_demon_spawn;
            }
            else if (bosses_killed == 4)
            {
                global.dialog = diag_boss_picayune_spawn;
            }
            else if (bosses_killed == 5)
            {
                global.dialog = diag_boss_ab_gremlin_spawn;
            }
            else if (bosses_killed == 6)
            {
                global.dialog = diag_boss_ab_worm_spawn;
            }
            else if (bosses_killed == 7)
            {
                global.dialog = diag_boss_ab_biker_spawn;
            }
            else if (bosses_killed == 8)
            {
                global.dialog = diag_boss_ab_demon_spawn;
            }
            else if (bosses_killed == 9)
            {
                global.dialog = diag_boss_ab_picayune_spawn;
            }
            else
            {
                ranoutofbosses = true;
                var clamped_boss = bosses_killed - 10;
                
                if (clamped_boss <= 0)
                    global.dialog = diag_boss_ab_gremlin_spawn;
                else if (clamped_boss == 1)
                    global.dialog = diag_boss_ab_worm_spawn;
                else if (clamped_boss == 2)
                    global.dialog = diag_boss_ab_biker_spawn;
                else if (clamped_boss == 3)
                    global.dialog = diag_boss_ab_demon_spawn;
                else if (clamped_boss == 4)
                    global.dialog = diag_boss_ab_gremlin_spawn;
                else if (clamped_boss == 5)
                    global.dialog = diag_boss_ab_worm_spawn;
                else if (clamped_boss == 6)
                    global.dialog = diag_boss_ab_biker_spawn;
                else if (clamped_boss == 7)
                    global.dialog = diag_boss_ab_demon_spawn;
                else if (clamped_boss == 8)
                    global.dialog = diag_boss_ab_gremlin_spawn;
                else if (clamped_boss == 9)
                    global.dialog = diag_boss_ab_worm_spawn;
                else if (clamped_boss == 10)
                    global.dialog = diag_boss_ab_biker_spawn;
                else if (clamped_boss == 11)
                    global.dialog = diag_boss_ab_demon_spawn;
                else if (clamped_boss == 12)
                    global.dialog = diag_boss_ab_gremlin_spawn;
                else if (clamped_boss == 13)
                    global.dialog = diag_boss_ab_worm_spawn;
                else if (clamped_boss == 14)
                    global.dialog = diag_boss_ab_biker_spawn;
                else if (clamped_boss == 15)
                    global.dialog = diag_boss_ab_demon_spawn;
                else
                    global.dialog = choose(diag_boss_ab_gremlin_spawn, diag_boss_ab_worm_spawn, diag_boss_ab_biker_spawn, diag_boss_ab_demon_spawn);
            }
        }
    }
    else
    {
        if (dialog_index != 1)
        {
            playsnd(global.sounds.snd_phone_ring, 1, false, 1, 32);
            obj_view.popup_incoming_prog = 1;
        }
        
        dialog_index = 1;
    }
}
else if (diag == diag_placeholder)
{
    dialog_index = 0;
}

if (instance_exists(obj_boss_parent))
{
    boss_killer_timer += gameSpeed;
}
else if (boss_killer_timer > 0 && instance_exists(obj_boss_die))
{
    if (boss_killer_timer < obj_stat_track.stat_fastest_boss_death)
        obj_stat_track.stat_fastest_boss_death = boss_killer_timer;
    
    boss_killer_timer = 0;
}
else
{
    boss_killer_timer = 0;
}

if (diag != diag_placeholder)
{
    if (dialog_finished == 0)
    {
        dialog_index = 2;
    }
    else if (dialog_finished == 1)
    {
        dialog_index = 3;
    }
    else if (dialog_finished == 2)
    {
        if (global.dialog_code == 1)
            instance_create_layer(obj_player.x, obj_player.y - 350, "Boss", obj_boss_rabbit);
        else if (global.dialog_code == 2)
            instance_create_layer(obj_player.x + 600, obj_player.y, "Boss", obj_boss_worm_manager);
        else if (global.dialog_code == 3)
            instance_create_layer(obj_ghost_spawner.x, obj_ghost_spawner.y, "Boss", obj_boss_ghost);
        else if (global.dialog_code == 4)
            instance_create_layer(obj_player.x, obj_player.y - 350, "Boss", obj_boss_biker);
        else if (global.dialog_code == 5)
            instance_create_layer(obj_player.x, obj_player.y - 350, "Boss", obj_boss_demon);
        else if (global.dialog_code == 6)
            instance_create_layer(obj_player.x, obj_player.y, "Boss", obj_picayune_fight_start);
        else if (global.dialog_code == 7)
            instance_create_layer(obj_player.x + 600, obj_player.y, "Boss", obj_boss_diver);
        else if (global.dialog_code == 8)
            instance_create_layer(obj_player.x, obj_player.y - 350, "Boss", obj_ab_rabbit);
        else if (global.dialog_code == 9)
            instance_create_layer(obj_player.x, obj_player.y - 350, "Boss", obj_ab_worm_manager);
        else if (global.dialog_code == 10)
            instance_create_layer(obj_player.x, obj_player.y - 350, "Boss", obj_ab_biker);
        else if (global.dialog_code == 11)
            instance_create_layer(obj_player.x, obj_player.y - 350, "Boss", obj_ab_demon);
        else if (global.dialog_code == 12)
            instance_create_layer(obj_umi_floater.x, obj_umi_floater.y, "Boss", obj_boss_umi);
        else if (global.dialog_code == 13)
            instance_create_layer(obj_player.x, obj_player.y, "Instances", picayune);
        
        global.dialog = diag_placeholder;
        global.dialog_code = 0;
        global.spr_player_face_idle = global.sprites.spr_nothing;
        global.spr_player_face_talk = global.sprites.spr_nothing;
        global.spr_player_face = global.sprites.spr_nothing;
        global.spr_enemy_face_idle = global.sprites.spr_nothing;
        global.spr_enemy_face_talk = global.sprites.spr_nothing;
        global.spr_enemy_face = global.sprites.spr_nothing;
        dialog_finished = 0;
        dialog_index = 0;
    }
}

if (obj_view.levelupstop_cheat == false && !instance_exists(picayune))
{
    levelup_cooldown -= 1;
    levelup_cd_adjustment = approach(clamp(levelup_cd_adjustment, 0, 45), 45, 1);
    
    if (playerxp >= playerlvlupxp && levelup_cooldown < 0 && levelupscreen == false && global.dialog == diag_placeholder)
    {
        levelup_cd_adjustment -= 25;
        ds_xpearned += playerxp;
        playerxp -= playerlvlupxp;
        playerlevel += 1;
        playerlvlupxp = round(playerlevel * xpaddtocap * 1.02);
        
        if (obj_player.outfit == "optimized")
            playerlvlupxp *= 2;
        
        if (enemyDefense > 101)
        {
            var inc = enemyDefense / 100;
            playerlvlupxp = round(playerlvlupxp * inc);
        }
        
        playsnd(global.sounds.snd_Menu_Open_1, 1, false, 1, 32);
        
        if (obj_control.upgmode == "driller")
            generate_three_drill();
        else
            generate_three_upgrade();
        
        with (obj_view)
        {
            nearplay = instance_nearest(x, y, obj_player);
            upgrade1_holo_sprite = ds_list_find_value(obj_control.shop_upg1, 4);
            upgrade1_solid_sprite = ds_list_find_value(obj_control.shop_upg1, 5);
            upgrade1_hover_spr = ds_list_find_value(obj_control.shop_upg1, 6);
            upgrade1_hover_text = ds_list_find_value(obj_control.shop_upg1, 3);
            upgrade1_level = variable_instance_get(nearplay, ds_list_find_value(obj_control.shop_upg1, 2));
            upgrade2_holo_sprite = ds_list_find_value(obj_control.shop_upg2, 4);
            upgrade2_solid_sprite = ds_list_find_value(obj_control.shop_upg2, 5);
            upgrade2_hover_spr = ds_list_find_value(obj_control.shop_upg2, 6);
            upgrade2_hover_text = ds_list_find_value(obj_control.shop_upg2, 3);
            upgrade2_level = variable_instance_get(nearplay, ds_list_find_value(obj_control.shop_upg2, 2));
            upgrade3_holo_sprite = ds_list_find_value(obj_control.shop_upg3, 4);
            upgrade3_solid_sprite = ds_list_find_value(obj_control.shop_upg3, 5);
            upgrade3_hover_spr = ds_list_find_value(obj_control.shop_upg3, 6);
            upgrade3_hover_text = ds_list_find_value(obj_control.shop_upg3, 3);
            upgrade3_level = variable_instance_get(nearplay, ds_list_find_value(obj_control.shop_upg3, 2));
        }
        
        levelupscreen = true;
        
        if (global.skill_lvlboom == true)
        {
            var explosion = instance_create_depth(obj_player.x, obj_player.y, depth - 999, obj_wep_enemy_explosion);
            explosion.spd = 0;
            explosion.damage = 999;
            explosion.knockback = 1;
            explosion.destroyonhit = false;
            explosion.image_xscale = 2 * obj_player.weapon_size_final;
            explosion.image_yscale = 2 * obj_player.weapon_size_final;
            explosion.image_blend = c_red;
            explosion.mask_index = global.sprites.spr_nothing;
            screenshake(1, 1);
            playsnd(global.sounds.snd_grenade_explosion, random_range(1.2, 1.3), false, 0.5, 1);
        }
    }
}
else
{
    playerxp = 0;
}

if (keyboard_check_pressed(global.kb_changesong) || gamepad_button_check_pressed(0, global.gpd_changesong))
{
    if (global.has_beaten_game > 0 && global.song != global.sounds.mus_silence && global.song != global.sounds.snd_silence && !instance_exists(obj_boss_parent) && !instance_exists(obj_boss_die) && global.dialog == diag_placeholder)
    {
        playsnd(global.sounds.snd_EntitySpawn, 2, false, 1);
        random_song();
    }
}

var should_be_paused = instance_exists(obj_settings);
global.paused = should_be_paused;

if (keyboard_check_pressed(global.kb_pause) || gamepad_button_check_released(0, global.gpd_pause) || steam_is_overlay_activated())
{
    if (!instance_exists(obj_settings))
    {
        instance_create_depth(x, y, depth, obj_settings);
        
        if (gameSpeed > 0.1)
            gameSpeed = 0.1;
    }
}

var gmspd = 1 + (fastforward * fast_forward_mod);
var speedup = keyboard_check_pressed(global.kb_ff) + gamepad_button_check_pressed(0, global.gpd_ff);

if (levelupscreen == true || instance_exists(obj_platformer) || player_death == true || should_be_paused == true || (playerxp > playerlvlupxp && global.dialog == diag_placeholder && obj_view.levelupstop_cheat == false) || (obj_view.showtabmen == true && spawnenemies == true))
    gmspd = 0;
else if (slow_sneaking == true && obj_player.TipToe == true)
    gmspd = gmspd * 0.75;

if (gameSpeed >= 1)
{
    if (speedup > 0)
    {
        if (fastforward == false)
        {
            fastforward = true;
            gmspd = 2;
            gameSpeed = 2;
            
            if (layer_get_visible(ff_effect_layer_1) == false)
            {
                layer_set_visible(ff_effect_layer_1, true);
                layer_set_visible(ff_effect_layer_2, true);
            }
        }
        else
        {
            fastforward = false;
            gmspd = 1;
            gameSpeed = 1;
            
            if (layer_get_visible(ff_effect_layer_1) == true)
            {
                layer_set_visible(ff_effect_layer_1, false);
                layer_set_visible(ff_effect_layer_2, false);
            }
        }
    }
}

gameSpeed = approach(gameSpeed, gmspd, 0.01 * (1 + (fastforward * fast_forward_mod)));

if (sessionCD <= 0)
{
    if (sessionSeconds >= 59)
    {
        sessionCD = 60;
        sessionSeconds = 0;
        sessionMinutes += 1;
    }
    else
    {
        sessionCD = 60;
        sessionSeconds += 1;
    }
}
else
{
    sessionCD -= clamp(gameSpeed, 0, 1);
}
