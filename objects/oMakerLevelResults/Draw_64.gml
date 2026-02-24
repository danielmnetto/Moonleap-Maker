draw_set_font(oCamera.font);

var _background_color = COLOR_NICE_BLACK;

draw_clear(_background_color);

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

var _record_time_halign = fa_center,
    _record_time_valign = fa_middle,
    _record_time_text = $"{LANG.maker_level_record_time}{time_get_format_mm_ss_ms(record_time)}",
    _record_time_height = string_height(_record_time_text),
    _record_time_x = GUI_W / 2,
    _record_time_y = GUI_H / 2.5 + _record_time_height * 1.5,
    _record_time_color = COLOR_NICE_WHITE,
    _record_time_letters_distance = 0,
    _record_time_line_distance = 12,
    _record_time_line_width = GUI_W,
    _record_time_break_on_space = false,
    _record_time_alpha = 1;

draw_set_halign(_record_time_halign);
draw_set_valign(_record_time_valign);
draw_set_color(_record_time_color);

draw_text_nox(
  _record_time_x,
  _record_time_y,
  _record_time_text,
  _record_time_letters_distance,
  _record_time_line_distance,
  _record_time_line_width,
  _record_time_break_on_space,
  _record_time_alpha
);

var _time_played_halign = fa_center,
    _time_played_valign = fa_middle,
    _time_played_text = $"{LANG.maker_level_time_played}{time_get_format_mm_ss_ms(time_played)}",
    _time_played_height = string_height(_time_played_text),
    _time_played_x = GUI_W / 2,
    _time_played_y = GUI_H / 2.5 + _time_played_height * 2.5,
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

var _text_wave_height = 2.25,
    _text_wave_time = 0.75,
    _text_wave_length = 1,
    _text_wave_char = "~";

nox_set_wave(
  _text_wave_height,
  _text_wave_time,
  _text_wave_length,
  _text_wave_char
);

var _option1_halign = fa_center,
    _option1_valign = fa_middle,
    _option1_text = current_option == 0 ? $"~{LANG.maker_level_try_again}~" : $"{LANG.maker_level_try_again}",
    _option1_height = string_height(_option1_text),
    _option1_x = GUI_W / 2,
    _option1_y = GUI_H / 1.5 + _option1_height,
    _option1_color = current_option == 0 ? COLOR_NICE_WHITE : COLOR_NICE_BLUE,
    _option1_letters_distance = 0,
    _option1_line_distance = 12,
    _option1_line_width = GUI_W,
    _option1_break_on_space = false,
    _option1_alpha = 1;

draw_set_halign(_option1_halign);
draw_set_valign(_option1_valign);
draw_set_color(_option1_color);

draw_text_nox(
  _option1_x,
  _option1_y,
  _option1_text,
  _option1_letters_distance,
  _option1_line_distance,
  _option1_line_width,
  _option1_break_on_space,
  _option1_alpha
);

var _option2_halign = fa_center,
    _option2_valign = fa_middle,
    _option2_text = current_option == 1 ? $"~{LANG.text_exit}~" : $"{LANG.text_exit}",
    _option2_height = string_height(_option2_text),
    _option2_x = GUI_W / 2,
    _option2_y = GUI_H / 1.5 + _option2_height * 2,
    _option2_color = current_option == 1 ? COLOR_NICE_WHITE : COLOR_NICE_BLUE,
    _option2_letters_distance = 0,
    _option2_line_distance = 12,
    _option2_line_width = GUI_W,
    _option2_break_on_space = false,
    _option2_alpha = 1;

draw_set_halign(_option2_halign);
draw_set_valign(_option2_valign);
draw_set_color(_option2_color);

draw_text_nox(
  _option2_x,
  _option2_y,
  _option2_text,
  _option2_letters_distance,
  _option2_line_distance,
  _option2_line_width,
  _option2_break_on_space,
  _option2_alpha
);

draw_reset();