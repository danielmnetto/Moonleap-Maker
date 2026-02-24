enum LEVEL_MAKER_DESCRIPTION_OPTION { PLAY, EDIT, DELETE, GO_BACK, LENGTH }

level = undefined;

current_option = 0;
confirm_erase_count = 0;
confirm_erase_count_max = 3;

scr_inputcreate();

play_transition_sound = function() {
  menu_play_redirect_option_sound();
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

level_get_rank_letter = function(_player_score, _perfect_score) {
  var _letter = "D";
  
  if _player_score <= _perfect_score + 9 {
    _letter = "C";
  }
  if _player_score <= _perfect_score + 6 {
    _letter = "B";
  }
  if _player_score <= _perfect_score + 3 {
    _letter = "A";
  }
  if _player_score <= _perfect_score {
    _letter = "#S#";
  }
  if _player_score < 0 {
    _letter = "-";
  }
  
  return _letter;
};

layer = layer_get_id("Instances_2");
