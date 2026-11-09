function GMLspeakEnvironment() : CatspeakEnvironment() constructor
{
    static enableWritingRoom = function(arg0)
    {
        if (arg0)
        {
            addKeyword("room", UnknownEnum.Value_81);
            interface.addBanList("room");
        }
        else
        {
            removeKeyword("room");
            interface.addPardonList("room");
        }
        
        return self;
    };
    
    static enableWritingRoomProperties = function(arg0)
    {
        if (arg0)
        {
            addKeyword("room_width", UnknownEnum.Value_82, "room_height", UnknownEnum.Value_83, "room_persistent", UnknownEnum.Value_84);
            interface.addBanList("room_width", "room_height", "room_persistent");
        }
        else
        {
            removeKeyword("room_width", "room_height", "room_persistent");
            interface.addPardonList("room_width", "room_height", "room_persistent");
        }
        
        canWriteRoomProperties = arg0;
        return self;
    };
    
    static enableWritingIOProperties = function(arg0)
    {
        if (arg0)
        {
            addKeyword("keyboard_string", UnknownEnum.Value_86, "keyboard_key", UnknownEnum.Value_87, "keyboard_lastchar", UnknownEnum.Value_88, "keyboard_lastkey", UnknownEnum.Value_89, "mouse_lastbutton", UnknownEnum.Value_90, "cursor_sprite", UnknownEnum.Value_91);
            interface.addBanList("keyboard_string", "keyboard_key", "keyboard_lastchar", "keyboard_lastkey", "mouse_lastbutton", "cursor_sprite");
        }
        else
        {
            removeKeyword("keyboard_string", "keyboard_key", "keyboard_lastchar", "keyboard_lastkey", "mouse_lastbutton", "cursor_sprite");
            interface.addPardonList("keyboard_string", "keyboard_key", "keyboard_lastchar", "keyboard_lastkey", "mouse_lastbutton", "cursor_sprite");
        }
        
        return self;
    };
    
    static assignFilename = function(arg0)
    {
        if (!is_string(arg0) && !is_undefined(arg0))
            arg0 = string(arg0);
        
        currentFilename = arg0 ?? "unknown";
        return self;
    };
    
    static __AudioEffectTypeStruct = {};
    static __AudioLFOType = {};
    
    self.parserType = GMLspeakParser;
    self.lexerType = GMLspeakLexer;
    self.codegenType = GMLspeakCodegen;
    self.currentFilename = "unknown";
    self.canWriteRoomProperties = false;
    enableSharedGlobal(true);
    interface.compileFlags = 
    {
        checkForVariables: false,
        useVariableHash: false
    };
    renameKeyword("let", "var", "fun", "function", "impl", "constructor", "params", "arguments");
    removeKeyword("|>", "<|");
    addKeyword(";", UnknownEnum.Value_7, ":", UnknownEnum.Value_6, "//", UnknownEnum.Value_62, ";", UnknownEnum.Value_7, ":", UnknownEnum.Value_6, ",", UnknownEnum.Value_8, ".", UnknownEnum.Value_9, "=", UnknownEnum.Value_12, "*=", UnknownEnum.Value_13, "/=", UnknownEnum.Value_14, "-=", UnknownEnum.Value_15, "+=", UnknownEnum.Value_16, "%", UnknownEnum.Value_18, "*", UnknownEnum.Value_19, "/", UnknownEnum.Value_20, "div", UnknownEnum.Value_21, "-", UnknownEnum.Value_22, "+", UnknownEnum.Value_23, "==", UnknownEnum.Value_24, "!=", UnknownEnum.Value_25, ">", UnknownEnum.Value_26, ">=", UnknownEnum.Value_27, "<", UnknownEnum.Value_28, "<=", UnknownEnum.Value_29, "!", UnknownEnum.Value_30, "~", UnknownEnum.Value_31, ">>", UnknownEnum.Value_32, "<<", UnknownEnum.Value_33, "&", UnknownEnum.Value_34, "^", UnknownEnum.Value_35, "|", UnknownEnum.Value_36, "self", UnknownEnum.Value_57, "other", UnknownEnum.Value_64, "try", UnknownEnum.Value_42, "catch", UnknownEnum.Value_66, "finally", UnknownEnum.Value_101, "toString", UnknownEnum.Value_59, "#region", UnknownEnum.Value_62, "#endregion", UnknownEnum.Value_62, "div", UnknownEnum.Value_21, "&&", UnknownEnum.Value_37, "||", UnknownEnum.Value_38, ":=", UnknownEnum.Value_12, "mod", UnknownEnum.Value_18, "not", UnknownEnum.Value_30, "<>", UnknownEnum.Value_25, "begin", UnknownEnum.Value_4, "then", UnknownEnum.Value_61, "for", UnknownEnum.Value_70, "do", UnknownEnum.Value_71, "until", UnknownEnum.Value_72, "end", UnknownEnum.Value_5, "repeat", UnknownEnum.Value_69, "switch", UnknownEnum.Value_73, "case", UnknownEnum.Value_74, "default", UnknownEnum.Value_75, "/*", UnknownEnum.Value_76, "*/", UnknownEnum.Value_77, "??", UnknownEnum.Value_78, "??=", UnknownEnum.Value_79, "?", UnknownEnum.Value_95, "@", UnknownEnum.Value_93, "$", UnknownEnum.Value_92, "|", UnknownEnum.Value_96, "_GMLINE_", UnknownEnum.Value_97, "gml_GlobalScript_GMLspeakEnvironment", UnknownEnum.Value_98, "gml_Script____struct___174@GMLspeakEnvironment@GMLspeakEnvironment", UnknownEnum.Value_99, "argument", UnknownEnum.Value_58, "argument_count", UnknownEnum.Value_65);
    interface.exposeDynamicConstant("room", function()
    {
        return room;
    }, "room_width", function()
    {
        return room_width;
    }, "room_height", function()
    {
        return room_height;
    }, "room_persistent", function()
    {
        return room_persistent;
    }, "keyboard_string", function()
    {
        return keyboard_string;
    });
    interface.exposeConstant("global", sharedGlobal);
    interface.exposeMethod("method", __gmlspeak_method__, "$$__IS_NOT_NULLISH__$$", function(arg0)
    {
        return arg0 != undefined && arg0 != pointer_null;
    }, "$$__CURSOR_SPRITE__$$", function()
    {
        if (argument_count == 0)
            return cursor_sprite;
        
        cursor_sprite = argument[0];
    }, "$$__MOUSE_LASTBUTTON__$$", function()
    {
        if (argument_count == 0)
            return mouse_lastbutton;
        
        mouse_lastbutton = argument[0];
    }, "$$__KEYBOARD_STRING__$$", function()
    {
        if (argument_count == 0)
            return keyboard_string;
        
        keyboard_string = argument[0];
    }, "$$__KEYBOARD_KEY__$$", function()
    {
        if (argument_count == 0)
            return keyboard_key;
        
        keyboard_key = argument[0];
    }, "$$__KEYBOARD_LASTCHAR__$$", function()
    {
        if (argument_count == 0)
            return keyboard_lastchar;
        
        keyboard_lastchar = argument[0];
    }, "$$__KEYBOARD_LASTKEY__$$", function()
    {
        if (argument_count == 0)
            return keyboard_lastkey;
        
        keyboard_lastkey = argument[0];
    }, "$$__ROOM__$$", function()
    {
        if (argument_count == 0)
            return room;
        
        room = argument[0];
    }, "$$__ROOM_WIDTH__$$", function()
    {
        if (argument_count == 0)
            return room_width;
        
        room_width = argument[0];
    }, "$$__ROOM_HEIGHT__$$", function()
    {
        if (argument_count == 0)
            return room_height;
        
        room_height = argument[0];
    }, "$$__ROOM_PERSISTENT__$$", function()
    {
        if (argument_count == 0)
            return room_persistent;
        
        room_persistent = argument[0];
    }, "$$__VIEW_ENABLED__$$", function()
    {
        if (argument_count == 0)
            return view_enabled;
        
        view_enabled = argument[0];
    }, "$$__VIEW_VISIBLE__$$", function(arg0)
    {
        if (argument_count == 1)
            return view_visible[arg0];
        
        if (!canWriteRoomProperties)
            return __gmlspeak_error("Writing to room properties is disabled!");
        
        view_visible[arg0] = argument[1];
    }, "$$__VIEW_CAMERA__$", function(arg0)
    {
        if (argument_count == 1)
            return view_camera[arg0];
        
        if (!canWriteRoomProperties)
            return __gmlspeak_error("Writing to room properties is disabled!");
        
        view_camera[arg0] = argument[1];
    }, "$$__VIEW_XPORT__$$", function(arg0)
    {
        if (argument_count == 1)
            return view_xport[arg0];
        
        if (!canWriteRoomProperties)
            return __gmlspeak_error("Writing to room properties is disabled!");
        
        view_xport[arg0] = argument[1];
    }, "$$__VIEW_YPORT__$$", function(arg0)
    {
        if (argument_count == 1)
            return view_xport[arg0];
        
        if (!canWriteRoomProperties)
            return __gmlspeak_error("Writing to room properties is disabled!");
        
        view_xport[arg0] = argument[1];
    }, "$$__VIEW_WPORT__$$", function(arg0)
    {
        if (argument_count == 1)
            return view_wport[arg0];
        
        if (!canWriteRoomProperties)
            return __gmlspeak_error("Writing to room properties is disabled!");
        
        view_wport[arg0] = argument[1];
    }, "$$__VIEW_HPORT__$$", function(arg0)
    {
        if (argument_count == 1)
            return view_hport[arg0];
        
        if (!canWriteRoomProperties)
            return __gmlspeak_error("Writing to room properties is disabled!");
        
        view_hport[arg0] = argument[1];
    }, "$$__VIEW_SURFACE_ID__$$", function(arg0)
    {
        if (argument_count == 1)
            return view_surface_id[arg0];
        
        if (!canWriteRoomProperties)
            return __gmlspeak_error("Writing to room properties is disabled!");
        
        view_surface_id[arg0] = argument[1];
    }, "$$__STRUCT_ACCESSOR__$$", function(arg0, arg1)
    {
        if (argument_count == 2)
            return variable_struct_get(arg0, arg1);
        
        variable_struct_set(arg0, arg1, argument[2]);
    }, "$$__MAP_ACCESSOR__$$", function(arg0, arg1)
    {
        if (argument_count == 2)
            return ds_map_find_value(arg0, arg1);
        
        ds_map_set(arg0, arg1, argument[2]);
    }, "$$__LIST_ACCESSOR__$$", function(arg0, arg1)
    {
        if (argument_count == 2)
            return ds_list_find_value(arg0, arg1);
        
        ds_list_set(arg0, arg1, argument[2]);
    }, "$$__GRID_ACCESSOR__$$", function(arg0, arg1, arg2)
    {
        if (argument_count == 3)
            return ds_grid_get(arg0, arg1, arg2);
        
        ds_grid_set(arg0, arg1, arg2, argument[3]);
    }, "$$__ALARM_ACCESSOR__$$", method(undefined, function(arg0)
    {
        if (argument_count == 1)
            return alarm[arg0];
        
        alarm[arg0] = argument[1];
    }));
    interface.exposeConstant("gamespeed_fps", 0, "tm_countvsyncs", 1, "tm_sleep", 0, "gamespeed_microseconds", 1, "spritespeed_framespersecond", 0, "spritespeed_framespergameframe", 1, "timezone_local", 0, "timezone_utc", 1, "GM_version", "1.1.0.18", "GM_build_type", "exe", "GM_build_date", 45752.96211960639, "GM_runtime_version", "2024.11.0.227", "pointer_invalid", pointer_invalid, "pointer_null", pointer_null, "dll_stdcall", 1, "dll_cdecl", 0, "ty_real", 0, "ty_string", 1, "all", -3, "noone", -4, "infinity", infinity, "pi", pi, "display_landscape_flipped", 2, "display_portrait_flipped", 3, "display_landscape", 0, "display_portrait", 1);
    interface.exposeDynamicConstant("webgl_enabled", function()
    {
        return webgl_enabled;
    }, "fps", function()
    {
        return fps;
    }, "fps_real", function()
    {
        return fps_real;
    }, "delta_time", function()
    {
        return delta_time;
    }, "current_time", function()
    {
        return current_time;
    }, "application_surface", function()
    {
        return application_surface;
    }, "current_year", function()
    {
        return current_year;
    }, "current_month", function()
    {
        return current_month;
    }, "current_day", function()
    {
        return current_day;
    }, "current_hour", function()
    {
        return current_hour;
    }, "current_minute", function()
    {
        return current_minute;
    }, "current_second", function()
    {
        return current_second;
    }, "instance_count", function()
    {
        return instance_count;
    }, "program_directory", function()
    {
        return program_directory;
    }, "temp_directory", function()
    {
        return temp_directory;
    }, "working_directory", function()
    {
        return working_directory;
    }, "game_save_id", function()
    {
        return game_save_id;
    }, "game_project_name", function()
    {
        return game_project_name;
    }, "game_project_name", function()
    {
        return game_project_name;
    }, "game_display_name", function()
    {
        return game_display_name;
    }, "cursor_sprite", function()
    {
        return cursor_sprite;
    });
    interface.exposeDynamicConstant("keyboard_key", function()
    {
        return keyboard_key;
    }, "keyboard_lastkey", function()
    {
        return keyboard_lastkey;
    }, "keyboard_lastchar", function()
    {
        return keyboard_lastchar;
    });
    interface.exposeConstant("vk_nokey", 0, "vk_anykey", 1, "vk_enter", 13, "vk_return", 13, "vk_shift", 16, "vk_control", 17, "vk_alt", 18, "vk_escape", 27, "vk_space", 32, "vk_backspace", 8, "vk_tab", 9, "vk_pause", 19, "vk_printscreen", 44, "vk_left", 37, "vk_right", 39, "vk_up", 38, "vk_down", 40, "vk_home", 36, "vk_end", 35, "vk_delete", 46, "vk_insert", 45, "vk_pageup", 33, "vk_pagedown", 34, "vk_f1", 112, "vk_f2", 113, "vk_f3", 114, "vk_f4", 115, "vk_f5", 116, "vk_f6", 117, "vk_f7", 118, "vk_f8", 119, "vk_f9", 120, "vk_f10", 121, "vk_f11", 122, "vk_f12", 123, "vk_numpad0", 96, "vk_numpad1", 97, "vk_numpad2", 98, "vk_numpad3", 99, "vk_numpad4", 100, "vk_numpad5", 101, "vk_numpad6", 102, "vk_numpad7", 103, "vk_numpad8", 104, "vk_numpad9", 105, "vk_divide", 111, "vk_multiply", 106, "vk_subtract", 109, "vk_add", 107, "vk_decimal", 110, "vk_lshift", 160, "vk_lcontrol", 162, "vk_lalt", 164, "vk_rshift", 161, "vk_rcontrol", 163, "vk_ralt", 165);
    interface.exposeConstant("kbv_type_default", 0, "kbv_type_ascii", 1, "kbv_type_url", 2, "kbv_type_email", 3, "kbv_type_numbers", 4, "kbv_type_phone", 5, "kbv_type_phone_name", 6, "kbv_returnkey_default", 0, "kbv_returnkey_go", 1, "kbv_returnkey_google", 2, "kbv_returnkey_join", 3, "kbv_returnkey_next", 4, "kbv_returnkey_route", 5, "kbv_returnkey_search", 6, "kbv_returnkey_send", 7, "kbv_returnkey_yahoo", 8, "kbv_returnkey_done", 9, "kbv_returnkey_continue", 10, "kbv_returnkey_emergency", 11, "kbv_autocapitalize_none", 0, "kbv_autocapitalize_words", 1, "kbv_autocapitalize_sentences", 2, "kbv_autocapitalize_characters", 3);
    interface.exposeDynamicConstant("mouse_button", function()
    {
        return mouse_button;
    }, "mouse_lastbutton", function()
    {
        return mouse_lastbutton;
    }, "mouse_x", function()
    {
        return mouse_x;
    }, "mouse_y", function()
    {
        return mouse_y;
    });
    interface.exposeConstant("mb_left", 1, "mb_right", 2, "mb_any", -1, "mb_middle", 3, "mb_side1", 4, "mb_side2", 5, "mb_none", 0);
    interface.exposeConstant("cr_none", -1, "cr_default", 0, "cr_arrow", -2, "cr_cross", -3, "cr_beam", -4, "cr_size_nesw", -6, "cr_size_ns", -7, "cr_size_nwse", -8, "cr_size_we", -9, "cr_uparrow", -10, "cr_hourglass", -11, "cr_drag", -12, "cr_appstart", -19, "cr_handpoint", -21, "cr_size_all", -22);
    interface.exposeConstant("gp_face1", 32769, "gp_face2", 32770, "gp_face3", 32771, "gp_face4", 32772, "gp_shoulderl", 32773, "gp_shoulderlb", 32775, "gp_shoulderr", 32774, "gp_shoulderrb", 32776, "gp_select", 32777, "gp_start", 32778, "gp_stickl", 32779, "gp_stickr", 32780, "gp_padu", 32781, "gp_padd", 32782, "gp_padl", 32783, "gp_padr", 32784, "gp_axislh", 32785, "gp_axislv", 32786, "gp_axisrh", 32787, "gp_axisrv", 32788, "gp_axis_acceleration_x", 32789, "gp_axis_acceleration_y", 32790, "gp_axis_acceleration_z", 32791, "gp_axis_angular_velocity_x", 32792, "gp_axis_angular_velocity_y", 32793, "gp_axis_angular_velocity_z", 32794, "gp_axis_orientation_x", 32795, "gp_axis_orientation_y", 32796, "gp_axis_orientation_z", 32797, "gp_axis_orientation_w", 32798);
    interface.exposeConstant("video_format_rgba", 0, "video_format_yuv", 1, "video_status_closed", 0, "video_status_preparing", 1, "video_status_playing", 2, "video_status_paused", 3);
    interface.exposeConstant("vertex_usage_position", 1, "vertex_usage_colour", 2, "vertex_usage_color", 2, "vertex_usage_normal", 3, "vertex_usage_textcoord", 4, "vertex_usage_texcoord", 4, "vertex_usage_blendweight", 5, "vertex_usage_blendindices", 6, "vertex_usage_psize", 7, "vertex_usage_tangent", 8, "vertex_usage_binormal", 9, "vertex_usage_fog", 12, "vertex_usage_depth", 13, "vertex_usage_sample", 14, "vertex_type_float1", 1, "vertex_type_float2", 2, "vertex_type_float3", 3, "vertex_type_float4", 4, "vertex_type_colour", 5, "vertex_type_color", 5, "vertex_type_ubyte4", 6);
    interface.exposeConstant("pr_pointlist", 1, "pr_linelist", 2, "pr_linestrip", 3, "pr_trianglelist", 4, "pr_trianglestrip", 5, "pr_trianglefan", 6);
    interface.exposeConstant("buffer_fixed", 0, "buffer_grow", 1, "buffer_wrap", 2, "buffer_fast", 3, "buffer_vbuffer", 4, "buffer_u8", 1, "buffer_s8", 2, "buffer_u16", 3, "buffer_s16", 4, "buffer_u32", 5, "buffer_s32", 6, "buffer_f16", 7, "buffer_f32", 8, "buffer_f64", 9, "buffer_u64", 12, "buffer_bool", 10, "buffer_string", 11, "buffer_text", 13, "buffer_seek_start", 0, "buffer_seek_relative", 1, "buffer_seek_end", 2);
    interface.exposeConstant("ds_type_map", 1, "ds_type_list", 2, "ds_type_stack", 3, "ds_type_queue", 4, "ds_type_grid", 5, "ds_type_priority", 6);
    interface.exposeConstant("time_source_units_frames", 1, "time_source_units_seconds", 0, "time_source_global", 0, "time_source_game", 1, "time_source_units_seconds", 0, "time_source_units_frames", 1, "time_source_expire_nearest", 0, "time_source_expire_after", 1, "time_source_state_initial", 0, "time_source_state_active", 1, "time_source_state_paused", 2, "time_source_state_stopped", 3);
    interface.exposeConstant("seqplay_oneshot", 0, "seqplay_loop", 1, "seqplay_pingpong", 2, "seqdir_right", 1, "seqdir_left", -1, "seqtracktype_graphic", 1, "seqtracktype_audio", 2, "seqtracktype_real", 3, "seqtracktype_color", 4, "seqtracktype_colour", 4, "seqtracktype_bool", 5, "seqtracktype_string", 6, "seqtracktype_sequence", 7, "seqtracktype_clipmask", 8, "seqtracktype_clipmask_mask", 9, "seqtracktype_clipmask_subject", 10, "seqtracktype_group", 11, "seqtracktype_empty", 12, "seqtracktype_spriteframes", 13, "seqtracktype_instance", 14, "seqtracktype_message", 15, "seqtracktype_moment", 16, "animcurvetype_linear", 0, "animcurvetype_catmullrom", 1, "seqaudiokey_loop", 0, "seqaudiokey_oneshot", 1, "seqinterpolation_assign", 0, "seqinterpolation_lerp", 1);
    interface.exposeConstant("asset_unknown", -1, "asset_sprite", 1, "asset_object", 0, "asset_script", 5, "asset_room", 3, "asset_path", 4, "asset_sound", 2, "asset_tiles", 13, "asset_timeline", 7, "asset_font", 6, "asset_shader", 8, "asset_sequence", 9, "asset_animationcurve", 10);
    interface.exposeConstant("fa_readonly", 1, "fa_hidden", 2, "fa_sysfile", 4, "fa_volumeid", 8, "fa_directory", 16, "fa_archive", 32);
    interface.exposeConstant("nineslice_left", 0, "nineslice_top", 1, "nineslice_right", 2, "nineslice_bottom", 3, "nineslice_centre", 4, "nineslice_stretch", 0, "nineslice_repeat", 1, "nineslice_blank", 3, "nineslice_mirror", 2, "nineslice_hide", 4, "nineslice_center", 4);
    interface.exposeConstant("pt_shape_circle", 5, "pt_shape_cloud", 11, "pt_shape_disk", 1, "pt_shape_explosion", 10, "pt_shape_flare", 8, "pt_shape_line", 3, "pt_shape_pixel", 0, "pt_shape_ring", 6, "pt_shape_smoke", 12, "pt_shape_snow", 13, "pt_shape_spark", 9, "pt_shape_square", 2, "pt_shape_star", 4, "pt_shape_sphere", 7);
    interface.exposeConstant("ps_distr_linear", 0, "ps_distr_gaussian", 1, "ps_distr_invgaussian", 2, "ps_shape_rectangle", 0, "ps_shape_ellipse", 1, "ps_shape_diamond", 2, "ps_shape_line", 3);
    interface.exposeConstant("ef_cloud", 9, "ef_ellipse", 2, "ef_explosion", 0, "ef_firework", 3, "ef_flare", 8, "ef_rain", 10, "ef_ring", 1, "ef_smoke", 4, "ef_smokeup", 5, "ef_snow", 11, "ef_spark", 7, "ef_star", 6);
    interface.exposeConstant("path_action_stop", 0, "path_action_restart", 1, "path_action_continue", 2, "path_action_reverse", 3);
    interface.exposeConstant("audio_3d", 2, "audio_mono", 0, "audio_stereo", 1, "audio_falloff_none", 0, "audio_falloff_inverse_distance", 1, "audio_falloff_inverse_distance_clamped", 2, "audio_falloff_linear_distance", 3, "audio_falloff_linear_distance_clamped", 4, "audio_falloff_exponent_distance", 5, "audio_falloff_exponent_distance_clamped", 6, "audio_falloff_exponent_distance_scaled", 8);
    interface.exposeConstant("layerelementtype_undefined", 0, "layerelementtype_background", 1, "layerelementtype_instance", 2, "layerelementtype_oldtilemap", 3, "layerelementtype_sprite", 4, "layerelementtype_tilemap", 5, "layerelementtype_particlesystem", 6, "layerelementtype_tile", 7, "layerelementtype_sequence", 8);
    interface.exposeDynamicConstant("room_first", function()
    {
        return room_first;
    }, "room_last", function()
    {
        return room_last;
    }, "view_current", function()
    {
        return view_current;
    });
    interface.exposeConstant("tile_rotate", 1073741824, "tile_mirror", 268435456, "tile_flip", 536870912, "tile_index_mask", 524287);
    interface.exposeConstant("bboxmode_automatic", 0, "bboxmode_fullimage", 1, "bboxmode_manual", 2, "bboxkind_rectangular", 1, "bboxkind_ellipse", 2, "bboxkind_diamond", 3, "bboxkind_precise", 0);
    interface.exposeConstant("phy_joint_anchor_1_x", 0, "phy_joint_anchor_1_y", 1, "phy_joint_anchor_2_x", 2, "phy_joint_anchor_2_y", 3, "phy_joint_reaction_force_x", 4, "phy_joint_reaction_force_y", 5, "phy_joint_reaction_torque", 6, "phy_joint_max_motor_force", 14, "phy_joint_max_motor_torque", 10, "phy_joint_motor_force", 13, "phy_joint_motor_speed", 7, "phy_joint_motor_torque", 9, "phy_joint_angle", 8, "phy_joint_angle_limits", 21, "phy_joint_upper_angle_limit", 20, "phy_joint_lower_angle_limit", 19, "phy_joint_translation", 11, "phy_joint_speed", 12, "phy_joint_damping_ratio", 17, "phy_joint_frequency", 18, "phy_joint_length_1", 15, "phy_joint_length_2", 16, "phy_joint_max_torque", 23, "phy_joint_max_force", 24, "phy_joint_max_length", 22, "phy_particle_flag_water", 0, "phy_particle_flag_zombie", 2, "phy_particle_flag_wall", 4, "phy_particle_flag_spring", 8, "phy_particle_flag_elastic", 16, "phy_particle_flag_viscous", 32, "phy_particle_flag_powder", 64, "phy_particle_flag_tensile", 128, "phy_particle_flag_colourmixing\t", 256, "phy_particle_flag_colormixing", 256, "phy_particle_data_flag_typeflags", 1, "phy_particle_data_flag_position", 2, "phy_particle_data_flag_velocity", 4, "phy_particle_data_flag_colour", 8, "phy_particle_data_flag_color", 8, "phy_particle_data_flag_category", 16, "phy_particle_group_flag_solid", 1, "phy_particle_group_flag_rigid", 2, "phy_debug_render_aabb", 8, "phy_debug_render_collision_pairs", 64, "phy_debug_render_coms", 4, "phy_debug_render_core_shapes", 32, "phy_debug_render_joints", 2, "phy_debug_render_obb", 16, "phy_debug_render_shapes", 1);
    interface.exposeConstant("fa_left", 0, "fa_right", 2, "fa_center", 1, "fa_top", 0, "fa_middle", 1, "fa_bottom", 2);
    interface.exposeConstant("c_aqua", 16776960, "c_black", 0, "c_blue", 16711680, "c_dkgray", 4210752, "c_fuchsia", 16711935, "c_gray", 8421504, "c_green", 32768, "c_lime", 65280, "c_ltgray", 12632256, "c_maroon", 128, "c_navy", 8388608, "c_olive", 32896, "c_orange", 4235519, "c_purple", 8388736, "c_red", 255, "c_silver", 12632256, "c_teal", 8421376, "c_white", 16777215, "c_yellow", 65535);
    interface.exposeConstant("bm_normal", 0, "bm_add", 1, "bm_max", 2, "bm_subtract", 3, "bm_zero", 1, "bm_one", 2, "bm_src_color", 3, "bm_inv_src_color", 4, "bm_src_colour", 3, "bm_inv_src_colour", 4, "bm_src_alpha", 5, "bm_inv_src_alpha", 6, "bm_dest_alpha", 7, "bm_inv_dest_alpha", 8, "bm_dest_color", 9, "bm_inv_dest_color", 10, "bm_dest_colour", 9, "bm_src_alpha_sat", 11);
    interface.exposeConstant("lighttype_dir", 0, "lighttype_point", 1);
    interface.exposeConstant("cmpfunc_never", 1, "cmpfunc_less", 2, "cmpfunc_equal", 3, "cmpfunc_lessequal", 4, "cmpfunc_greater", 5, "cmpfunc_notequal", 6, "cmpfunc_greaterequal", 7, "cmpfunc_always", 8, "cull_noculling", 0, "cull_clockwise", 1, "cull_counterclockwise", 2);
    interface.exposeConstant("matrix_view", 0, "matrix_projection", 1, "matrix_world", 2);
    interface.exposeConstant("mip_markedonly", 2, "mip_on", 1, "mip_off", 0, "tf_point", 0, "tf_anisotropic", 2, "tf_linear", 1);
    interface.exposeConstant("os_windows", 0, "os_gxgames", 24, "os_macosx", 1, "os_linux", 6, "os_ios", 3, "os_android", 4, "os_tvos", 20, "os_unknown", -1, "os_ps5", 22, "os_ps4", 14, "os_xboxseriesxs", 23, "os_gdk", 23, "os_switch", 21, "os_operagx", 24, "browser_chrome", 3, "browser_safari", 4, "browser_safari_mobile", 5, "browser_firefox", 2, "browser_ie", 1, "browser_edge", 11, "browser_windows_store", 8, "browser_ie_mobile", 10, "browser_opera", 6, "browser_not_a_browser", -1, "browser_unknown", 0, "device_emulator", 256, "device_ios_ipad_retina", 3, "device_ios_ipad", 2, "device_ios_iphone6", 5, "device_ios_iphone6plus", 6, "device_ios_iphone5", 4, "device_ios_iphone", 0, "device_ios_iphone_retina", 1, "device_tablet", 2, "device_ios_unknown", -1, "os_permission_granted", 1, "os_permission_denied", 0, "os_permission_denied_dont_request", -1);
    interface.exposeDynamicConstant("os_browser", function()
    {
        return -1;
    }, "os_version", function()
    {
        return os_version;
    }, "os_device", function()
    {
        return os_device;
    }, "os_type", function()
    {
        return 0;
    });
    interface.exposeDynamicConstant("event_type", function()
    {
        return event_type;
    }, "event_number", function()
    {
        return event_number;
    }, "async_load", function()
    {
        return async_load;
    }, "event_data", function()
    {
        return event_data;
    });
    interface.exposeConstant("ev_create", 0, "ev_no_more_lives", 6, "ev_no_more_health", 9, "ev_gesture", 13, "ev_gesture_double_tap", 1, "ev_gesture_drag_end", 4, "ev_gesture_drag_start", 2, "ev_gesture_dragging", 3, "ev_gesture_tap", 0, "ev_gesture_rotating", 11, "ev_gesture_rotate_end", 12, "ev_gesture_rotate_start", 10, "ev_gesture_flick", 5, "ev_gesture_pinch_start", 6, "ev_gesture_pinch_in", 7, "ev_gesture_pinch_out", 8, "ev_gesture_pinch_end", 9, "ev_global_gesture_double_tap", 65, "ev_global_gesture_drag_end", 68, "ev_global_gesture_drag_start", 66, "ev_global_gesture_dragging", 67, "ev_global_gesture_tap", 64, "ev_global_gesture_rotating", 75, "ev_global_gesture_rotate_end", 76, "ev_global_gesture_rotate_start", 74, "ev_global_gesture_flick", 69, "ev_global_gesture_pinch_start", 70, "ev_global_gesture_pinch_in", 71, "ev_global_gesture_pinch_out", 72, "ev_global_gesture_pinch_end", 73, "ev_destroy", 1, "ev_step", 3, "ev_alarm", 2, "ev_keyboard", 5, "ev_mouse", 6, "ev_collision", 4, "ev_other", 7, "ev_draw", 8, "ev_keypress", 9, "ev_keyrelease", 10, "ev_cleanup", 12, "ev_gesture", 13, "ev_room_end", 5, "ev_room_start", 4, "ev_game_end", 3, "ev_game_start", 2, "ev_pre_create", 14, "ev_left_button", 0, "ev_right_button", 1, "ev_middle_button", 2, "ev_no_button", 3, "ev_left_press", 4, "ev_right_press", 5, "ev_middle_press", 6, "ev_left_release", 7, "ev_right_release", 8, "ev_middle_release", 9, "ev_mouse_enter", 10, "ev_mouse_leave", 11, "ev_global_left_press", 53, "ev_global_right_press", 54, "ev_global_left_release", 56, "ev_global_right_release", 57, "ev_global_left_button", 50, "ev_global_right_button", 51, "ev_global_middle_press", 55, "ev_global_middle_release", 58, "ev_global_middle_button", 52, "ev_draw_begin", 72, "ev_draw_end", 73, "ev_draw_pre", 76, "ev_draw_post", 77, "ev_gui_begin", 74, "ev_gui_end", 75, "ev_gui", 64, "ev_user0", 10, "ev_user1", 11, "ev_user2", 12, "ev_user3", 13, "ev_user4", 14, "ev_user5", 15, "ev_user6", 16, "ev_user7", 17, "ev_user8", 18, "ev_user9", 19, "ev_user10", 20, "ev_user11", 21, "ev_user12", 22, "ev_user13", 23, "ev_user14", 24, "ev_user15", 25, "ev_animation_end", 7, "ev_end_of_path", 8, "ev_outside", 0, "ev_boundary", 1, "ev_mouse_wheel_down", 61, "ev_mouse_wheel_up", 60, "ev_outside_view0", 40, "ev_outside_view1", 41, "ev_outside_view2", 42, "ev_outside_view3", 43, "ev_outside_view4", 44, "ev_outside_view5", 45, "ev_outside_view6", 46, "ev_outside_view7", 47, "ev_boundary_view0", 50, "ev_boundary_view1", 51, "ev_boundary_view2", 52, "ev_boundary_view3", 53, "ev_boundary_view4", 54, "ev_boundary_view5", 55, "ev_boundary_view6", 56, "ev_boundary_view7", 57, "ev_collision", 4, "ev_broadcast_message", 76, "ev_step_normal", 0, "ev_step_begin", 1, "ev_step_end", 2);
    interface.exposeConstant("ev_async_system_event", 75, "ev_async_push_notification", 71, "ev_async_web_iap", 66, "ev_async_social", 70, "ev_async_web", 62, "ev_async_web_cloud", 67, "ev_async_web_image_load", 60, "ev_async_web_networking", 68, "ev_async_web_steam", 69, "ev_async_audio_playback", 74, "ev_async_audio_recording", 73, "ev_async_dialog", 63, "ev_async_save_load", 72);
    interface.exposeConstant("network_send_binary", 1, "network_send_text", 2, "network_socket_tcp", 0, "network_socket_udp", 1, "network_socket_ws", 6, "network_socket_bluetooth", 2, "network_config_connect_timeout", 0, "network_config_use_non_blocking_socket", 1, "network_config_enable_reliable_udp", 2, "network_config_disable_reliable_udp", 3, "network_config_avoid_time_wait", 4, "network_config_websocket_protocol", 5, "network_connect_none", 0, "network_connect_blocking", 1, "network_connect_nonblocking", 2, "network_type_down", 7, "network_type_up_failed", 6, "network_type_up", 5, "network_type_non_blocking_connect", 4, "network_type_data", 3, "network_type_connect", 1, "network_type_disconnect", 2);
    
    try
    {
        __AudioLFOType.InvSawtooth = UnknownEnum.Value_0;
        __AudioLFOType.Sawtooth = UnknownEnum.Value_1;
        __AudioLFOType.Sine = UnknownEnum.Value_2;
        __AudioLFOType.Square = UnknownEnum.Value_3;
        __AudioLFOType.Triangle = UnknownEnum.Value_4;
        interface.exposeConstant("AudioLFOType", __AudioLFOType);
    }
    catch (_)
    {
        __gmlspeak_log("New Audio Effects unavailable! Skipping...");
    }
    
    try
    {
        __AudioEffectTypeStruct.Bitcrusher = UnknownEnum.Value_0;
        __AudioEffectTypeStruct.Delay = UnknownEnum.Value_1;
        __AudioEffectTypeStruct.Gain = UnknownEnum.Value_2;
        __AudioEffectTypeStruct.HPF2 = UnknownEnum.Value_3;
        __AudioEffectTypeStruct.LPF2 = UnknownEnum.Value_4;
        __AudioEffectTypeStruct.Reverb1 = UnknownEnum.Value_5;
        __AudioEffectTypeStruct.EQ = UnknownEnum.Value_10;
        __AudioEffectTypeStruct.LoShelf = UnknownEnum.Value_9;
        __AudioEffectTypeStruct.HiShelf = UnknownEnum.Value_8;
        __AudioEffectTypeStruct.PeakEQ = UnknownEnum.Value_7;
        __AudioEffectTypeStruct.Tremolo = UnknownEnum.Value_6;
        __AudioEffectTypeStruct.Compressor = UnknownEnum.Value_11;
        interface.exposeConstant("AudioEffectType", __AudioEffectTypeStruct, "audio_bus_main", audio_bus_main);
    }
    catch (_)
    {
        __gmlspeak_log("Audio Bus & Effects are unavailable! Skipping...");
    }
    
    try
    {
        interface.exposeConstant("ev_draw_normal", 0);
    }
    catch (_)
    {
        __gmlspeak_log("ev_draw_normal not available! Skipping...");
    }
    
    try
    {
        interface.exposeConstant("sprite_add_ext_error_unknown", -1, "sprite_add_ext_error_cancelled", -2, "sprite_add_ext_error_spritenotfound", -3, "sprite_add_ext_error_loadfailed", -4, "sprite_add_ext_error_decompressfailed", -5, "sprite_add_ext_error_setupfailed", -6);
    }
    catch (_)
    {
        __gmlspeak_log("sprite_add_ext not available! Skipping...");
    }
    
    try
    {
        interface.exposeConstant("asset_particlesystem", 11, "layerelementtype_particlesystem", 6);
    }
    catch (_)
    {
        __gmlspeak_log("Particle System Asset not available! Skipping...");
    }
    
    try
    {
        interface.exposeConstant("textalign_left", 0, "textalign_right", 2, "textalign_center", 1, "textalign_justify", 3, "textalign_top", 0, "textalign_bottom", 2, "textalign_middle", 1);
    }
    catch (_)
    {
        __gmlspeak_log("Text Asset not available! Skipping...");
    }
    
    try
    {
        interface.exposeConstant("surface_rgba8unorm", 6, "surface_r8unorm", 12, "surface_rg8unorm", 13, "surface_rgba4unorm", 11, "surface_rgba16float", 14, "surface_r16float", 9, "surface_rgba32float", 15, "surface_r32float", 10);
    }
    catch (_)
    {
        __gmlspeak_log("Surface formats not available! Skipping...");
    }
    
    try
    {
        interface.exposeConstant("tm_systemtiming", 2);
    }
    catch (_)
    {
        __gmlspeak_log("tm_systemtiming not available! Skipping...");
    }
    
    try
    {
        interface.exposeDynamicConstant("GM_is_sandboxed", function()
        {
            return true;
        });
    }
    catch (_)
    {
        __gmlspeak_log("GM_is_sandboxed not available! Skipping...");
    }
    
    try
    {
        interface.exposeConstant("bm_eq_add", 1, "bm_eq_subtract", 3, "bm_eq_max", 2, "bm_eq_min", 4, "bm_eq_reverse_subtract", 5);
    }
    catch (_)
    {
        __gmlspeak_log("Blendmode Equations not available! Skipping...");
    }
    
    try
    {
        interface.exposeConstant("stencilop_keep", 1, "stencilop_zero", 2, "stencilop_replace", 3, "stencilop_incr_wrap", 4, "stencilop_decr_wrap", 5, "stencilop_invert", 6, "stencilop_incr", 7, "stencilop_decr", 8);
    }
    catch (_)
    {
        __gmlspeak_log("Stencil Operations not available! Skipping...");
    }
    
    try
    {
        interface.exposeConstant("gp_home", 32799, "gp_extra1", 32800, "gp_extra2", 32801, "gp_extra3", 32802, "gp_extra4", 32803, "gp_extra5", 32809, "gp_extra6", 32810, "gp_paddler", 32804, "gp_paddlel", 32805, "gp_paddlerb", 32806, "gp_paddlelb", 32807, "gp_touchpadbutton", 32808);
    }
    catch (_)
    {
        __gmlspeak_log("New gamepad constants not available! Skipping...");
    }
    
    try
    {
        var _flexpanelUnit = 
        {
            point: UnknownEnum.Value_1,
            percent: UnknownEnum.Value_2,
            auto: UnknownEnum.Value_3
        };
        var _flexpanelPositionType = 
        {
            relative: UnknownEnum.Value_1,
            absolute: UnknownEnum.Value_2
        };
        var _flexpanelJustify = 
        {
            start: UnknownEnum.Value_0,
            center: UnknownEnum.Value_1,
            flex_end: UnknownEnum.Value_2,
            space_between: UnknownEnum.Value_3,
            space_around: UnknownEnum.Value_4,
            space_evenly: UnknownEnum.Value_5
        };
        var _flexpanelDirection = 
        {
            inherit: UnknownEnum.Value_0,
            LTR: UnknownEnum.Value_1,
            RTL: UnknownEnum.Value_2
        };
        var _flexPanelGutter = 
        {
            column: UnknownEnum.Value_0,
            row: UnknownEnum.Value_1,
            all_gutters: UnknownEnum.Value_2
        };
        var _flexpanelDisplay = 
        {
            flex: UnknownEnum.Value_0,
            none: UnknownEnum.Value_1
        };
        var _flexpanelFlexDirection = 
        {
            column: UnknownEnum.Value_0,
            column_reverse: UnknownEnum.Value_1,
            row: UnknownEnum.Value_2,
            row_reverse: UnknownEnum.Value_3
        };
        var _flexpanelAlign = 
        {
            auto: UnknownEnum.Value_0,
            flex_start: UnknownEnum.Value_1,
            center: UnknownEnum.Value_2,
            flex_end: UnknownEnum.Value_3,
            stretch: UnknownEnum.Value_4,
            baseline: UnknownEnum.Value_5,
            space_between: UnknownEnum.Value_6,
            space_around: UnknownEnum.Value_7,
            space_evenly: UnknownEnum.Value_8
        };
        var _flexpanelWrap = 
        {
            no_wrap: UnknownEnum.Value_0,
            wrap: UnknownEnum.Value_1,
            reverse: UnknownEnum.Value_2
        };
        var _flexpanelEdge = 
        {
            left: UnknownEnum.Value_0,
            top: UnknownEnum.Value_1,
            right: UnknownEnum.Value_2,
            bottom: UnknownEnum.Value_3,
            start: UnknownEnum.Value_4,
            horizontal: UnknownEnum.Value_6,
            vertical: UnknownEnum.Value_7,
            all_edges: UnknownEnum.Value_8
        };
        interface.exposeConstant("flexpanel_unit", _flexpanelUnit, "flexpanel_position_type", _flexpanelPositionType, "flexpanel_justify", _flexpanelJustify, "flexpanel_direction", _flexpanelDirection, "flexpanel_gutter", _flexPanelGutter, "flexpanel_display", _flexpanelDisplay, "flexpanel_flex_direction", _flexpanelFlexDirection, "flexpanel_align", _flexpanelAlign, "flexpanel_wrap", _flexpanelWrap, "flexpanel_edge", _flexpanelEdge);
    }
    catch (_)
    {
        __gmlspeak_log("Flexpanel constants not available! Skipping...");
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_18 = 18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_27,
    Value_28,
    Value_29,
    Value_30,
    Value_31,
    Value_32,
    Value_33,
    Value_34,
    Value_35,
    Value_36,
    Value_37,
    Value_38,
    Value_42 = 42,
    Value_57 = 57,
    Value_58,
    Value_59,
    Value_61 = 61,
    Value_62,
    Value_64 = 64,
    Value_65,
    Value_66,
    Value_69 = 69,
    Value_70,
    Value_71,
    Value_72,
    Value_73,
    Value_74,
    Value_75,
    Value_76,
    Value_77,
    Value_78,
    Value_79,
    Value_81 = 81,
    Value_82,
    Value_83,
    Value_84,
    Value_86 = 86,
    Value_87,
    Value_88,
    Value_89,
    Value_90,
    Value_91,
    Value_92,
    Value_93,
    Value_95 = 95,
    Value_96,
    Value_97,
    Value_98,
    Value_99,
    Value_101 = 101
}
