displaykey[0] = 223;
displaykey[1] = 220;
displaykey[2] = 112;
closekey[0] = 223;
closekey[1] = 220;
closekey[2] = 112;
closekey[3] = 27;
cd = 0;
open_me_key_count = array_length_1d(displaykey);
close_me_key_count = array_length_1d(closekey);
prediction_count_max = 11;
history_count_max = 20;
history_file_name = "console.txt";
view_history_datapoints = 500;
history_background_col = 0;
history_background_alpha = 0.8;
history_text_col = 11382189;
history_text_col_info = 5271952;
history_text_col_focus = 6862591;
history_text_col_hover = 34047;
history_text_alpha = 1;
history_text_shadow = 0.2;
history_border_col = 34047;
history_border_alpha = 1;
main_background_col = 3947580;
main_background_alpha = 0.8;
main_text1_col = 16777215;
main_text2_col = 10526880;
main_text3_col = 34047;
main_text_alpha = 1;
main_text_shadow = 0.3;
main_text_bad_col = 12237553;
main_border_col = 13750737;
main_border_alpha = 1;
main_mouse_selected_col = 34047;
predict_background_col = 0;
predict_background_alpha = 0.3;
predict_text_col = 16777215;
predict_text_alpha = 1;
predict_text_shadow = 0.7;
predict_border_col = 0;
predict_border_alpha = 0.7;
focus_background_col = 3947580;
focus_background_alpha = 1;
focus_text_col = 34047;
focus_arrow_colour = 34047;
view_background_col = 3947580;
view_background_alpha = 0.8;
view_border_col = 16448250;
view_border_alpha = 1;
view_text_title_col = 16777215;
view_text_value_col = 34047;
view_text_name_col = 34047;
view_data_bar_col = 34047;
view_data_bar_alpha = 0;
view_data_top_col = 34047;
view_data_top_alpha = 1;
view_intro_highlight_col = 16777215;
pos_top = -1;
pos_height = 300;
pos_margin_sides = 24;
pos_inner_padding_sides = 20;
pos_inner_padding_bottom = 25;
main_area_height = 40;
main_area_inner_padding_sides = 50;
history_line_height = 24;
predict_line_height = 22;
view_bottom_margin = 800;
view_bottom_padding = 10;
view_left_margin = 850;
view_left_padding = 60;
view_data_height = 32;
view_data_width = 110;
view_each_height = 50;
display_frames = 27;
display_frame = 0;
display_direction = 0;
display_open_speed = 6;
display_close_speed = 8;
predict_grow_speed = 74;
predict_shrink_speed = 53;
dt = delta_time / 100000;
font_for_main = fnt_freddy;

if (instance_number(obj_console) < 1)
    instance_destroy();

history_x1 = pos_margin_sides;
history_y1 = pos_top;
history_x2 = display_get_gui_width() - pos_margin_sides;
history_y2 = pos_top + pos_height;
history_text_x = history_x1 + pos_inner_padding_sides;
history_text_y = history_y2 - pos_inner_padding_bottom;
main_x1 = history_x1;
main_y1 = history_y2 + 1;
main_x2 = history_x2;
main_y2 = main_y1 + main_area_height;
predict_x1 = main_x1;
predict_y1 = 0;
predict_x2 = main_x2;
predict_y2 = history_y2;
predict_y2_draw = history_y2;
text_start_x = main_x1 + main_area_inner_padding_sides;
text_end_x = text_start_x;
text_y = main_y1 + floor((main_y2 - main_y1) / 2);
view_data_left_x = view_left_margin + view_left_padding;
view_data_right_x = view_data_left_x + view_data_width + view_left_padding;
predict_count = 0;
text = "";
text_changed = true;
text_char_length[0] = 0;
text_char_running_length[0] = 0;
cursor_at = 0;
cursor_at_stage = -1;
cursor_at_stage_last = -1;
stage_count = 0;
stage_text_length[0] = 0;
stage_text_running_length[0] = 0;
good_first_stage = false;
command_to_run = -1;
focus = 0;
temp_post_message = "";
history_file_path = working_directory + global.save_dir + history_file_name;
view_destroyed_frames = 200;
view_intro_highlight_frames = 10;
mouse_selection_start = 0;
mouse_selection_end = 0;
mouse_selection_temp = -1;
mouse_x_last = device_mouse_x_to_gui(0);
mouse_y_last = device_mouse_y_to_gui(0);
history_mouse_hover = -1;
console_version = "0.2.1";
flash_frames = 45;
flash_frame = 0;
flash_frames_half = floor(flash_frames / 2);
holding_delete_frames = 0;
holding_backspace_frames = 0;
holding_frame_to_activate = 15;
holding_frame_delete_speed = 4;
var i = 0;
delimiters[i++] = " ";
delimiters[i++] = ".";
delimiters[i++] = ",";
delimiters[i++] = "(";
delimiters[i++] = ")";
delimiters[i++] = "=";
delimiter_count = i++;
text_part[0] = "";
history_text[0] = "";
history_text_type[0] = 0;
history_text_count = 0;
var lastline = "";
var thisline = "";

if (file_exists(history_file_path))
{
    var save_file = file_text_open_read(history_file_path);
    
    for (i = 0; i < history_count_max; i++)
    {
        if (!file_text_eoln(save_file))
        {
            thisline = file_text_read_string(save_file);
            
            if (thisline != lastline)
            {
                history_text[i] = thisline;
                history_text_type[i] = 1;
                history_text_count++;
                lastline = thisline;
            }
            
            file_text_readln(save_file);
        }
        else
        {
            break;
        }
    }
    
    file_text_close(save_file);
}

view_active_count = 0;
view_text[0] = "No Data";
view_title[0] = "No Data";
view_obj[0] = -1;
view_min[0] = 9999999;
view_max[0] = 9999999;
view_last_data[0] = 0;
view_type[0] = 0;
view_destroyed_frame[0] = view_destroyed_frames;
view_recalculate[0] = false;
view_graph_pixels[0][0] = 0;
view_graph_data[0][0] = 0;
view_next_insert[0] = 0;
view_intro_highlight_frame[0] = view_intro_highlight_frames;
i = 0;
commands[UnknownEnum.Value_0] = "create";
commands[UnknownEnum.Value_1] = "set";
commands[UnknownEnum.Value_2] = "destroy";
commands[UnknownEnum.Value_3] = "view";
commands[UnknownEnum.Value_4] = "script";
commands[UnknownEnum.Value_5] = "game";
commands[UnknownEnum.Value_6] = "console";
commands_visible = array_create(UnknownEnum.Value_7, false);
commands_focused = array_create(UnknownEnum.Value_7, false);
predictions[0] = "";
predictions_visible[0] = 0;
predictions_focused[0] = 0;
command_to_prediction[0] = 0;
second_level_commands[0] = 0;
i = 0;
var still_finding_objects = true;

do
{
    if (object_exists(i))
    {
        second_level[UnknownEnum.Value_0][i] = object_get_name(i);
        second_level[UnknownEnum.Value_1][i] = second_level[UnknownEnum.Value_0][i];
        second_level[UnknownEnum.Value_2][i] = second_level[UnknownEnum.Value_0][i];
        second_level[UnknownEnum.Value_3][i] = second_level[UnknownEnum.Value_0][i];
        i++;
    }
    else
    {
        still_finding_objects = false;
    }
}
until (!still_finding_objects);

i = 0;
still_finding_objects = true;

do
{
    if (script_exists(i))
    {
        second_level[UnknownEnum.Value_4][i] = script_get_name(i);
        i++;
    }
    else
    {
        still_finding_objects = false;
    }
}
until (!still_finding_objects);

i = 0;
second_level[UnknownEnum.Value_5][i++] = "speed_set";
second_level[UnknownEnum.Value_5][i++] = "resource_count";
second_level[UnknownEnum.Value_5][i++] = "instance_count";
second_level[UnknownEnum.Value_5][i++] = "restart";
second_level[UnknownEnum.Value_5][i++] = "fullscreen_toggle";
second_level[UnknownEnum.Value_5][i++] = "room_restart";
second_level[UnknownEnum.Value_5][i++] = "room_goto";
second_level[UnknownEnum.Value_5][i++] = "debug_overlay";
second_level[UnknownEnum.Value_5][i++] = "texture_debug";
second_level[UnknownEnum.Value_5][i++] = "debug_event";
i = 0;
second_level[UnknownEnum.Value_6][i++] = "clear_screen";
second_level[UnknownEnum.Value_6][i++] = "delete_history";
second_level[UnknownEnum.Value_6][i++] = "version";
second_level[UnknownEnum.Value_6][i++] = "check_for_updates";
second_level[UnknownEnum.Value_6][i++] = "about";
third_level[0] = "";

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7
}
