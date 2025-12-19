draw_set_font(oCamera.font);

var _background_color = COLOR_NICE_BLACK,
    _text_input_color = COLOR_NICE_WHITE,
    
    _center_x = GUI_W / 2,
    _center_y = GUI_H / 2,
    
    _title_base_x = _center_x,
    _title_base_y = _center_y - 32,
    _title_text = $"~{title}~",
    _title_letters_distance = 0,
    _title_line_distance = 12,
    _title_line_width = 320,
    _title_break_on_space = false,
    _title_alpha = 1,
    _title_color = COLOR_NICE_DARK,
    
    _hint_color = COLOR_NICE_DARK,

    _title_text_wave_height = 2.25,
    _title_text_wave_time = 1,
    _title_text_wave_length = 100,
    _title_text_wave_char = "~";

draw_clear(_background_color);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

nox_set_wave(
  _title_text_wave_height,
  _title_text_wave_time,
  _title_text_wave_length,
  _title_text_wave_char
);
draw_set_color(_title_color);
draw_text_nox(
  _title_base_x,
  _title_base_y,
  _title_text,
  _title_letters_distance,
  _title_line_distance,
  _title_line_width,
  _title_break_on_space,
  _title_alpha
);

var _display_user_input = user_input;
if string_length(user_input) < input_string_max {
  _display_user_input += "_";
}

draw_set_color(_text_input_color);
draw_text_nox(
  _center_x,
  _center_y,
  _display_user_input,
  _title_letters_distance,
  _title_line_distance,
  _title_line_width,
  _title_break_on_space,
  _title_alpha
);

var _display_user_input_height = string_height(_display_user_input);
var _max_characters_string = $"{string_length(user_input)} / {input_string_max}";

if input_string_min > 0 {
  _max_characters_string += $" (mínimo: {input_string_min})";
}

draw_set_color(_hint_color);
draw_text_nox(
  _center_x,
  _center_y + _display_user_input_height + 4, 
  _max_characters_string,
  _title_letters_distance,
  _title_line_distance,
  _title_line_width,
  _title_break_on_space,
  _title_alpha
);

draw_set_halign(-1);
draw_set_valign(-1);
draw_set_color(-1);
