var _message_height = string_height(message),
    _box_left = box_margin.left,
    _box_top = (GUI_H / 2) - (_message_height / 2) - box_margin.top,
    _box_right = GUI_W - box_margin.right,
    _box_bottom = (GUI_H / 2) + (_message_height / 2) + box_margin.bottom,
    _is_outline_rectangle = false,
    
    _message_x = GUI_W / 2,
    _message_y = GUI_H / 2,
    _message_text = message,
    _message_halign = fa_center,
    _message_valign = fa_middle;

draw_set_color(box_color);
draw_set_alpha(alpha);
draw_rectangle(_box_left, _box_top, _box_right, _box_bottom, _is_outline_rectangle);

draw_set_font(oCamera.font);
draw_set_halign(_message_halign);
draw_set_valign(_message_valign);
draw_set_color(message_color);

draw_text(_message_x, _message_y, _message_text);

draw_reset();
