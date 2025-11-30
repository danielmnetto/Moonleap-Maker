/// @desc Menu drawing

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(oCamera.font);

nox_set_wave(2.25, 0.75, 1, "~")
nox_set_alternative_color(COLOR_NICE_WHITE, "#");

if fill_background {
  draw_clear(COLOR_NICE_BLACK);
}

var _menu = menus[$ current_menu_name],
    _options_length = array_length(_menu),
    
    _game_version_base_x = GUI_W - 21,
    _game_version_base_y = GUI_H - 18,
    _game_version_label = "v"+string_copy(GM_version,1,5),
    _game_version_label_color = COLOR_NICE_PURPLE,

    _current_option = _menu[current_option_index],
    _option_base_x = GUI_W / 2,
    _option_base_y = 78,
    _option_y_gap = 14,

    _description = _current_option.get_description(),
    _description_base_x = GUI_W / 2,
    _description_base_y = 140;

if show_game_version {
  draw_set_color(COLOR_NICE_PURPLE);
  draw_text(_game_version_base_x, _game_version_base_y, _game_version_label);
}

for (var _i = 0; _i < _options_length; _i++) {
  var _menu_option = _menu[_i],
      _is_option_selected = current_option_index == _i,

      _option_color_default = COLOR_NICE_MAGENTA,
      _option_color_selected = COLOR_NICE_YELLOW,
      _option_color_on_input = COLOR_NICE_WHITE,
      _option_color = _is_option_selected ? _option_color_selected : _option_color_default,

      _option_x = _option_base_x,
      _option_y = _option_base_y + (_option_y_gap * _i),
      _label = _menu_option.get_label(),
      _letters_distance = 0,
      _line_distance = 12,
      _line_width = 320,
      _break_on_space = false,
      _alpha = 1;

  if is_on_input_mode {
    _option_color = _option_color_on_input;
  }
  
  draw_set_color(_option_color);
  
  if _is_option_selected {
    _label = $"~{_label}~"
		//if (menu == menus.deletesure) {
      ////shake
      //draw_text_nox(_option_x,_option_y,"$"+ _label +"$",_letters_distance, _line_distance, _line_width, _break_on_space, _alpha);
    //} else {
      ////wave
      //draw_text_nox(_option_x,_option_y,"~"+ _label +"~",_letters_distance, _line_distance, _line_width, _break_on_space, _alpha);
    //}
	}
  draw_text_nox(_option_x, _option_y, _label, _letters_distance, _line_distance, _line_width, _break_on_space, _alpha); 
}

if not is_undefined(_description) {
  draw_set_color(COLOR_NICE_YELLOW);
  draw_text(_description_base_x, _description_base_y, _description);
}

//if (menu == menus.deletesure)
//{
	//draw_set_color(nice_yellow);
	//if (option.name == "yes") {
		//draw_text_nox(160,140,"#"+LANG.text_savecaution+"#",0,12,320,false,1)
	//}
//}