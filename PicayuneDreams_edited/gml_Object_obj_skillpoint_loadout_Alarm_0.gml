// Loadout files are kept in the save folder, shared by every slot.
ini_open(global.save_dir + "loadout" + string(loadout_num));
skillpointsspent = ini_read_real("skills", "skillpointsspent", 0);
ini_close();
