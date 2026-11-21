global.song = global.sounds.mus_gameover_win;

global.rpgmaker = false;
global.screenw = 960;
global.screenh = 540;

if (global.pixelperfect == true)
    surface_resize(application_surface, global.screenw, global.screenh);
else
    surface_resize(application_surface, 1920, 1080);

display_set_gui_size(global.screenw, global.screenh);

// Creates the slot and connect screen.
instance_create_layer(0, 0, "Instances", obj_ap_connect);
