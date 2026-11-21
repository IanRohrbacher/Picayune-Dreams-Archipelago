show_debug_message("SET UP BUTTS!");

// Only the buttons that remain are set up; the daily, monthly and database buttons are gone.
if (butt == "start")
{
    idlespr = global.sprites.spr_butt_start_idle;
    highspr = global.sprites.spr_butt_start_high;
    hs_show = "";
    username = steam_get_persona_name();
    steam_name_mortality = array_create(100, "");
    steam_score_mortality = array_create(100, 0);
    steam_name_kills = array_create(100, "");
    steam_score_kills = array_create(100, 0);
    steam_name_speed = array_create(100, "");
    steam_score_speed = array_create(100, 0);
    alarm[2] = 1;
    alarm[1] = 60;
}
else if (butt == "config")
{
    idlespr = global.sprites.spr_butt_config_idle;
    highspr = global.sprites.spr_butt_config_high;
}
else if (butt == "credits")
{
    idlespr = global.sprites.spr_butt_credits_idle;
    highspr = global.sprites.spr_butt_credits_high;
}
else if (butt == "info")
{
    idlespr = global.sprites.spr_butt_info_idle;
    highspr = global.sprites.spr_butt_info_high;
}
else if (butt == "exit")
{
    idlespr = global.sprites.spr_butt_exit_idle;
    highspr = global.sprites.spr_butt_exit_high;
}
else if (butt == "loadout")
{
    idlespr = global.sprites.spr_butt_loadout_idle;
    highspr = global.sprites.spr_butt_loadout_high;
}
else if (butt == "collection")
{
    idlespr = global.sprites.spr_butt_collect_idle;
    highspr = global.sprites.spr_butt_collect_high;
}

sprite_index = idlespr;
