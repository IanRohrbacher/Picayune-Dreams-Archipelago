instance_create_layer(x, y, "Instances", obj_kindamouse);
objview = instance_create_layer(x, y, "Instances", obj_view);
objview.targ = obj_kindamouse;
global.debug = false;

if (global.cheater == true)
{
    global.cheater = false;
    
    if (instance_exists(obj_console))
        instance_destroy(obj_console);
}

randomize();
global.selected_suit = "default";
global.gamemode = "normal";
img_angle_og = 0;
img_angle_new = 0;
first_check = false;
grabbed = false;
collection_alert = false;
alarm[0] = 1;
audio_listener_orientation(0, 0, 1, 0, -1, 0);
effect_layer = layer_get_id("Effect_Picayune_BG");
effect_layer_warb = layer_get_id("Effect_Picayune_Warble");
effect_layer_tunnel = layer_get_id("Effect_Picayune_Tunnel");
effect_layer_true = layer_get_id("Effect_True");
effect_layer_darken = layer_get_id("Effect_Darken");
effect_layer_badend = layer_get_id("Bad_Ending");
background_layer = layer_get_id("Background");
background_id = layer_background_get_id(background_layer);
steam_set_rich_presence("steam_display", "#Status_AtMainMenu");
world_clock_api = -1;
world_clock_data = "";
got_data_from_world_clock = false;
