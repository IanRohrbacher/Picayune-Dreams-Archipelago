function log(arg0 = "", arg1 = 0)
{
    var level = "INFO";

    if (arg1 == 1)
        level = "WARN";
    else if (arg1 == 2)
        level = "ERROR";

    var now = date_current_datetime();
    var stamp = string(date_get_year(now)) + "-" + ap_pad2(date_get_month(now)) + "-" + ap_pad2(date_get_day(now)) + " " + ap_pad2(date_get_hour(now)) + ":" + ap_pad2(date_get_minute(now)) + ":" + ap_pad2(date_get_second(now));
    var file = file_text_open_append(program_directory + "ap_log.txt");

    if (file == -1)
        return;

    file_text_write_string(file, stamp + " [" + level + "] " + string_replace_all(string(arg0), program_directory, ""));
    file_text_writeln(file);
    file_text_close(file);
}
