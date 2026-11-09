draw_self();
draw_text_setup(65280, 0, 0, fnt_freddy);
draw_set_alpha(0.6);
var mod_count = struct_names_count(global.mods);

if (mod_count > 0)
    draw_text(global.screenw - 37, global.screenh - 20, "MODS: " + string(mod_count));

draw_text(global.screenw - 67, global.screenh - 10, "1.1.0.18 " + global.ap_version);
draw_set_alpha(1);

if (global.points_spent < global.points_avaliable)
    draw_sprite_ext(global.sprites.spr_glowing_ico, 0, 252, 116, 1, 1, get_timer() / 10000, c_white, wave(0.75, 1, 0.5, 0));

if (collection_alert == true)
    draw_sprite_ext(global.sprites.spr_glowing_ico, 0, 862, 338, 1, 1, get_timer() / 10000, c_white, wave(0.75, 1, 0.5, 0));
