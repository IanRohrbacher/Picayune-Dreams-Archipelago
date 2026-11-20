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
