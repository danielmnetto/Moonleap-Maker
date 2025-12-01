/// @desc Menu drawing

if fill_background {
  draw_clear(background_fill_color);
}

var _menu = menus[$ current_menu_name],
    _options_length = array_length(_menu),
    
    _text_halign = fa_center,
    _text_valign = fa_top,
    _text_font = oCamera.font,

    _text_wave_height = 2.25,
    _text_wave_time = 0.75,
    _text_wave_length = 1,
    _text_wave_char = "~",

    _text_blink_color = COLOR_NICE_WHITE,
    _text_blink_char = "#",

    _text_shake_char = "$",

    _game_version_base_x = GUI_W - 21,
    _game_version_base_y = GUI_H - 18,
    _game_version_label = "v"+string_copy(GM_version,1,5),
    _game_version_label_color = COLOR_NICE_PURPLE,

    _current_option = _menu[current_option_index],
    _option_base_x = GUI_W / 2,
    _option_base_y = 78,
    _option_y_gap = 14,
    _option_color_default = COLOR_NICE_MAGENTA,
    _option_color_selected = COLOR_NICE_YELLOW,
    _option_color_on_input = COLOR_NICE_WHITE,

    _description = _current_option.get_description(),
    _description_color = COLOR_NICE_YELLOW,
    _description_base_x = GUI_W / 2,
    _description_base_y = 140,

    _letters_distance = 0,
    _line_distance = 12,
    _line_width = 320,
    _break_on_space = false,
    _alpha = 1;

draw_set_halign(_text_halign);
draw_set_valign(_text_valign);
draw_set_font(_text_font);

nox_set_wave(_text_wave_height, _text_wave_time, _text_wave_length, _text_wave_char);
nox_set_alternative_color(_text_blink_color, _text_blink_char);

if show_game_version {
  draw_set_color(_game_version_label_color);
  draw_text(_game_version_base_x, _game_version_base_y, _game_version_label);
}

for (var _i = 0; _i < _options_length; _i++) {
  var _menu_option = _menu[_i],
      _is_option_selected = current_option_index == _i,
      _is_option_dangerous = _menu_option.is_dangerous,

      _option_x = _option_base_x,
      _option_y = _option_base_y + (_option_y_gap * _i),
      _option_label = _menu_option.get_label(),
      _option_color = _is_option_selected ? _option_color_selected : _option_color_default;

  if is_on_input_mode {
    _option_color = _option_color_on_input;
  }
  
  draw_set_color(_option_color);
  
  if _is_option_selected {
    _option_label = _is_option_dangerous 
      ? $"{_text_shake_char}{_option_label}{_text_shake_char}"
      : $"{_text_wave_char}{_option_label}{_text_wave_char}";
	}
  draw_text_nox(_option_x, _option_y, _option_label, _letters_distance, _line_distance, _line_width, _break_on_space, _alpha); 
}

if not is_undefined(_description) {
  if _current_option.is_dangerous {
    _description = $"{_text_blink_char}{_description}{_text_blink_char}";
  }
  draw_set_color(_description_color);
  draw_text_nox(_description_base_x, _description_base_y, _description, _letters_distance, _line_distance, _line_width, _break_on_space, _alpha);
}
