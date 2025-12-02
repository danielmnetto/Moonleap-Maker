/*
 * This object is a replacement for the oMenu and oPauseMenu objects.
 * 
 * To call this menu controller in the game, use menu_call(...) command or
 * instantiate it in the room and edit the variables below through the
 * Instance Creation Code.
 */ 

// You can edit these variables below.
menus = {};
current_menu_name = "";
fill_background = false;
show_game_version = false;
show_title = false;

// DO NOT EDIT THESE VARIABLES BELOW!
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

  var name = " ";

  if room_is(RoomMaker0) {
  	name = LANG.maker_name;

    if not is_string(name) then name = " ";
    return name;
  }

  name = LANG[$ room_get_name(room)];
  if not is_string(name) then name = " ";
  return name;
};

update_touch_controls_alpha();