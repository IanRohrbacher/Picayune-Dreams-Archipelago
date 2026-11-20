ini_open(global.save_options);

if (variable == "christmas")
{
    if (global.month == 12 && global.day > 5 && global.day < 20)
    {
        global.event = ini_read_real("other", "event", 0);
        
        if (global.event == 1)
            toggled = 1;
        else
            toggled = 0;
        
        title = "Toggle Christmas?";
        desc = "Frost Globe buff, candy canes, presents and holiday cheer...";
    }
    else
    {
        instance_destroy();
        
        if (global.event == 1)
            global.event = 0;
    }
}

ini_close();
