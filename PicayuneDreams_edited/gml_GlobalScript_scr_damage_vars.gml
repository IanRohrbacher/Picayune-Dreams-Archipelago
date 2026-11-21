function setup_damage_vars()
{
    global.damage_unsorted = 0;
    global.damage_core = 0;
    global.damage_chainbelt = 0;
    global.damage_daggerglove = 0;
    global.damage_eye2 = 0;
    global.damage_horns = 0;
    global.damage_hydrocillator = 0;
    global.damage_legsaw = 0;
    global.damage_missilepack = 0;
    global.damage_parasight = 0;
    global.damage_puckrack = 0;
    global.damage_slimespike = 0;
    global.damage_telecom = 0;
    global.damage_ultrabuster = 0;
    global.damage_bow = 0;
    global.damage_flamethrower = 0;
    global.damage_headphones = 0;
    global.damage_ninja = 0;
    global.damage_plasma = 0;
    global.damage_remote = 0;
    global.damage_satellite = 0;
    global.damage_snowglobe = 0;
    global.damage_spear = 0;
    global.damage_turret = 0;
    global.damage_angelwings = 0;
    global.damage_batwings = 0;
    global.damage_c4 = 0;
    global.damage_shottyvest = 0;
    global.damage_plaguemask = 0;
    global.damage_eel = 0;
    global.damage_icecream = 0;
    global.damage_lighter = 0;
    global.damage_chainsword = 0;
    global.damage_firewall = 0;
    global.damage_reaper = 0;
    global.damage_tentacle = 0;
    global.damage_dynamite = 0;
    global.damage_carrot = 0;
    global.damage_bees = 0;
    global.damage_midas = 0;
    global.damage_fish = 0;
    global.damage_cheese = 0;
    global.damage_psycho = 0;
    global.kills_unsorted = 0;
    global.kills_core = 0;
    global.kills_chainbelt = 0;
    global.kills_daggerglove = 0;
    global.kills_eye2 = 0;
    global.kills_horns = 0;
    global.kills_hydrocillator = 0;
    global.kills_legsaw = 0;
    global.kills_missilepack = 0;
    global.kills_parasight = 0;
    global.kills_puckrack = 0;
    global.kills_slimespike = 0;
    global.kills_telecom = 0;
    global.kills_ultrabuster = 0;
    global.kills_bow = 0;
    global.kills_flamethrower = 0;
    global.kills_headphones = 0;
    global.kills_ninja = 0;
    global.kills_plasma = 0;
    global.kills_remote = 0;
    global.kills_satellite = 0;
    global.kills_snowglobe = 0;
    global.kills_spear = 0;
    global.kills_turret = 0;
    global.kills_angelwings = 0;
    global.kills_batwings = 0;
    global.kills_c4 = 0;
    global.kills_shottyvest = 0;
    global.kills_plaguemask = 0;
    global.kills_eel = 0;
    global.kills_icecream = 0;
    global.kills_lighter = 0;
    global.kills_chainsword = 0;
    global.kills_firewall = 0;
    global.kills_reaper = 0;
    global.kills_tentacle = 0;
    global.kills_dynamite = 0;
    global.kills_carrot = 0;
    global.kills_bees = 0;
    global.kills_midas = 0;
    global.kills_fish = 0;
    global.kills_cheese = 0;
    global.kills_psycho = 0;
}

function load_damage_stats()
{
    stat_damage_unsorted = ini_read_real("stat_track", "stat_damage_unsorted", 0);
    stat_damage_core = ini_read_real("stat_track", "stat_damage_core", 0);
    stat_damage_chainbelt = ini_read_real("stat_track", "stat_damage_chainbelt", 0);
    stat_damage_daggerglove = ini_read_real("stat_track", "stat_damage_daggerglove", 0);
    stat_damage_eye2 = ini_read_real("stat_track", "stat_damage_eye2", 0);
    stat_damage_horns = ini_read_real("stat_track", "stat_damage_horns", 0);
    stat_damage_hydrocillator = ini_read_real("stat_track", "stat_damage_hydrocillator", 0);
    stat_damage_legsaw = ini_read_real("stat_track", "stat_damage_legsaw", 0);
    stat_damage_missilepack = ini_read_real("stat_track", "stat_damage_missilepack", 0);
    stat_damage_parasight = ini_read_real("stat_track", "stat_damage_parasight", 0);
    stat_damage_puckrack = ini_read_real("stat_track", "stat_damage_puckrack", 0);
    stat_damage_slimespike = ini_read_real("stat_track", "stat_damage_slimespike", 0);
    stat_damage_telecom = ini_read_real("stat_track", "stat_damage_telecom", 0);
    stat_damage_ultrabuster = ini_read_real("stat_track", "stat_damage_ultrabuster", 0);
    stat_damage_bow = ini_read_real("stat_track", "stat_damage_bow", 0);
    stat_damage_flamethrower = ini_read_real("stat_track", "stat_damage_flamethrower", 0);
    stat_damage_headphones = ini_read_real("stat_track", "stat_damage_headphones", 0);
    stat_damage_ninja = ini_read_real("stat_track", "stat_damage_ninja", 0);
    stat_damage_plasma = ini_read_real("stat_track", "stat_damage_plasma", 0);
    stat_damage_remote = ini_read_real("stat_track", "stat_damage_remote", 0);
    stat_damage_satellite = ini_read_real("stat_track", "stat_damage_satellite", 0);
    stat_damage_snowglobe = ini_read_real("stat_track", "stat_damage_snowglobe", 0);
    stat_damage_spear = ini_read_real("stat_track", "stat_damage_spear", 0);
    stat_damage_turret = ini_read_real("stat_track", "stat_damage_turret", 0);
    stat_damage_angelwings = ini_read_real("stat_track", "stat_damage_angelwings", 0);
    stat_damage_batwings = ini_read_real("stat_track", "stat_damage_batwings", 0);
    stat_damage_c4 = ini_read_real("stat_track", "stat_damage_c4", 0);
    stat_damage_shottyvest = ini_read_real("stat_track", "stat_damage_shottyvest", 0);
    stat_damage_plaguemask = ini_read_real("stat_track", "stat_damage_plaguemask", 0);
    stat_damage_eel = ini_read_real("stat_track", "stat_damage_eel", 0);
    stat_damage_icecream = ini_read_real("stat_track", "stat_damage_icecream", 0);
    stat_damage_lighter = ini_read_real("stat_track", "stat_damage_lighter", 0);
    stat_damage_chainsword = ini_read_real("stat_track", "stat_damage_chainsword", 0);
    stat_damage_firewall = ini_read_real("stat_track", "stat_damage_firewall", 0);
    stat_damage_reaper = ini_read_real("stat_track", "stat_damage_reaper", 0);
    stat_damage_tentacle = ini_read_real("stat_track", "stat_damage_tentacle", 0);
    stat_damage_dynamite = ini_read_real("stat_track", "stat_damage_dynamite", 0);
    stat_damage_carrot = ini_read_real("stat_track", "stat_damage_carrot", 0);
    stat_damage_bees = ini_read_real("stat_track", "stat_damage_bees", 0);
    stat_damage_midas = ini_read_real("stat_track", "stat_damage_midas", 0);
    stat_damage_fish = ini_read_real("stat_track", "stat_damage_fish", 0);
    stat_damage_cheese = ini_read_real("stat_track", "stat_damage_cheese", 0);
    stat_damage_psycho = ini_read_real("stat_track", "stat_damage_psycho", 0);
    stat_kills_unsorted = ini_read_real("stat_track", "stat_kills_unsorted", 0);
    stat_kills_core = ini_read_real("stat_track", "stat_kills_core", 0);
    stat_kills_chainbelt = ini_read_real("stat_track", "stat_kills_chainbelt", 0);
    stat_kills_daggerglove = ini_read_real("stat_track", "stat_kills_daggerglove", 0);
    stat_kills_eye2 = ini_read_real("stat_track", "stat_kills_eye2", 0);
    stat_kills_horns = ini_read_real("stat_track", "stat_kills_horns", 0);
    stat_kills_hydrocillator = ini_read_real("stat_track", "stat_kills_hydrocillator", 0);
    stat_kills_legsaw = ini_read_real("stat_track", "stat_kills_legsaw", 0);
    stat_kills_missilepack = ini_read_real("stat_track", "stat_kills_missilepack", 0);
    stat_kills_parasight = ini_read_real("stat_track", "stat_kills_parasight", 0);
    stat_kills_puckrack = ini_read_real("stat_track", "stat_kills_puckrack", 0);
    stat_kills_slimespike = ini_read_real("stat_track", "stat_kills_slimespike", 0);
    stat_kills_telecom = ini_read_real("stat_track", "stat_kills_telecom", 0);
    stat_kills_ultrabuster = ini_read_real("stat_track", "stat_kills_ultrabuster", 0);
    stat_kills_bow = ini_read_real("stat_track", "stat_kills_bow", 0);
    stat_kills_flamethrower = ini_read_real("stat_track", "stat_kills_flamethrower", 0);
    stat_kills_headphones = ini_read_real("stat_track", "stat_kills_headphones", 0);
    stat_kills_ninja = ini_read_real("stat_track", "stat_kills_ninja", 0);
    stat_kills_plasma = ini_read_real("stat_track", "stat_kills_plasma", 0);
    stat_kills_remote = ini_read_real("stat_track", "stat_kills_remote", 0);
    stat_kills_satellite = ini_read_real("stat_track", "stat_kills_satellite", 0);
    stat_kills_snowglobe = ini_read_real("stat_track", "stat_kills_snowglobe", 0);
    stat_kills_spear = ini_read_real("stat_track", "stat_kills_spear", 0);
    stat_kills_turret = ini_read_real("stat_track", "stat_kills_turret", 0);
    stat_kills_angelwings = ini_read_real("stat_track", "stat_kills_angelwings", 0);
    stat_kills_batwings = ini_read_real("stat_track", "stat_kills_batwings", 0);
    stat_kills_c4 = ini_read_real("stat_track", "stat_kills_c4", 0);
    stat_kills_shottyvest = ini_read_real("stat_track", "stat_kills_shottyvest", 0);
    stat_kills_plaguemask = ini_read_real("stat_track", "stat_kills_plaguemask", 0);
    stat_kills_eel = ini_read_real("stat_track", "stat_kills_eel", 0);
    stat_kills_icecream = ini_read_real("stat_track", "stat_kills_icecream", 0);
    stat_kills_lighter = ini_read_real("stat_track", "stat_kills_lighter", 0);
    stat_kills_chainsword = ini_read_real("stat_track", "stat_kills_chainsword", 0);
    stat_kills_firewall = ini_read_real("stat_track", "stat_kills_firewall", 0);
    stat_kills_reaper = ini_read_real("stat_track", "stat_kills_reaper", 0);
    stat_kills_tentacle = ini_read_real("stat_track", "stat_kills_tentacle", 0);
    stat_kills_dynamite = ini_read_real("stat_track", "stat_kills_dynamite", 0);
    stat_kills_carrot = ini_read_real("stat_track", "stat_kills_carrot", 0);
    stat_kills_bees = ini_read_real("stat_track", "stat_kills_bees", 0);
    stat_kills_midas = ini_read_real("stat_track", "stat_kills_midas", 0);
    stat_kills_fish = ini_read_real("stat_track", "stat_kills_fish", 0);
    stat_kills_cheese = ini_read_real("stat_track", "stat_kills_cheese", 0);
    stat_kills_psycho = ini_read_real("stat_track", "stat_kills_psycho", 0);
}

function save_damage_stats()
{
    // Damage stats are always saved; there is no freeplay mode that skips them.
    ini_write_real("stat_track", "stat_damage_unsorted", stat_damage_unsorted);
    ini_write_real("stat_track", "stat_damage_core", stat_damage_core);
    ini_write_real("stat_track", "stat_damage_chainbelt", stat_damage_chainbelt);
    ini_write_real("stat_track", "stat_damage_daggerglove", stat_damage_daggerglove);
    ini_write_real("stat_track", "stat_damage_eye2", stat_damage_eye2);
    ini_write_real("stat_track", "stat_damage_horns", stat_damage_horns);
    ini_write_real("stat_track", "stat_damage_hydrocillator", stat_damage_hydrocillator);
    ini_write_real("stat_track", "stat_damage_legsaw", stat_damage_legsaw);
    ini_write_real("stat_track", "stat_damage_missilepack", stat_damage_missilepack);
    ini_write_real("stat_track", "stat_damage_parasight", stat_damage_parasight);
    ini_write_real("stat_track", "stat_damage_puckrack", stat_damage_puckrack);
    ini_write_real("stat_track", "stat_damage_slimespike", stat_damage_slimespike);
    ini_write_real("stat_track", "stat_damage_telecom", stat_damage_telecom);
    ini_write_real("stat_track", "stat_damage_ultrabuster", stat_damage_ultrabuster);
    ini_write_real("stat_track", "stat_damage_bow", stat_damage_bow);
    ini_write_real("stat_track", "stat_damage_flamethrower", stat_damage_flamethrower);
    ini_write_real("stat_track", "stat_damage_headphones", stat_damage_headphones);
    ini_write_real("stat_track", "stat_damage_ninja", stat_damage_ninja);
    ini_write_real("stat_track", "stat_damage_plasma", stat_damage_plasma);
    ini_write_real("stat_track", "stat_damage_remote", stat_damage_remote);
    ini_write_real("stat_track", "stat_damage_satellite", stat_damage_satellite);
    ini_write_real("stat_track", "stat_damage_snowglobe", stat_damage_snowglobe);
    ini_write_real("stat_track", "stat_damage_spear", stat_damage_spear);
    ini_write_real("stat_track", "stat_damage_turret", stat_damage_turret);
    ini_write_real("stat_track", "stat_damage_angelwings", stat_damage_angelwings);
    ini_write_real("stat_track", "stat_damage_batwings", stat_damage_batwings);
    ini_write_real("stat_track", "stat_damage_c4", stat_damage_c4);
    ini_write_real("stat_track", "stat_damage_shottyvest", stat_damage_shottyvest);
    ini_write_real("stat_track", "stat_damage_plaguemask", stat_damage_plaguemask);
    ini_write_real("stat_track", "stat_damage_eel", stat_damage_eel);
    ini_write_real("stat_track", "stat_damage_icecream", stat_damage_icecream);
    ini_write_real("stat_track", "stat_damage_lighter", stat_damage_lighter);
    ini_write_real("stat_track", "stat_damage_chainsword", stat_damage_chainsword);
    ini_write_real("stat_track", "stat_damage_firewall", stat_damage_firewall);
    ini_write_real("stat_track", "stat_damage_reaper", stat_damage_reaper);
    ini_write_real("stat_track", "stat_damage_tentacle", stat_damage_tentacle);
    ini_write_real("stat_track", "stat_damage_dynamite", stat_damage_dynamite);
    ini_write_real("stat_track", "stat_damage_carrot", stat_damage_carrot);
    ini_write_real("stat_track", "stat_damage_bees", stat_damage_bees);
    ini_write_real("stat_track", "stat_damage_midas", stat_damage_midas);
    ini_write_real("stat_track", "stat_damage_fish", stat_damage_fish);
    ini_write_real("stat_track", "stat_damage_cheese", stat_damage_cheese);
    ini_write_real("stat_track", "stat_damage_psycho", stat_damage_psycho);
    ini_write_real("stat_track", "stat_kills_unsorted", stat_kills_unsorted);
    ini_write_real("stat_track", "stat_kills_core", stat_kills_core);
    ini_write_real("stat_track", "stat_kills_chainbelt", stat_kills_chainbelt);
    ini_write_real("stat_track", "stat_kills_daggerglove", stat_kills_daggerglove);
    ini_write_real("stat_track", "stat_kills_eye2", stat_kills_eye2);
    ini_write_real("stat_track", "stat_kills_horns", stat_kills_horns);
    ini_write_real("stat_track", "stat_kills_hydrocillator", stat_kills_hydrocillator);
    ini_write_real("stat_track", "stat_kills_legsaw", stat_kills_legsaw);
    ini_write_real("stat_track", "stat_kills_missilepack", stat_kills_missilepack);
    ini_write_real("stat_track", "stat_kills_parasight", stat_kills_parasight);
    ini_write_real("stat_track", "stat_kills_puckrack", stat_kills_puckrack);
    ini_write_real("stat_track", "stat_kills_slimespike", stat_kills_slimespike);
    ini_write_real("stat_track", "stat_kills_telecom", stat_kills_telecom);
    ini_write_real("stat_track", "stat_kills_ultrabuster", stat_kills_ultrabuster);
    ini_write_real("stat_track", "stat_kills_bow", stat_kills_bow);
    ini_write_real("stat_track", "stat_kills_flamethrower", stat_kills_flamethrower);
    ini_write_real("stat_track", "stat_kills_headphones", stat_kills_headphones);
    ini_write_real("stat_track", "stat_kills_ninja", stat_kills_ninja);
    ini_write_real("stat_track", "stat_kills_plasma", stat_kills_plasma);
    ini_write_real("stat_track", "stat_kills_remote", stat_kills_remote);
    ini_write_real("stat_track", "stat_kills_satellite", stat_kills_satellite);
    ini_write_real("stat_track", "stat_kills_snowglobe", stat_kills_snowglobe);
    ini_write_real("stat_track", "stat_kills_spear", stat_kills_spear);
    ini_write_real("stat_track", "stat_kills_turret", stat_kills_turret);
    ini_write_real("stat_track", "stat_kills_angelwings", stat_kills_angelwings);
    ini_write_real("stat_track", "stat_kills_batwings", stat_kills_batwings);
    ini_write_real("stat_track", "stat_kills_c4", stat_kills_c4);
    ini_write_real("stat_track", "stat_kills_shottyvest", stat_kills_shottyvest);
    ini_write_real("stat_track", "stat_kills_plaguemask", stat_kills_plaguemask);
    ini_write_real("stat_track", "stat_kills_eel", stat_kills_eel);
    ini_write_real("stat_track", "stat_kills_icecream", stat_kills_icecream);
    ini_write_real("stat_track", "stat_kills_lighter", stat_kills_lighter);
    ini_write_real("stat_track", "stat_kills_chainsword", stat_kills_chainsword);
    ini_write_real("stat_track", "stat_kills_firewall", stat_kills_firewall);
    ini_write_real("stat_track", "stat_kills_reaper", stat_kills_reaper);
    ini_write_real("stat_track", "stat_kills_tentacle", stat_kills_tentacle);
    ini_write_real("stat_track", "stat_kills_dynamite", stat_kills_dynamite);
    ini_write_real("stat_track", "stat_kills_carrot", stat_kills_carrot);
    ini_write_real("stat_track", "stat_kills_bees", stat_kills_bees);
    ini_write_real("stat_track", "stat_kills_midas", stat_kills_midas);
    ini_write_real("stat_track", "stat_kills_fish", stat_kills_fish);
    ini_write_real("stat_track", "stat_kills_cheese", stat_kills_cheese);
    ini_write_real("stat_track", "stat_kills_psycho", stat_kills_psycho);
}

function add_damage_to_stats()
{
    obj_stat_track.stat_damage_unsorted += global.damage_unsorted;
    obj_stat_track.stat_damage_core += global.damage_core;
    obj_stat_track.stat_damage_chainbelt += global.damage_chainbelt;
    obj_stat_track.stat_damage_daggerglove += global.damage_daggerglove;
    obj_stat_track.stat_damage_eye2 += global.damage_eye2;
    obj_stat_track.stat_damage_horns += global.damage_horns;
    obj_stat_track.stat_damage_hydrocillator += global.damage_hydrocillator;
    obj_stat_track.stat_damage_legsaw += global.damage_legsaw;
    obj_stat_track.stat_damage_missilepack += global.damage_missilepack;
    obj_stat_track.stat_damage_parasight += global.damage_parasight;
    obj_stat_track.stat_damage_puckrack += global.damage_puckrack;
    obj_stat_track.stat_damage_slimespike += global.damage_slimespike;
    obj_stat_track.stat_damage_telecom += global.damage_telecom;
    obj_stat_track.stat_damage_ultrabuster += global.damage_ultrabuster;
    obj_stat_track.stat_damage_bow += global.damage_bow;
    obj_stat_track.stat_damage_flamethrower += global.damage_flamethrower;
    obj_stat_track.stat_damage_headphones += global.damage_headphones;
    obj_stat_track.stat_damage_ninja += global.damage_ninja;
    obj_stat_track.stat_damage_plasma += global.damage_plasma;
    obj_stat_track.stat_damage_remote += global.damage_remote;
    obj_stat_track.stat_damage_satellite += global.damage_satellite;
    obj_stat_track.stat_damage_snowglobe += global.damage_snowglobe;
    obj_stat_track.stat_damage_spear += global.damage_spear;
    obj_stat_track.stat_damage_turret += global.damage_turret;
    obj_stat_track.stat_damage_angelwings += global.damage_angelwings;
    obj_stat_track.stat_damage_batwings += global.damage_batwings;
    obj_stat_track.stat_damage_c4 += global.damage_c4;
    obj_stat_track.stat_damage_shottyvest += global.damage_shottyvest;
    obj_stat_track.stat_damage_plaguemask += global.damage_plaguemask;
    obj_stat_track.stat_damage_eel += global.damage_eel;
    obj_stat_track.stat_damage_icecream += global.damage_icecream;
    obj_stat_track.stat_damage_lighter += global.damage_lighter;
    obj_stat_track.stat_damage_chainsword += global.damage_chainsword;
    obj_stat_track.stat_damage_firewall += global.damage_firewall;
    obj_stat_track.stat_damage_reaper += global.damage_reaper;
    obj_stat_track.stat_damage_tentacle += global.damage_tentacle;
    obj_stat_track.stat_damage_dynamite += global.damage_dynamite;
    obj_stat_track.stat_damage_carrot += global.damage_carrot;
    obj_stat_track.stat_damage_bees += global.damage_bees;
    obj_stat_track.stat_damage_midas += global.damage_midas;
    obj_stat_track.stat_damage_fish += global.damage_fish;
    obj_stat_track.stat_damage_cheese += global.damage_cheese;
    obj_stat_track.stat_damage_psycho += global.damage_psycho;
    obj_stat_track.stat_kills_unsorted += global.kills_unsorted;
    obj_stat_track.stat_kills_core += global.kills_core;
    obj_stat_track.stat_kills_chainbelt += global.kills_chainbelt;
    obj_stat_track.stat_kills_daggerglove += global.kills_daggerglove;
    obj_stat_track.stat_kills_eye2 += global.kills_eye2;
    obj_stat_track.stat_kills_horns += global.kills_horns;
    obj_stat_track.stat_kills_hydrocillator += global.kills_hydrocillator;
    obj_stat_track.stat_kills_legsaw += global.kills_legsaw;
    obj_stat_track.stat_kills_missilepack += global.kills_missilepack;
    obj_stat_track.stat_kills_parasight += global.kills_parasight;
    obj_stat_track.stat_kills_puckrack += global.kills_puckrack;
    obj_stat_track.stat_kills_slimespike += global.kills_slimespike;
    obj_stat_track.stat_kills_telecom += global.kills_telecom;
    obj_stat_track.stat_kills_ultrabuster += global.kills_ultrabuster;
    obj_stat_track.stat_kills_bow += global.kills_bow;
    obj_stat_track.stat_kills_flamethrower += global.kills_flamethrower;
    obj_stat_track.stat_kills_headphones += global.kills_headphones;
    obj_stat_track.stat_kills_ninja += global.kills_ninja;
    obj_stat_track.stat_kills_plasma += global.kills_plasma;
    obj_stat_track.stat_kills_remote += global.kills_remote;
    obj_stat_track.stat_kills_satellite += global.kills_satellite;
    obj_stat_track.stat_kills_snowglobe += global.kills_snowglobe;
    obj_stat_track.stat_kills_spear += global.kills_spear;
    obj_stat_track.stat_kills_turret += global.kills_turret;
    obj_stat_track.stat_kills_angelwings += global.kills_angelwings;
    obj_stat_track.stat_kills_batwings += global.kills_batwings;
    obj_stat_track.stat_kills_c4 += global.kills_c4;
    obj_stat_track.stat_kills_shottyvest += global.kills_shottyvest;
    obj_stat_track.stat_kills_plaguemask += global.kills_plaguemask;
    obj_stat_track.stat_kills_eel += global.kills_eel;
    obj_stat_track.stat_kills_icecream += global.kills_icecream;
    obj_stat_track.stat_kills_lighter += global.kills_lighter;
    obj_stat_track.stat_kills_chainsword += global.kills_chainsword;
    obj_stat_track.stat_kills_firewall += global.kills_firewall;
    obj_stat_track.stat_kills_reaper += global.kills_reaper;
    obj_stat_track.stat_kills_tentacle += global.kills_tentacle;
    obj_stat_track.stat_kills_dynamite += global.kills_dynamite;
    obj_stat_track.stat_kills_carrot += global.kills_carrot;
    obj_stat_track.stat_kills_bees += global.kills_bees;
    obj_stat_track.stat_kills_midas += global.kills_midas;
    obj_stat_track.stat_kills_fish += global.kills_fish;
    obj_stat_track.stat_kills_cheese += global.kills_cheese;
    obj_stat_track.stat_kills_psycho += global.kills_psycho;
    setup_damage_vars();
}

function add_weapon_damage(arg0, arg1)
{
    if (arg0 > 0)
    {
        switch (arg0)
        {
            case 0:
                global.damage_unsorted += arg1;
                break;
            
            case 1:
                global.damage_core += arg1;
                break;
            
            case 2:
                global.damage_chainbelt += arg1;
                break;
            
            case 3:
                global.damage_daggerglove += arg1;
                break;
            
            case 4:
                global.damage_eye2 += arg1;
                break;
            
            case 5:
                global.damage_horns += arg1;
                break;
            
            case 6:
                global.damage_hydrocillator += arg1;
                break;
            
            case 7:
                global.damage_legsaw += arg1;
                break;
            
            case 8:
                global.damage_missilepack += arg1;
                break;
            
            case 9:
                global.damage_parasight += arg1;
                break;
            
            case 10:
                global.damage_puckrack += arg1;
                break;
            
            case 11:
                global.damage_slimespike += arg1;
                break;
            
            case 12:
                global.damage_telecom += arg1;
                break;
            
            case 13:
                global.damage_ultrabuster += arg1;
                break;
            
            case 14:
                global.damage_bow += arg1;
                break;
            
            case 15:
                global.damage_flamethrower += arg1;
                break;
            
            case 16:
                global.damage_headphones += arg1;
                break;
            
            case 17:
                global.damage_ninja += arg1;
                break;
            
            case 18:
                global.damage_plasma += arg1;
                break;
            
            case 19:
                global.damage_remote += arg1;
                break;
            
            case 20:
                global.damage_satellite += arg1;
                break;
            
            case 21:
                global.damage_snowglobe += arg1;
                break;
            
            case 22:
                global.damage_spear += arg1;
                break;
            
            case 23:
                global.damage_turret += arg1;
                break;
            
            case 24:
                global.damage_angelwings += arg1;
                break;
            
            case 25:
                global.damage_batwings += arg1;
                break;
            
            case 26:
                global.damage_c4 += arg1;
                break;
            
            case 27:
                global.damage_shottyvest += arg1;
                break;
            
            case 28:
                global.damage_plaguemask += arg1;
                break;
            
            case 29:
                global.damage_eel += arg1;
                break;
            
            case 30:
                global.damage_icecream += arg1;
                break;
            
            case 31:
                global.damage_lighter += arg1;
                break;
            
            case 32:
                global.damage_chainsword += arg1;
                break;
            
            case 33:
                global.damage_firewall += arg1;
                break;
            
            case 34:
                global.damage_reaper += arg1;
                break;
            
            case 35:
                global.damage_tentacle += arg1;
                break;
            
            case 36:
                global.damage_dynamite += arg1;
                break;
            
            case 37:
                global.damage_carrot += arg1;
                break;
            
            case 38:
                global.damage_bees += arg1;
                break;
            
            case 39:
                global.damage_midas += arg1;
                break;
            
            case 40:
                global.damage_fish += arg1;
                break;
            
            case 41:
                global.damage_cheese += arg1;
                break;
            
            case 42:
                global.damage_psycho += arg1;
                break;
        }
    }
}

function get_weapon_stat(arg0, arg1, arg2 = 0)
{
    var ret_num = 0;
    
    if (arg2 == 0)
    {
        if (arg1 == 0)
        {
            switch (arg0)
            {
                case 0:
                    ret_num = global.damage_unsorted;
                    break;
                
                case 1:
                    ret_num = global.damage_core;
                    break;
                
                case 2:
                    ret_num = global.damage_chainbelt;
                    break;
                
                case 3:
                    ret_num = global.damage_daggerglove;
                    break;
                
                case 4:
                    ret_num = global.damage_eye2;
                    break;
                
                case 5:
                    ret_num = global.damage_horns;
                    break;
                
                case 6:
                    ret_num = global.damage_hydrocillator;
                    break;
                
                case 7:
                    ret_num = global.damage_legsaw;
                    break;
                
                case 8:
                    ret_num = global.damage_missilepack;
                    break;
                
                case 9:
                    ret_num = global.damage_parasight;
                    break;
                
                case 10:
                    ret_num = global.damage_puckrack;
                    break;
                
                case 11:
                    ret_num = global.damage_slimespike;
                    break;
                
                case 12:
                    ret_num = global.damage_telecom;
                    break;
                
                case 13:
                    ret_num = global.damage_ultrabuster;
                    break;
                
                case 14:
                    ret_num = global.damage_bow;
                    break;
                
                case 15:
                    ret_num = global.damage_flamethrower;
                    break;
                
                case 16:
                    ret_num = global.damage_headphones;
                    break;
                
                case 17:
                    ret_num = global.damage_ninja;
                    break;
                
                case 18:
                    ret_num = global.damage_plasma;
                    break;
                
                case 19:
                    ret_num = global.damage_remote;
                    break;
                
                case 20:
                    ret_num = global.damage_satellite;
                    break;
                
                case 21:
                    ret_num = global.damage_snowglobe;
                    break;
                
                case 22:
                    ret_num = global.damage_spear;
                    break;
                
                case 23:
                    ret_num = global.damage_turret;
                    break;
                
                case 24:
                    ret_num = global.damage_angelwings;
                    break;
                
                case 25:
                    ret_num = global.damage_batwings;
                    break;
                
                case 26:
                    ret_num = global.damage_c4;
                    break;
                
                case 27:
                    ret_num = global.damage_shottyvest;
                    break;
                
                case 28:
                    ret_num = global.damage_plaguemask;
                    break;
                
                case 29:
                    ret_num = global.damage_eel;
                    break;
                
                case 30:
                    ret_num = global.damage_icecream;
                    break;
                
                case 31:
                    ret_num = global.damage_lighter;
                    break;
                
                case 32:
                    ret_num = global.damage_chainsword;
                    break;
                
                case 33:
                    ret_num = global.damage_firewall;
                    break;
                
                case 34:
                    ret_num = global.damage_reaper;
                    break;
                
                case 35:
                    ret_num = global.damage_tentacle;
                    break;
                
                case 36:
                    ret_num = global.damage_dynamite;
                    break;
                
                case 37:
                    ret_num = global.damage_carrot;
                    break;
                
                case 38:
                    ret_num = global.damage_bees;
                    break;
                
                case 39:
                    ret_num = global.damage_midas;
                    break;
                
                case 40:
                    ret_num = global.damage_fish;
                    break;
                
                case 41:
                    ret_num = global.damage_cheese;
                    break;
                
                case 42:
                    ret_num = global.damage_psycho;
                    break;
            }
        }
        else
        {
            switch (arg0)
            {
                case 0:
                    ret_num = global.kills_unsorted;
                    break;
                
                case 1:
                    ret_num = global.kills_core;
                    break;
                
                case 2:
                    ret_num = global.kills_chainbelt;
                    break;
                
                case 3:
                    ret_num = global.kills_daggerglove;
                    break;
                
                case 4:
                    ret_num = global.kills_eye2;
                    break;
                
                case 5:
                    ret_num = global.kills_horns;
                    break;
                
                case 6:
                    ret_num = global.kills_hydrocillator;
                    break;
                
                case 7:
                    ret_num = global.kills_legsaw;
                    break;
                
                case 8:
                    ret_num = global.kills_missilepack;
                    break;
                
                case 9:
                    ret_num = global.kills_parasight;
                    break;
                
                case 10:
                    ret_num = global.kills_puckrack;
                    break;
                
                case 11:
                    ret_num = global.kills_slimespike;
                    break;
                
                case 12:
                    ret_num = global.kills_telecom;
                    break;
                
                case 13:
                    ret_num = global.kills_ultrabuster;
                    break;
                
                case 14:
                    ret_num = global.kills_bow;
                    break;
                
                case 15:
                    ret_num = global.kills_flamethrower;
                    break;
                
                case 16:
                    ret_num = global.kills_headphones;
                    break;
                
                case 17:
                    ret_num = global.kills_ninja;
                    break;
                
                case 18:
                    ret_num = global.kills_plasma;
                    break;
                
                case 19:
                    ret_num = global.kills_remote;
                    break;
                
                case 20:
                    ret_num = global.kills_satellite;
                    break;
                
                case 21:
                    ret_num = global.kills_snowglobe;
                    break;
                
                case 22:
                    ret_num = global.kills_spear;
                    break;
                
                case 23:
                    ret_num = global.kills_turret;
                    break;
                
                case 24:
                    ret_num = global.kills_angelwings;
                    break;
                
                case 25:
                    ret_num = global.kills_batwings;
                    break;
                
                case 26:
                    ret_num = global.kills_c4;
                    break;
                
                case 27:
                    ret_num = global.kills_shottyvest;
                    break;
                
                case 28:
                    ret_num = global.kills_plaguemask;
                    break;
                
                case 29:
                    ret_num = global.kills_eel;
                    break;
                
                case 30:
                    ret_num = global.kills_icecream;
                    break;
                
                case 31:
                    ret_num = global.kills_lighter;
                    break;
                
                case 32:
                    ret_num = global.kills_chainsword;
                    break;
                
                case 33:
                    ret_num = global.kills_firewall;
                    break;
                
                case 34:
                    ret_num = global.kills_reaper;
                    break;
                
                case 35:
                    ret_num = global.kills_tentacle;
                    break;
                
                case 36:
                    ret_num = global.kills_dynamite;
                    break;
                
                case 37:
                    ret_num = global.kills_carrot;
                    break;
                
                case 38:
                    ret_num = global.kills_bees;
                    break;
                
                case 39:
                    ret_num = global.kills_midas;
                    break;
                
                case 40:
                    ret_num = global.kills_fish;
                    break;
                
                case 41:
                    ret_num = global.kills_cheese;
                    break;
                
                case 42:
                    ret_num = global.kills_psycho;
                    break;
            }
        }
    }
    else if (arg1 == 0)
    {
        switch (arg0)
        {
            case 0:
                ret_num = obj_stat_track.stat_damage_unsorted;
                break;
            
            case 1:
                ret_num = obj_stat_track.stat_damage_core;
                break;
            
            case 2:
                ret_num = obj_stat_track.stat_damage_chainbelt;
                break;
            
            case 3:
                ret_num = obj_stat_track.stat_damage_daggerglove;
                break;
            
            case 4:
                ret_num = obj_stat_track.stat_damage_eye2;
                break;
            
            case 5:
                ret_num = obj_stat_track.stat_damage_horns;
                break;
            
            case 6:
                ret_num = obj_stat_track.stat_damage_hydrocillator;
                break;
            
            case 7:
                ret_num = obj_stat_track.stat_damage_legsaw;
                break;
            
            case 8:
                ret_num = obj_stat_track.stat_damage_missilepack;
                break;
            
            case 9:
                ret_num = obj_stat_track.stat_damage_parasight;
                break;
            
            case 10:
                ret_num = obj_stat_track.stat_damage_puckrack;
                break;
            
            case 11:
                ret_num = obj_stat_track.stat_damage_slimespike;
                break;
            
            case 12:
                ret_num = obj_stat_track.stat_damage_telecom;
                break;
            
            case 13:
                ret_num = obj_stat_track.stat_damage_ultrabuster;
                break;
            
            case 14:
                ret_num = obj_stat_track.stat_damage_bow;
                break;
            
            case 15:
                ret_num = obj_stat_track.stat_damage_flamethrower;
                break;
            
            case 16:
                ret_num = obj_stat_track.stat_damage_headphones;
                break;
            
            case 17:
                ret_num = obj_stat_track.stat_damage_ninja;
                break;
            
            case 18:
                ret_num = obj_stat_track.stat_damage_plasma;
                break;
            
            case 19:
                ret_num = obj_stat_track.stat_damage_remote;
                break;
            
            case 20:
                ret_num = obj_stat_track.stat_damage_satellite;
                break;
            
            case 21:
                ret_num = obj_stat_track.stat_damage_snowglobe;
                break;
            
            case 22:
                ret_num = obj_stat_track.stat_damage_spear;
                break;
            
            case 23:
                ret_num = obj_stat_track.stat_damage_turret;
                break;
            
            case 24:
                ret_num = obj_stat_track.stat_damage_angelwings;
                break;
            
            case 25:
                ret_num = obj_stat_track.stat_damage_batwings;
                break;
            
            case 26:
                ret_num = obj_stat_track.stat_damage_c4;
                break;
            
            case 27:
                ret_num = obj_stat_track.stat_damage_shottyvest;
                break;
            
            case 28:
                ret_num = obj_stat_track.stat_damage_plaguemask;
                break;
            
            case 29:
                ret_num = obj_stat_track.stat_damage_eel;
                break;
            
            case 30:
                ret_num = obj_stat_track.stat_damage_icecream;
                break;
            
            case 31:
                ret_num = obj_stat_track.stat_damage_lighter;
                break;
            
            case 32:
                ret_num = obj_stat_track.stat_damage_chainsword;
                break;
            
            case 33:
                ret_num = obj_stat_track.stat_damage_firewall;
                break;
            
            case 34:
                ret_num = obj_stat_track.stat_damage_reaper;
                break;
            
            case 35:
                ret_num = obj_stat_track.stat_damage_tentacle;
                break;
            
            case 36:
                ret_num = obj_stat_track.stat_damage_dynamite;
                break;
            
            case 37:
                ret_num = obj_stat_track.stat_damage_carrot;
                break;
            
            case 38:
                ret_num = obj_stat_track.stat_damage_bees;
                break;
            
            case 39:
                ret_num = obj_stat_track.stat_damage_midas;
                break;
            
            case 40:
                ret_num = obj_stat_track.stat_damage_fish;
                break;
            
            case 41:
                ret_num = obj_stat_track.stat_damage_cheese;
                break;
            
            case 42:
                ret_num = obj_stat_track.stat_damage_psycho;
                break;
        }
    }
    else
    {
        switch (arg0)
        {
            case 0:
                ret_num = obj_stat_track.stat_kills_unsorted;
                break;
            
            case 1:
                ret_num = obj_stat_track.stat_kills_core;
                break;
            
            case 2:
                ret_num = obj_stat_track.stat_kills_chainbelt;
                break;
            
            case 3:
                ret_num = obj_stat_track.stat_kills_daggerglove;
                break;
            
            case 4:
                ret_num = obj_stat_track.stat_kills_eye2;
                break;
            
            case 5:
                ret_num = obj_stat_track.stat_kills_horns;
                break;
            
            case 6:
                ret_num = obj_stat_track.stat_kills_hydrocillator;
                break;
            
            case 7:
                ret_num = obj_stat_track.stat_kills_legsaw;
                break;
            
            case 8:
                ret_num = obj_stat_track.stat_kills_missilepack;
                break;
            
            case 9:
                ret_num = obj_stat_track.stat_kills_parasight;
                break;
            
            case 10:
                ret_num = obj_stat_track.stat_kills_puckrack;
                break;
            
            case 11:
                ret_num = obj_stat_track.stat_kills_slimespike;
                break;
            
            case 12:
                ret_num = obj_stat_track.stat_kills_telecom;
                break;
            
            case 13:
                ret_num = obj_stat_track.stat_kills_ultrabuster;
                break;
            
            case 14:
                ret_num = obj_stat_track.stat_kills_bow;
                break;
            
            case 15:
                ret_num = obj_stat_track.stat_kills_flamethrower;
                break;
            
            case 16:
                ret_num = obj_stat_track.stat_kills_headphones;
                break;
            
            case 17:
                ret_num = obj_stat_track.stat_kills_ninja;
                break;
            
            case 18:
                ret_num = obj_stat_track.stat_kills_plasma;
                break;
            
            case 19:
                ret_num = obj_stat_track.stat_kills_remote;
                break;
            
            case 20:
                ret_num = obj_stat_track.stat_kills_satellite;
                break;
            
            case 21:
                ret_num = obj_stat_track.stat_kills_snowglobe;
                break;
            
            case 22:
                ret_num = obj_stat_track.stat_kills_spear;
                break;
            
            case 23:
                ret_num = obj_stat_track.stat_kills_turret;
                break;
            
            case 24:
                ret_num = obj_stat_track.stat_kills_angelwings;
                break;
            
            case 25:
                ret_num = obj_stat_track.stat_kills_batwings;
                break;
            
            case 26:
                ret_num = obj_stat_track.stat_kills_c4;
                break;
            
            case 27:
                ret_num = obj_stat_track.stat_kills_shottyvest;
                break;
            
            case 28:
                ret_num = obj_stat_track.stat_kills_plaguemask;
                break;
            
            case 29:
                ret_num = obj_stat_track.stat_kills_eel;
                break;
            
            case 30:
                ret_num = obj_stat_track.stat_kills_icecream;
                break;
            
            case 31:
                ret_num = obj_stat_track.stat_kills_lighter;
                break;
            
            case 32:
                ret_num = obj_stat_track.stat_kills_chainsword;
                break;
            
            case 33:
                ret_num = obj_stat_track.stat_kills_firewall;
                break;
            
            case 34:
                ret_num = obj_stat_track.stat_kills_reaper;
                break;
            
            case 35:
                ret_num = obj_stat_track.stat_kills_tentacle;
                break;
            
            case 36:
                ret_num = obj_stat_track.stat_kills_dynamite;
                break;
            
            case 37:
                ret_num = obj_stat_track.stat_kills_carrot;
                break;
            
            case 38:
                ret_num = obj_stat_track.stat_kills_bees;
                break;
            
            case 39:
                ret_num = obj_stat_track.stat_kills_midas;
                break;
            
            case 40:
                ret_num = obj_stat_track.stat_kills_fish;
                break;
            
            case 41:
                ret_num = obj_stat_track.stat_kills_cheese;
                break;
            
            case 42:
                ret_num = obj_stat_track.stat_kills_psycho;
                break;
        }
    }
    
    return ret_num;
}

function add_weapon_kill(arg0)
{
    if (arg0 > 0)
    {
        switch (arg0)
        {
            case 0:
                global.kills_unsorted += 1;
                break;
            
            case 1:
                global.kills_core += 1;
                break;
            
            case 2:
                global.kills_chainbelt += 1;
                break;
            
            case 3:
                global.kills_daggerglove += 1;
                break;
            
            case 4:
                global.kills_eye2 += 1;
                break;
            
            case 5:
                global.kills_horns += 1;
                break;
            
            case 6:
                global.kills_hydrocillator += 1;
                break;
            
            case 7:
                global.kills_legsaw += 1;
                break;
            
            case 8:
                global.kills_missilepack += 1;
                break;
            
            case 9:
                global.kills_parasight += 1;
                break;
            
            case 10:
                global.kills_puckrack += 1;
                break;
            
            case 11:
                global.kills_slimespike += 1;
                break;
            
            case 12:
                global.kills_telecom += 1;
                break;
            
            case 13:
                global.kills_ultrabuster += 1;
                break;
            
            case 14:
                global.kills_bow += 1;
                break;
            
            case 15:
                global.kills_flamethrower += 1;
                break;
            
            case 16:
                global.kills_headphones += 1;
                break;
            
            case 17:
                global.kills_ninja += 1;
                break;
            
            case 18:
                global.kills_plasma += 1;
                break;
            
            case 19:
                global.kills_remote += 1;
                break;
            
            case 20:
                global.kills_satellite += 1;
                break;
            
            case 21:
                global.kills_snowglobe += 1;
                break;
            
            case 22:
                global.kills_spear += 1;
                break;
            
            case 23:
                global.kills_turret += 1;
                break;
            
            case 24:
                global.kills_angelwings += 1;
                break;
            
            case 25:
                global.kills_batwings += 1;
                break;
            
            case 26:
                global.kills_c4 += 1;
                break;
            
            case 27:
                global.kills_shottyvest += 1;
                break;
            
            case 28:
                global.kills_plaguemask += 1;
                break;
            
            case 29:
                global.kills_eel += 1;
                break;
            
            case 30:
                global.kills_icecream += 1;
                break;
            
            case 31:
                global.kills_lighter += 1;
                break;
            
            case 32:
                global.kills_chainsword += 1;
                break;
            
            case 33:
                global.kills_firewall += 1;
                break;
            
            case 34:
                global.kills_reaper += 1;
                break;
            
            case 35:
                global.kills_tentacle += 1;
                break;
            
            case 36:
                global.kills_dynamite += 1;
                break;
            
            case 37:
                global.kills_carrot += 1;
                break;
            
            case 38:
                global.kills_bees += 1;
                break;
            
            case 39:
                global.kills_midas += 1;
                break;
            
            case 40:
                global.kills_fish += 1;
                break;
            
            case 41:
                global.kills_cheese += 1;
                break;
            
            case 42:
                global.kills_psycho += 1;
                break;
        }
    }
}
