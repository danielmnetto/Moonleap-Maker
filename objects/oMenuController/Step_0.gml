if is_disabled {
  exit;
}

oCamera.pause_delay = 10;

var _menus_length = struct_get_names(menus);

if instance_exists_any([oIntro, oTransition])
or array_length(_menus_length) == 0 {
  exit;
}

scr_inputget();
check_debugging_mode();

var _menu = menus[$ current_menu_name],
    _options_length = array_length(_menu),
    _option = _menu[current_option_index],

    _input_nav_up = key_up or (key_up_axis_pressed and not key_axis_pressed),
    _input_nav_down = key_down or (key_down_axis_pressed and not key_axis_pressed),
    _input_nav_select = key_start or key_jump_pressed;

if _input_nav_up and current_option_index > 0 {
  play_sound_on_navigate();
  current_option_index -= 1;

} else if _input_nav_down and current_option_index < _options_length - 1 {
  play_sound_on_navigate();
  current_option_index += 1;

} else if _input_nav_select {
  if _option.can_play_select_sound {
    play_sound_on_select_option();
  }

  var _shake_intensity = 0.4,
      _shake_duration = 2;

  shake_gamepad(_shake_intensity, _shake_duration);
  
  if is_instanceof(_option, MenuOptionMenuCall) {
    var _menu_name = _option.menu_name;

    if struct_exists(menus, _menu_name) {
      current_menu_name = _menu_name;
      current_option_index = 0;
      _option.run_action();
    }
  } else if is_instanceof(_option, MenuOptionCloseMenu) {
    _option.run_action();
    instance_destroy();
  } else if is_instanceof(_option, MenuOptionActionCall) {
    _option.run_action();
  } 
}
