current_menu_name = "";
fill_background = false;
show_game_version = false;
background_fill_color = COLOR_NICE_BLACK;
use_draw_end = false;

menus = {
  main: menu_get_main()
};
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

//update_touch_controls_alpha();