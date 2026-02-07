draw_set_font(oCamera.font);

draw_clear(COLOR_NICE_BLACK);

var _level_name_halign = fa_center,
    _level_name_valign = fa_middle,
    _level_name_height = string_height(level_name),
    _level_name_x = GUI_W / 2,
    _level_name_y = GUI_H / 4 - _level_name_height / 2,
    _level_name_text = level_name,
    _level_name_color = COLOR_NICE_WHITE,
    _level_name_letters_distance = 0,
    _level_name_line_distance = 12,
    _level_name_line_width = GUI_W,
    _level_name_break_on_space = false,
    _level_name_alpha = 1;

draw_set_halign(_level_name_halign);
draw_set_valign(_level_name_valign);
draw_set_color(_level_name_color);

draw_text_nox(
  _level_name_x,
  _level_name_y,
  _level_name_text,
  _level_name_letters_distance,
  _level_name_line_distance,
  _level_name_line_width,
  _level_name_break_on_space,
  _level_name_alpha
);

var _level_author_halign = fa_center,
    _level_author_valign = fa_middle,
    _level_author_height = string_height(level_author),
    _level_author_x = GUI_W / 2,
    _level_author_y = GUI_H / 4 + _level_author_height / 2,
    _level_author_text = level_author,
    _level_author_color = COLOR_NICE_WHITE,
    _level_author_letters_distance = 0,
    _level_author_line_distance = 12,
    _level_author_line_width = GUI_W,
    _level_author_break_on_space = false,
    _level_author_alpha = 1;

draw_set_halign(_level_author_halign);
draw_set_valign(_level_author_valign);
draw_set_color(_level_author_color);

draw_text_nox(
  _level_author_x,
  _level_author_y,
  _level_author_text,
  _level_author_letters_distance,
  _level_author_line_distance,
  _level_author_line_width,
  _level_author_break_on_space,
  _level_author_alpha
);

nox_set_alternative_color(COLOR_NICE_BLUE, "#");

var _rank_result_halign = fa_center,
    _rank_result_valign = fa_middle,
    _rank_result_letter = rank_get_result_letter() == "S" ? $"#{rank_get_result_letter()}#" : rank_get_result_letter(),
    _rank_result_text = $"{LANG.maker_level_result}{_rank_result_letter}",
    _rank_result_height = string_height(_rank_result_text),
    _rank_result_x = GUI_W / 2,
    _rank_result_y = GUI_H / 2.5 + _rank_result_height / 2,
    _rank_result_color = COLOR_NICE_WHITE,
    _rank_result_letters_distance = 0,
    _rank_result_line_distance = 12,
    _rank_result_line_width = GUI_W,
    _rank_result_break_on_space = false,
    _rank_result_alpha = 1;

draw_set_halign(_level_author_halign);
draw_set_valign(_level_author_valign);
draw_set_color(_level_author_color);

draw_text_nox(
  _rank_result_x,
  _rank_result_y,
  _rank_result_text,
  _rank_result_letters_distance,
  _rank_result_line_distance,
  _rank_result_line_width,
  _rank_result_break_on_space,
  _rank_result_alpha
);

var _time_played_halign = fa_center,
    _time_played_valign = fa_middle,
    _time_played_text = $"{LANG.maker_level_time_played}{time_played_get_formatted()}",
    _time_played_height = string_height(_time_played_text),
    _time_played_x = GUI_W / 2,
    _time_played_y = GUI_H / 2.5 + _time_played_height * 1.5,
    _time_played_color = COLOR_NICE_WHITE,
    _time_played_letters_distance = 0,
    _time_played_line_distance = 12,
    _time_played_line_width = GUI_W,
    _time_played_break_on_space = false,
    _time_played_alpha = 1;

draw_set_halign(_time_played_halign);
draw_set_valign(_time_played_valign);
draw_set_color(_time_played_color);

draw_text_nox(
  _time_played_x,
  _time_played_y,
  _time_played_text,
  _time_played_letters_distance,
  _time_played_line_distance,
  _time_played_line_width,
  _time_played_break_on_space,
  _time_played_alpha
);
