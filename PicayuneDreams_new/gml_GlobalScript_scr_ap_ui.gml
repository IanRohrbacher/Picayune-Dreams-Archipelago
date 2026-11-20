function ap_ui_hover(x1, y1, x2, y2)
{
    var my = device_mouse_y_to_gui(0);

    if (global.ap_ui_captured || my < global.ap_ui_clip_y1 || my > global.ap_ui_clip_y2)
        return false;

    return point_in_rectangle(device_mouse_x_to_gui(0), my, x1, y1, x2, y2);
}

function ap_ui_trim(text)
{
    while (string_length(text) > 0 && string_char_at(text, 1) == " ")
        text = string_delete(text, 1, 1);

    while (string_length(text) > 0 && string_char_at(text, string_length(text)) == " ")
        text = string_delete(text, string_length(text), 1);

    return text;
}

function ap_ui_clean(text)
{
    var result = "";

    for (var i = 1; i <= string_length(text); i += 1)
    {
        var ch = string_char_at(text, i);

        if (ord(ch) >= 32 && ord(ch) != 127)
            result += ch;
    }

    return result;
}

function ap_ui_repeat(timers, key)
{
    var name = string(key);
    var held = variable_struct_exists(timers, name) ? variable_struct_get(timers, name) : 0;

    if (keyboard_check_pressed(key))
    {
        variable_struct_set(timers, name, 0);
        return true;
    }

    if (keyboard_check(key))
    {
        held += 1;
        variable_struct_set(timers, name, held);
        return held > 18 && ((held - 18) % 3) == 0;
    }

    return false;
}

function ap_ui_word_char(ch)
{
    return string_letters(ch) != "" || string_digits(ch) != "" || ch == "_";
}

function ap_ui_word_left(text, pos)
{
    while (pos > 0 && !ap_ui_word_char(string_char_at(text, pos)))
        pos -= 1;

    while (pos > 0 && ap_ui_word_char(string_char_at(text, pos)))
        pos -= 1;

    return pos;
}

function ap_ui_word_right(text, pos)
{
    var length = string_length(text);

    while (pos < length && ap_ui_word_char(string_char_at(text, pos + 1)))
        pos += 1;

    while (pos < length && !ap_ui_word_char(string_char_at(text, pos + 1)))
        pos += 1;

    return pos;
}

function ap_ui_edit_push(edit, text, kind)
{
    if (kind == "other" || edit.kind != kind)
    {
        array_push(edit.undo, { text: text, caret: edit.caret, anchor: edit.anchor });

        if (array_length(edit.undo) > 100)
            array_delete(edit.undo, 0, 1);

        edit.redo = [];
    }

    edit.kind = kind;
}

function ap_ui_edit_undo(edit, text)
{
    if (array_length(edit.undo) == 0)
        return text;

    array_push(edit.redo, { text: text, caret: edit.caret, anchor: edit.anchor });
    var snap = array_pop(edit.undo);
    edit.caret = snap.caret;
    edit.anchor = snap.anchor;
    edit.kind = "";
    return snap.text;
}

function ap_ui_edit_redo(edit, text)
{
    if (array_length(edit.redo) == 0)
        return text;

    array_push(edit.undo, { text: text, caret: edit.caret, anchor: edit.anchor });
    var snap = array_pop(edit.redo);
    edit.caret = snap.caret;
    edit.anchor = snap.anchor;
    edit.kind = "";
    return snap.text;
}

function ap_ui_edit(edit, text, max_length, digits_only, timers)
{
    var length = string_length(text);
    edit.caret = clamp(edit.caret, 0, length);
    edit.anchor = clamp(edit.anchor, 0, length);
    var ctrl = keyboard_check(vk_control);
    var shift = keyboard_check(vk_shift);
    var typed = ap_ui_clean(keyboard_string);
    keyboard_string = "";
    var pasted = false;

    if (ctrl && keyboard_check_pressed(ord("Z")) && !shift)
        return ap_ui_edit_undo(edit, text);

    if (ctrl && (keyboard_check_pressed(ord("Y")) || (shift && keyboard_check_pressed(ord("Z")))))
        return ap_ui_edit_redo(edit, text);

    if (ctrl && keyboard_check_pressed(ord("A")))
    {
        edit.anchor = 0;
        edit.caret = length;
        edit.kind = "";
    }

    var lo = min(edit.caret, edit.anchor);
    var hi = max(edit.caret, edit.anchor);

    if (ctrl && hi > lo && (keyboard_check_pressed(ord("C")) || keyboard_check_pressed(ord("X"))))
    {
        clipboard_set_text(string_copy(text, lo + 1, hi - lo));

        if (keyboard_check_pressed(ord("X")))
        {
            ap_ui_edit_push(edit, text, "other");
            text = string_delete(text, lo + 1, hi - lo);
            edit.caret = lo;
            edit.anchor = lo;
            hi = lo;
        }
    }

    if (ctrl && keyboard_check_pressed(ord("V")))
    {
        typed += ap_ui_clean(clipboard_get_text());
        pasted = true;
    }

    if (digits_only)
        typed = string_digits(typed);

    if (typed != "")
    {
        lo = min(edit.caret, edit.anchor);
        hi = max(edit.caret, edit.anchor);
        ap_ui_edit_push(edit, text, (pasted || hi > lo || string_length(typed) > 1) ? "other" : "type");
        text = string_delete(text, lo + 1, hi - lo);
        typed = string_copy(typed, 1, max(0, max_length - string_length(text)));
        text = string_insert(typed, text, lo + 1);
        edit.caret = lo + string_length(typed);
        edit.anchor = edit.caret;
    }

    if (ap_ui_repeat(timers, vk_backspace))
    {
        lo = min(edit.caret, edit.anchor);
        hi = max(edit.caret, edit.anchor);

        if (hi > lo)
        {
            ap_ui_edit_push(edit, text, "other");
            text = string_delete(text, lo + 1, hi - lo);
            edit.caret = lo;
            edit.anchor = lo;
        }
        else if (edit.caret > 0)
        {
            var from = ctrl ? ap_ui_word_left(text, edit.caret) : edit.caret - 1;
            ap_ui_edit_push(edit, text, ctrl ? "other" : "back");
            text = string_delete(text, from + 1, edit.caret - from);
            edit.caret = from;
            edit.anchor = from;
        }
    }

    if (ap_ui_repeat(timers, vk_delete))
    {
        lo = min(edit.caret, edit.anchor);
        hi = max(edit.caret, edit.anchor);

        if (hi > lo)
        {
            ap_ui_edit_push(edit, text, "other");
            text = string_delete(text, lo + 1, hi - lo);
            edit.caret = lo;
            edit.anchor = lo;
        }
        else if (edit.caret < string_length(text))
        {
            var to = ctrl ? ap_ui_word_right(text, edit.caret) : edit.caret + 1;
            ap_ui_edit_push(edit, text, ctrl ? "other" : "del");
            text = string_delete(text, edit.caret + 1, to - edit.caret);
            edit.anchor = edit.caret;
        }
    }

    var left = ap_ui_repeat(timers, vk_left);
    var right = ap_ui_repeat(timers, vk_right);

    if (left || right)
    {
        lo = min(edit.caret, edit.anchor);
        hi = max(edit.caret, edit.anchor);
        var target = edit.caret;

        if (ctrl)
            target = left ? ap_ui_word_left(text, edit.caret) : ap_ui_word_right(text, edit.caret);
        else if (!shift && hi > lo)
            target = left ? lo : hi;
        else
            target = clamp(edit.caret + (left ? -1 : 1), 0, string_length(text));

        edit.caret = target;
        edit.kind = "";

        if (!shift)
            edit.anchor = target;
    }

    if (keyboard_check_pressed(vk_home))
    {
        edit.caret = 0;
        edit.kind = "";

        if (!shift)
            edit.anchor = 0;
    }

    if (keyboard_check_pressed(vk_end))
    {
        edit.caret = string_length(text);
        edit.kind = "";

        if (!shift)
            edit.anchor = edit.caret;
    }

    return text;
}

function ap_ui_index_at(shown, ofs, mx)
{
    var best = ofs;
    var best_dist = 1000000;

    for (var c = ofs; c <= string_length(shown); c += 1)
    {
        var dist = abs(mx - string_width(string_copy(shown, ofs + 1, c - ofs)));

        if (dist < best_dist)
        {
            best_dist = dist;
            best = c;
        }
    }

    return best;
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

function ap_ui_part(spr, sx, sy, sw, sh, dx, dy, xs, ys, alpha, cy1, cy2)
{
    var dh = sh * ys;
    var top_cut = max(0, cy1 - dy);
    var bottom_cut = max(0, (dy + dh - 1) - cy2);

    if (top_cut + bottom_cut >= dh)
        return;

    if (ys == 1)
        draw_sprite_part_ext(spr, 0, sx, sy + top_cut, sw, sh - top_cut - bottom_cut, dx, dy + top_cut, xs, 1, c_white, alpha);
    else
        draw_sprite_part_ext(spr, 0, sx, sy, sw, sh, dx, dy + top_cut, xs, ys - top_cut - bottom_cut, c_white, alpha);
}

function ap_ui_nine_clipped(x1, y1, x2, y2, alpha, cy1, cy2)
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

    ap_ui_part(spr, px, mid_py, m, 1, x1, y1 + top, 1, mid_h, alpha, cy1, cy2);
    ap_ui_part(spr, right_px, mid_py, m, 1, x2 - m + 1, y1 + top, 1, mid_h, alpha, cy1, cy2);
    ap_ui_part(spr, mid_px, mid_py, 1, 1, x1 + m, y1 + top, mid_w, mid_h, alpha, cy1, cy2);
    ap_ui_part(spr, mid_px, py, 1, top, x1 + m, y1, mid_w, 1, alpha, cy1, cy2);
    ap_ui_part(spr, mid_px, bottom_py, 1, bottom, x1 + m, y2 - bottom + 1, mid_w, 1, alpha, cy1, cy2);
    ap_ui_part(spr, px, py, m, top, x1, y1, 1, 1, alpha, cy1, cy2);
    ap_ui_part(spr, right_px, py, m, top, x2 - m + 1, y1, 1, 1, alpha, cy1, cy2);
    ap_ui_part(spr, px, bottom_py, m, bottom, x1, y2 - bottom + 1, 1, 1, alpha, cy1, cy2);
    ap_ui_part(spr, right_px, bottom_py, m, bottom, x2 - m + 1, y2 - bottom + 1, 1, 1, alpha, cy1, cy2);
}

function ap_ui_nine(x1, y1, x2, y2, alpha)
{
    ap_ui_nine_clipped(x1, y1, x2, y2, alpha, y1, y2);
}

function ap_ui_border(x1, y1, x2, y2)
{
    draw_set_color(make_color_rgb(18, 255, 0));
    draw_rectangle(x1, y1, x2, y2, true);
    draw_set_color(make_color_rgb(12, 166, 0));
    draw_rectangle(x1 + 1, y1 + 1, x2 - 1, y2 - 1, true);
    draw_set_color(c_white);
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

function ap_ui_field(x1, y1, x2, y2, text, focused, masked, edit)
{
    var hover = ap_ui_hover(x1, y1, x2, y2);
    var clicked = hover && mouse_check_button_pressed(mb_left);
    var shown = text;

    if (masked)
    {
        shown = "";

        for (var i = 0; i < string_length(text); i += 1)
            shown += "*";
    }

    var avail = (x2 - x1) - 20;
    var length = string_length(shown);
    var ofs = focused ? edit.ofs : 0;
    var caret = 0;
    var mx = device_mouse_x_to_gui(0) - (x1 + 10);

    if (clicked)
    {
        var best = ap_ui_index_at(shown, ofs, mx);
        var is_double = focused && (current_time - edit.click_time) < 350 && edit.click_index == best;
        edit.caret = best;

        if (!(focused && keyboard_check(vk_shift)))
            edit.anchor = best;

        edit.ofs = ofs;
        edit.dragging = true;
        edit.kind = "";
        edit.click_time = current_time;
        edit.click_index = best;

        if (is_double)
        {
            var lo = best;
            var hi = best;

            if (masked)
            {
                lo = 0;
                hi = length;
            }
            else
            {
                while (lo > 0 && ap_ui_word_char(string_char_at(text, lo)))
                    lo -= 1;

                while (hi < length && ap_ui_word_char(string_char_at(text, hi + 1)))
                    hi += 1;
            }

            edit.anchor = lo;
            edit.caret = hi;
            edit.dragging = false;
        }
    }
    else if (focused && edit.dragging)
    {
        if (mouse_check_button(mb_left))
        {
            if (mx < 0)
                edit.caret = max(0, edit.caret - 1);
            else if (mx > avail)
                edit.caret = min(length, edit.caret + 1);
            else
                edit.caret = ap_ui_index_at(shown, ofs, mx);
        }
        else
        {
            edit.dragging = false;
        }
    }

    if (focused)
    {
        caret = clamp(edit.caret, 0, length);
        ofs = min(ofs, caret);

        while (ofs < caret && string_width(string_copy(shown, ofs + 1, caret - ofs)) > avail)
            ofs += 1;

        edit.ofs = ofs;
    }

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
    var cy = ((y1 + y2) / 2) + 3;

    if (focused && edit.anchor != edit.caret)
    {
        var sel_lo = clamp(min(edit.caret, edit.anchor), ofs, length);
        var sel_hi = clamp(max(edit.caret, edit.anchor), ofs, length);
        var hx1 = x1 + 10 + string_width(string_copy(shown, ofs + 1, sel_lo - ofs));
        var hx2 = min(x1 + 10 + string_width(string_copy(shown, ofs + 1, sel_hi - ofs)), x1 + 10 + avail);
        draw_set_alpha(0.4);
        draw_set_color(c_lime);
        draw_rectangle(hx1, cy - 10, hx2, cy + 9, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }

    if (text == "")
    {
        ap_ui_text(x1 + 10, cy, "Enter text...", ap_ui_dim(), fa_left);
    }
    else
    {
        var clipped = string_copy(shown, ofs + 1, length - ofs);

        while (string_length(clipped) > 1 && string_width(clipped) > avail)
            clipped = string_delete(clipped, string_length(clipped), 1);

        ap_ui_text(x1 + 10, cy, clipped, c_lime, fa_left);
    }

    if (focused && edit.anchor == edit.caret && (floor(current_time / 500) % 2) == 0)
    {
        var cx = x1 + 10 + string_width(string_copy(shown, ofs + 1, caret - ofs));
        draw_set_color(c_lime);
        draw_rectangle(cx, cy - 9, cx + 1, cy + 9, false);
        draw_set_color(c_white);
    }

    return clicked;
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
