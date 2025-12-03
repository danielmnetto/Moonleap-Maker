var _levels_length = array_length(levels),

    _menu_start_x = 8,
    _menu_start_y = 48,

    _box_sprite = sLevelBox,
    _box_margin_left = 8,
    _box_margin_right = 16,
    _box_margin_bottom = 4,
    _box_width = GUI_W - _menu_start_x - _box_margin_left - _box_margin_right,
    _box_height = 40,

    _text_halign = fa_left,
    _text_valign = fa_top,
    _text_font = oCamera.font,
    _text_padding_left = 6,
    _text_padding_top = 2,
    _text_padding_right = 6,
    _text_color_default = COLOR_NICE_MAGENTA,
    _text_color_selected = COLOR_NICE_YELLOW,
    _text_letters_distance = 0,
    _text_line_distance = 12,
    _text_line_width = _box_width - _text_padding_right,
    _text_break_on_space = false,
    _text_alpha = 1,

    _text_wave_height = 2.25,
    _text_wave_time = 0.75,
    _text_wave_length = 1,
    _text_wave_char = "~";

draw_set_halign(_text_halign);
draw_set_valign(_text_valign);
draw_set_font(_text_font);
nox_set_wave(
  _text_wave_height,
  _text_wave_time,
  _text_wave_length,
  _text_wave_char
);

for (var _i = level_display_range_start; _i <= level_display_range_end; _i++) {
  var _level = levels[_i],
      _level_name = _level.name,
      _level_author = _level.author,
      _is_selected = _i == current_level_index,
      _levels_x = _menu_start_x + _box_margin_left,
      _levels_y = _menu_start_y + (_box_height + _box_margin_bottom) * (_i - level_display_range_start),

      _text_color = _is_selected ? _text_color_selected : _text_color_default,

      _level_name_x = _levels_x + _text_padding_left,
      _level_name_y = _levels_y + _text_padding_top,
      _level_name_label = _is_selected ? $"~{_level_name}~" : _level_name,
      _level_name_height = string_height(_level_name_label),

      _level_author_x = _levels_x + _text_padding_left,
      _level_author_y = _levels_y + _level_name_height + _text_padding_top,
      _level_author_label = _is_selected ? $"~{_level_author}~" : _level_author;

  draw_sprite_stretched(_box_sprite, _is_selected, _levels_x, _levels_y, _box_width, _box_height);
  
  draw_set_color(_text_color);
  draw_text_nox(
    _level_name_x,
    _level_name_y,
    _level_name_label,
    _text_letters_distance,
    _text_line_distance,
    _text_line_width,
    _text_break_on_space,
    _text_alpha
  );
  draw_text_nox(
    _level_author_x,
    _level_author_y,
    _level_author_label,
    _text_letters_distance,
    _text_line_distance,
    _text_line_width,
    _text_break_on_space,
    _text_alpha
  );
}