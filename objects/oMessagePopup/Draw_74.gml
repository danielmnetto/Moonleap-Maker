var _message_height = string_height(message),
    _box_left = box_margin.left,
    _box_top = (GUI_H / 2) - (_message_height / 2) - box_padding.top,
    _box_right = GUI_W - box_margin.right,
    _box_bottom = (GUI_H / 2) + (_message_height / 2) + box_padding.bottom,
    _is_outline_rectangle = false;

draw_set_color(box_color);
draw_set_alpha(alpha);
draw_rectangle(_box_left, _box_top, _box_right, _box_bottom, _is_outline_rectangle);

draw_set_font(oCamera.font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(message_color);

draw_text(GUI_W / 2, GUI_H / 2, message);

draw_set_color(-1);
draw_set_alpha(1);
draw_set_halign(-1);
draw_set_valign(-1);
