// You can edit these variables below
current_menu_name = "";
fill_background = false;
background_fill_color = COLOR_NICE_BLACK;
show_game_version = false;
use_draw_end = false;

// Do not edit these variables below
menus = {};
current_option_index = 0;
is_on_input_mode = false;

scr_inputcreate();

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
}

//update_touch_controls_alpha();