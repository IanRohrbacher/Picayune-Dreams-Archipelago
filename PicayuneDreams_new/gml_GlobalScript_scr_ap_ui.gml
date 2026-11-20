function ap_ui_hover(x1, y1, x2, y2)
{
    return point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x1, y1, x2, y2);
}

function ap_ui_trim(text)
{
    while (string_length(text) > 0 && string_char_at(text, 1) == " ")
        text = string_delete(text, 1, 1);

    while (string_length(text) > 0 && string_char_at(text, string_length(text)) == " ")
        text = string_delete(text, string_length(text), 1);

    return text;
}

function ap_ui_green()
{
    return make_color_rgb(0, 176, 0);
}

function ap_ui_dim()
{
    return make_color_rgb(0, 96, 0);
}

function ap_ui_backdrop(x1, y1, x2, y2, alpha)
{
    draw_set_alpha(alpha);
    draw_set_color(c_black);
    draw_rectangle(x1, y1, x2, y2, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}


function ap_ui_nine(x1, y1, x2, y2, alpha)
{
    var spr = global.sprites.spr_credits_box;
    var px = 134;
    var py = 172;
    var pw = 467;
    var ph = 229;
    var w = x2 - x1 + 1;
    var h = y2 - y1 + 1;
    var m = min(23, floor((w - 1) / 2));
    var top = 4;
    var bottom = 2;
    var mid_w = w - (m * 2);
    var mid_h = h - top - bottom;
    var right_px = px + pw - m;
    var bottom_py = py + ph - bottom;
    var mid_px = px + m;
    var mid_py = py + top;

    draw_sprite_part_ext(spr, 0, px, mid_py, m, 1, x1, y1 + top, 1, mid_h, c_white, alpha);
    draw_sprite_part_ext(spr, 0, right_px, mid_py, m, 1, x2 - m + 1, y1 + top, 1, mid_h, c_white, alpha);
    draw_sprite_part_ext(spr, 0, mid_px, mid_py, 1, 1, x1 + m, y1 + top, mid_w, mid_h, c_white, alpha);
    draw_sprite_part_ext(spr, 0, mid_px, py, 1, top, x1 + m, y1, mid_w, 1, c_white, alpha);
    draw_sprite_part_ext(spr, 0, mid_px, bottom_py, 1, bottom, x1 + m, y2 - bottom + 1, mid_w, 1, c_white, alpha);
    draw_sprite_part_ext(spr, 0, px, py, m, top, x1, y1, 1, 1, c_white, alpha);
    draw_sprite_part_ext(spr, 0, right_px, py, m, top, x2 - m + 1, y1, 1, 1, c_white, alpha);
    draw_sprite_part_ext(spr, 0, px, bottom_py, m, bottom, x1, y2 - bottom + 1, 1, 1, c_white, alpha);
    draw_sprite_part_ext(spr, 0, right_px, bottom_py, m, bottom, x2 - m + 1, y2 - bottom + 1, 1, 1, c_white, alpha);
}

function ap_ui_panel(x1, y1, x2, y2, alpha, border)
{
    ap_ui_nine(x1, y1, x2, y2, alpha);

    if (border == c_lime)
    {
        draw_set_alpha(0.18);
        draw_set_color(c_lime);
        draw_rectangle(x1 + 2, y1 + 2, x2 - 2, y2 - 2, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}

function ap_ui_text(x, y, text, color, halign)
{
    draw_set_halign(halign);
    draw_set_valign(fa_middle);
    draw_set_color(color);
    draw_text(x, y, text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

function ap_ui_heading(x, y, text)
{
    var width = string_width(text) * 2;
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(ap_ui_green());
    draw_text_transformed(x, y, text, 2, 2, 0);
    draw_rectangle(x - (width / 2), y + 17, x + (width / 2), y + 18, false);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

function ap_ui_button(x1, y1, x2, y2, label, base)
{
    var hover = ap_ui_hover(x1, y1, x2, y2);
    var tone = (base >= 100) ? ap_ui_green() : ap_ui_dim();
    ap_ui_panel(x1, y1, x2, y2, (base >= 100) ? 1 : 0.65, hover ? c_lime : tone);
    ap_ui_text((x1 + x2) / 2, ((y1 + y2) / 2) + 3, label, hover ? c_lime : tone, fa_center);
    return hover && mouse_check_button_pressed(mb_left);
}

function ap_ui_field(x1, y1, x2, y2, text, focused, masked)
{
    var hover = ap_ui_hover(x1, y1, x2, y2);
    ap_ui_nine(x1, y1, x2, y2, 1);
    draw_set_alpha(0.45);
    draw_set_color(c_black);
    draw_rectangle(x1 + 2, y1 + 2, x2 - 2, y2 - 2, false);
    draw_set_alpha(1);

    if (focused)
    {
        draw_set_color(c_lime);
        draw_rectangle(x1 + 2, y1 + 2, x2 - 2, y2 - 2, true);
    }

    draw_set_color(c_white);

    if (text == "")
    {
        ap_ui_text(x1 + 10, ((y1 + y2) / 2) + 3, "Enter text...", ap_ui_dim(), fa_left);
    }
    else
    {
        var shown = text;

        if (masked)
        {
            shown = "";

            for (var i = 0; i < string_length(text); i += 1)
                shown += "*";
        }

        if (focused && (floor(current_time / 500) % 2) == 0)
            shown += "|";

        while (string_width(shown) > (x2 - x1) - 20 && string_length(shown) > 1)
            shown = string_delete(shown, 1, 1);

        ap_ui_text(x1 + 10, ((y1 + y2) / 2) + 3, shown, c_lime, fa_left);
    }

    return hover && mouse_check_button_pressed(mb_left);
}

function ap_ui_status()
{
    var status = "Not Connected";
    var status_color = c_red;

    if (global.ap_connect_state == 2)
    {
        status = "Connected";
        status_color = c_lime;
    }
    else if (global.ap_connect_state == 4)
    {
        status = "Debug Bypass";
        status_color = c_yellow;
    }

    ap_ui_text(958, 10, status, status_color, fa_right);
    ap_ui_text(958 - string_width(status) - 6, 10, "Archipelago Status:", ap_ui_green(), fa_right);

    if (global.ap_error != "" && global.ap_connect_state != 2 && global.ap_connect_state != 4)
        ap_ui_text(958, 45, global.ap_error, c_red, fa_right);
}
