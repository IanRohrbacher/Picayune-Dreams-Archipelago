function ap_client_init()
{
    if (!variable_global_exists("ap_connect_state"))
        global.ap_connect_state = 0;

    if (!variable_global_exists("ap_error"))
        global.ap_error = "";
}

function ap_connect_start(host, port, slot, password)
{
    global.ap_error = "";

    if (global.ap_debug_tools)
    {
        global.ap_connect_state = 4;
        return;
    }

    global.ap_connect_state = 3;
    global.ap_error = "The Archipelago client is not implemented yet.";
}

function ap_connect_cancel()
{
    global.ap_connect_state = 0;
}
