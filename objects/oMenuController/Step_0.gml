oCamera.pause_delay = 10;

if keyboard_string == "05081999debugmode" and not oCamera.debug {
  oCamera.debug = true;
  audio_play_sound(sndUiChange, 10, false, (power(10, -18.2/20)) * (global.settings.enable_sfx),0,1.4)
  keyboard_string = "";
}

var _menu = menus[$ current_menu_name],
    _options_length = array_length(_menu),
    _option = _menu[current_option_index],

    _input_nav_up = key_up or (key_up_axis_pressed and not key_axis_pressed),
    _input_nav_down = key_down or (key_down_axis_pressed and not key_axis_pressed),
    _input_nav_left = key_left_pressed,
    _input_nav_right = key_right_pressed,
    _input_nav_select = key_start or key_jump_pressed;

if not is_on_input_mode {
  if _input_nav_up and current_option_index > 0 {
    play_sound_on_navigate();
    current_option_index -= 1;
  
  } else if _input_nav_down and current_option_index < _options_length - 1 {
    play_sound_on_navigate();
    current_option_index += 1;
  
  } else if _input_nav_select and not instance_exists(oTransition) {
  	//if _option.name != "sure?" {
      //audio_play_sound(sndUiChange,1,false,0.20*(global.settings.enable_sfx),0,1.4)
    //}
    play_sound_on_select_option();
  
    var _shake_intensity = 0.4,
        _shake_duration = 2;
  
  	shake_gamepad(_shake_intensity, _shake_duration);
    
    if is_instanceof(_option, MenuOptionMenuCall) {
      var _menu_name = _option.menu_name;
  
      if struct_exists(menus, _menu_name) {
        current_menu_name = _menu_name;
        current_option_index = 0;
        _option.trigger_action();
      }
    } else if is_instanceof(_option, MenuOptionValueToggle) {
      
    } else if is_instanceof(_option, MenuOptionActionCall) {
      _option.trigger_action();
    }
  }
} else {
  
}

