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
    log("connect start: host=" + string(host) + " port=" + string(port) + " slot=" + string(slot) + ((password == "") ? " (no password)" : " (password set)"));

    if (global.ap_debug_tools)
    {
        global.ap_connect_state = 4;
        log("connect: debug bypass, state 4");
        return;
    }

    global.ap_connect_state = 3;
    global.ap_error = "The Archipelago client is not implemented yet.";
    log("connect: " + global.ap_error, 1);
}

function ap_connect_cancel()
{
    log("connect cancel, state was " + string(global.ap_connect_state));
    global.ap_connect_state = 0;
}
