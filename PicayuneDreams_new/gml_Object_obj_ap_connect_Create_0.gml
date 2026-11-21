// obj_view draws the settings menu, so the room needs one.
if (!instance_exists(obj_view))
    instance_create_layer(0, 0, "Overlay", obj_view);

ap_client_init();
max_length = 64;
state = "list";
fields = ["", "archipelago.gg", "38281", "", ""];
focus = -1;
// Text editing state shared by the focused box (see ap_ui_edit).
edit = { caret: 0, anchor: 0, ofs: 0, dragging: false, click_time: -1000, click_index: -1, kind: "", undo: [], redo: [] };
key_timers = {};
scroll_px = 0;
scroll_target = 0;
dragging = false;
drag_offset = 0;
// Off-screen picture of the slot list, so cards are cut cleanly at the inner frame.
list_surface = -1;
// Hover is blocked during drags and outside the clip rows (see ap_ui_hover).
global.ap_ui_captured = false;
global.ap_ui_clip_y1 = -100000;
global.ap_ui_clip_y2 = 100000;
delete_armed = "";
pending_key = "";
editing = false;
connecting_timer = 0;
slots = [];
infos = [];

// The list shows one card per slot plus the New Game card in a 356 px view and scrolls.
card_h = 116;
card_gap = 8;
card_pitch = card_h + card_gap;

// Largest scroll offset; 0 when every card fits.
scroll_limit = function()
{
    return max(0, ((array_length(infos) + 1) * card_pitch) - card_gap - 356);
};

// Rereads the slot files and keeps the scroll inside the new range.
refresh = function()
{
    slots = ap_slot_list();
    infos = ap_slot_infos(slots);
    scroll_target = clamp(scroll_target, 0, scroll_limit());
    scroll_px = clamp(scroll_px, 0, scroll_limit());
};

// Focuses a box (-1 for none) with the caret at the end and a fresh undo history.
focus_field = function(index)
{
    focus = index;
    edit.caret = (index >= 0) ? string_length(fields[index]) : 0;
    edit.anchor = edit.caret;
    edit.ofs = 0;
    edit.dragging = false;
    edit.kind = "";
    edit.undo = [];
    edit.redo = [];
    keyboard_string = "";
};

// Focuses a clicked box and keeps the caret the click placed.
click_field = function(index)
{
    if (focus != index)
    {
        edit.kind = "";
        edit.undo = [];
        edit.redo = [];
    }

    focus = index;
    keyboard_string = "";
};

// Shows an error in the header.
fail = function(message)
{
    global.ap_error = message;
};

// Starts the New Game flow at the save name box.
new_game = function()
{
    fields = ["", "archipelago.gg", "38281", "", ""];
    editing = false;
    global.ap_error = "";
    state = "name";
    focus_field(0);
};

// Save name to connection details. The name is the slot file key, so it must be non-empty and unused.
go_next = function()
{
    var name = ap_ui_trim(fields[0]);

    if (name == "")
    {
        fail("Enter a save name.");
        return;
    }

    pending_key = ap_slot_sanitize(name);

    if (ap_slot_exists(pending_key))
    {
        fail("A save with that name already exists.");
        return;
    }

    fields[0] = name;
    global.ap_error = "";
    state = "connect";
    focus_field(1);
};

// Validates the connection details and starts connecting.
go_connect = function()
{
    if (ap_ui_trim(fields[1]) == "" || fields[2] == "" || ap_ui_trim(fields[3]) == "")
    {
        fail("Host name, port and slot name are required.");
        return;
    }

    global.ap_error = "";
    global.ap_connect_state = 1;
    connecting_timer = 0;
    state = "connecting";
    focus_field(-1);
    ap_connect_start(fields[1], fields[2], fields[3], fields[4]);
};

// Fills the form from a saved slot so its details can be edited before connecting.
play = function(index)
{
    var info = infos[index];
    pending_key = info.key;
    fields = [info.save_name, info.host, info.port, info.slot, info.password];
    editing = true;
    global.ap_error = "";
    state = "connect";
    focus_field(1);
};

// Connected: selects the slot, saves its details and goes to the main menu.
finish = function()
{
    log("connect finished, selecting slot " + pending_key);
    ap_slot_select(pending_key);
    global.ap_save_name = fields[0];
    global.ap_host_name = fields[1];
    global.ap_host_port = fields[2];
    global.ap_slot_name = fields[3];
    global.ap_slot_password = fields[4];
    ap_slot_write_meta();
    state = "done";
    var ftr = instance_create_depth(x, y, -99999999, obj_fadetoroom);
    ftr.rm = rm_mainmenu;
};

refresh();
