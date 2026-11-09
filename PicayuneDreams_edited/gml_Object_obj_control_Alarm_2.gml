ds_list_random_enemy = ds_list_create();

if (diff_gameminutes > 1)
    ds_list_copy(ds_list_random_enemy, picked_enemy_array);

if (diff_gameminutes > 2)
    ds_list_add(ds_list_random_enemy, obj_enem_glove);

if (diff_gameminutes > 3)
    ds_list_add(ds_list_random_enemy, obj_enem_fish);

if (diff_gameminutes > 4)
    ds_list_add(ds_list_random_enemy, obj_enem_skull);

ds_list_add(ds_list_random_enemy, obj_enem_soul);

if (diff_gameminutes > 20)
    randommod_array_in_use = hard_randommod_enemies;
else if (diff_gameminutes > 10)
    randommod_array_in_use = medi_randommod_enemies;
else
    randommod_array_in_use = easy_randommod_enemies;

if (spawnenemies == true && gameSpeed > 0.1)
{
    steam_set_rich_presence("score", diff_gameminutes);
    steam_set_rich_presence("steam_display", "#StatusWithScore");
    
    if (grenade_exists == false)
    {
        if (mod_chaser == true && !instance_exists(obj_enem_chaser))
        {
            var chaser_ang = point_direction(0 + (obj_player.xspd * 4), 0 + (obj_player.yspd * 4), 0, 0);
            var random_chas_x = obj_player.x + lengthdir_x(750, chaser_ang);
            var random_chas_y = obj_player.y + lengthdir_y(750, chaser_ang);
            var chaser = instance_create_layer(random_chas_x, random_chas_y, "Overlay", obj_enem_chaser);
        }
        
        alarm_swarmspawn -= (300 * gameSpeed);
        
        if (alarm_swarmspawn < 0)
        {
            alarm_swarmspawn = 3600;
            
            if (ds_list_find_index(formation_array, form_skull_clump) == -1 && diff_gameminutes > 4)
            {
                ds_list_add(formation_array, form_skull_wall);
                ds_list_add(formation_array, form_skull_ambush);
                ds_list_add(formation_array, form_skull_target);
            }
            else if (ds_list_find_index(formation_array, form_fish_clump) == -1 && diff_gameminutes > 3)
            {
                ds_list_add(formation_array, form_fish_wall);
                ds_list_add(formation_array, form_fish_ambush);
            }
            else if (ds_list_find_index(formation_array, form_hand_clump) == -1 && diff_gameminutes > 2)
            {
                ds_list_add(formation_array, form_hand_wall);
                ds_list_add(formation_array, form_hand_ambush);
                ds_list_add(formation_array, form_hand_target);
            }
            
            ds_list_shuffle(formation_array);
            var random_x = obj_player.x + lengthdir_x(600, spawnangle);
            var random_y = obj_player.y + lengthdir_y(600, spawnangle);
            var get_scr = ds_list_find_value(formation_array, 0);
            script_execute(get_scr, random_x, random_y);
        }
    }
    
    if (!instance_exists(obj_statue) && chosen_statue != global.sprites.spr_nothing && diff_gameminutes > (((1 + bosses_killed) * 5) - 4))
    {
        var random_x = obj_player.x + lengthdir_x(600, spawnangle);
        var random_y = obj_player.y + lengthdir_y(600, spawnangle);
        var statue = instance_create_layer(random_x, random_y, "Statue", obj_statue);
        statue.sprite_index = chosen_statue;
        var stat_num = array_index_find(obj_control.possible_statues, chosen_statue);
        
        if (stat_num > -1)
            array_delete(obj_control.possible_statues, stat_num, 1);
        
        chosen_statue = global.sprites.spr_nothing;
        
        if (global.skill_secondstatue && mod_enabled == true)
        {
            var new_random_x = obj_player.x + lengthdir_x(750, spawnangle + 180);
            var new_random_y = obj_player.y + lengthdir_y(750, spawnangle + 180);
            var new_statue = instance_create_layer(new_random_x, new_random_y, "Statue", obj_statue);
            obj_control.possible_statues = array_shuffle(obj_control.possible_statues);
            new_statue.sprite_index = obj_control.possible_statues[0];
            array_delete(obj_control.possible_statues, 0, 1);
        }
    }
}

if (point_distance(obj_player.x, obj_player.y, 200000, 200000) < 500)
{
    if (!instance_exists(obj_distant) && global.skill_seememory == true)
    {
        playsnd(global.sounds.snd_Upgrade_Purchase, 0.1, false, 0.1);
        var dista = instance_create_layer(200000, 200000, "Instances", obj_distant);
    }
}

alarm[2] = 300;
