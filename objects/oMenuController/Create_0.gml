/*
 * This object is a replacement for the oMenu and oPauseMenu objects.
 * 
 * To call this menu controller in the game, use menu_call(...) command or
 * instantiate it in the room and edit the variables below through the
 * Instance Creation Code.
 */ 

// Singleton object.
if instance_number(oMenuController) > 1 {
  instance_destroy();
}

// You can edit these variables below.
menus = {};
current_menu_name = "";
fill_background = false;
show_game_version = false;
show_title = false;
is_disabled = false;
use_alt_colors = false;

// DO NOT EDIT THESE VARIABLES BELOW!
_is_toggling = false;
current_option_index = 0;
background_fill_color = COLOR_NICE_BLACK;

scr_inputcreate();

// Change background fill color to black on space themed places.
if instance_exists(oPlayer)
and (
  (room_is(Room100) and oPlayer.y < room_height / 2)
  or instance_exists_any([oFlowerDay, oSpaceDay, oDunDay])
) {
  background_fill_color = c_black;
}

update_touch_controls_alpha = function() {
  obDirection.image_alpha =	global.settings.buttons / 100;
  obJump.image_alpha      =	global.settings.buttons / 100;
  oBpause.image_alpha     =	global.settings.buttons / 100;
};

play_sound_on_navigate = function() {
  var _sound = sndUiChange,
      _can_loop = false,
      _gain = -18.3,
      _pitch = 1;

  audio_play_sfx(_sound, _can_loop, _gain, _pitch);
};

__play_sound_on_toggle_value = function() {
  var _sound = sndUiChange,
      _can_loop = false,
      _gain = -18.3,
      _pitch = 1;

  audio_play_sfx(_sound, _can_loop, _gain, _pitch);
};

play_sound_on_select_option = function() {
  var _ui_select_sound = sndUiChange,
      _priority = 1,
      _loop = false,
      _gain = 0.20 * (global.settings.enable_sfx),
      _offset = 0,
      _pitch = 1.4;

  audio_play_sound(_ui_select_sound, _priority, _loop, _gain, _offset, _pitch);
};

check_debugging_mode = function() {
  var _string_match = "05081999debugmode",
      _debug_sound = sndUiChange,
      _priority = 10,
      _loop = false,
      _gain = (power(10, -18.2/20)) * (global.settings.enable_sfx),
      _offset = 0,
      _pitch = 1.4;

  if keyboard_string == _string_match and not oCamera.debug {
    oCamera.debug = true;
    audio_play_sound(_debug_sound, _priority, _loop, _gain, _offset, _pitch);
    keyboard_string = "";
  }
};

get_title = function() {
  if room_is([RoomMenu, RoomMenu2, RoomCredits, RoomCreditsAlves, Room100, rm_blank0]) {
  	return " ";
  }

  if room_is(RoomMaker0) {
    return LANG.maker_name;
  }

  var _title = LANG[$ room_get_name(room)];
  if not is_string(_title) {
    return " ";
  }
  return _title;
};

__handle_options_selection = function() {
  if _is_toggling {
    return;
  }
  
  var _menu = menus[$ current_menu_name],
    _options_length = array_length(_menu),
    _input_nav_up = key_up or (not key_axis_pressed and key_up_axis_pressed),
    _input_nav_down = key_down or (not key_axis_pressed and key_down_axis_pressed);
  
  if _input_nav_up and current_option_index > 0 {
    play_sound_on_navigate();
    current_option_index -= 1;
    return
  }
  
  if _input_nav_down and current_option_index < _options_length - 1 {
    play_sound_on_navigate();
    current_option_index += 1;
  }
};

__handle_option_activation = function() {
  var _input_nav_select = key_start or key_jump_pressed;
  
  if not _input_nav_select {
    return;
  }
  
  var _menu = menus[$ current_menu_name],
    _option = _menu[current_option_index];
  
  if _option.can_play_select_sound {
    play_sound_on_select_option();
  }

  var _shake_intensity = 0.4,
      _shake_duration = 2;

  shake_gamepad(_shake_intensity, _shake_duration);
  
  // Check which type of option is to trigger the right command flow.
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
  } else if is_instanceof(_option, MenuOptionDirectionalToggle) {
    _is_toggling = not _is_toggling;
  }
};

__handle_option_value_toggling = function() {
  if not _is_toggling {
    return;
  }
  
  var _menu = menus[$ current_menu_name],
    _option = _menu[current_option_index],
    _input_toggle_up = key_up or (not key_axis_pressed and key_up_axis_pressed),
    _input_toggle_down = key_down or (not key_axis_pressed and key_down_axis_pressed),
    _input_toggle_left = key_left_pressed or (not key_axis_pressed and key_left_axis_pressed),
    _input_toggle_right = key_right_pressed or (not key_axis_pressed and key_right_axis_pressed);
  
  if _input_toggle_left and is_method(_option.toggle_left_callback) {
    __play_sound_on_toggle_value();
    _option.toggle_left_callback();
    return;
  }
  
  if _input_toggle_right and is_method(_option.toggle_right_callback) {
    __play_sound_on_toggle_value();
    _option.toggle_right_callback();
    return;
  }
  
  if _input_toggle_up and is_method(_option.toggle_up_callback) {
    __play_sound_on_toggle_value();
    _option.toggle_up_callback();
    return;
  }
  
  if _input_toggle_down and is_method(_option.toggle_down_callback) {
    __play_sound_on_toggle_value();
    _option.toggle_down_callback();
    return
  }
};

update_touch_controls_alpha();