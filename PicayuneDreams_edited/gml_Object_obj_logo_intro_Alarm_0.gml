var ftr = instance_create_depth(x, y, -99999, obj_fadetoroom);

if (false)
{
    // AP connect screen

    // open first game
    // global.gamestart_ind = 0;
    // ftr.rm = rm_fadetogame;
}
else
{
    ftr.rm = rm_mainmenu;
    try_to_unlock_achievements();
}
