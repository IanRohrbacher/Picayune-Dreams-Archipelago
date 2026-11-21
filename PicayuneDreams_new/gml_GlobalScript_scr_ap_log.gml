// Starts a log session in ap_log.txt next to the exe; a log over 512 KB is moved to ap_log_old.txt first.
function ap_log_begin()
{
    var path = program_directory + "ap_log.txt";

    if (file_exists(path))
    {
        var handle = file_bin_open(path, 0);
        var size = file_bin_size(handle);
        file_bin_close(handle);

        if (size > 524288)
        {
            var old_path = program_directory + "ap_log_old.txt";

            if (file_exists(old_path))
                file_delete(old_path);

            file_rename(path, old_path);
        }
    }

    log("==== session start ====");
}

// Logs text as a warning the first time it is called in a session. Used where code should be unreachable
// and may run every frame, so a stray call shows up once instead of flooding the log.
function ap_log_once(text)
{
    if (!variable_global_exists("ap_log_seen"))
        global.ap_log_seen = {};

    if (variable_struct_exists(global.ap_log_seen, text))
        return;

    variable_struct_set(global.ap_log_seen, text, true);
    log(text, 1);
}
