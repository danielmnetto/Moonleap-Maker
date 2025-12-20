var _text_letters_distance = 0,
    _text_line_distance = 12,
    _text_line_width = 288,
    _text_break_on_space = false,
    _text_alpha = 1,

    _message_x = GUI_W / 2,
    _message_y = GUI_H / 2,
    _message_text = message,
    _message_halign = fa_center,
    _message_valign = fa_middle;

draw_clear(bg_color);

draw_set_font(oCamera.font);
draw_set_halign(_message_halign);
draw_set_valign(_message_valign);
draw_set_color(message_color);

draw_text_nox(
  _message_x,
  _message_y,
  _message_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

draw_reset();
