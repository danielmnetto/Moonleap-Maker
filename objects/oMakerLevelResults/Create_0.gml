enum LEVEL_MAKER_RESULT_OPTION { TRY_AGAIN, QUIT , LENGTH }

level_name = "";
level_author = "";
player_score = 0;
perfect_score = 0;
time_played = -1;
record_time = -1;

current_option = 0;

scr_inputcreate();

rank_get_result_letter = function() {
  var _letter = "D";
  
  if player_score <= perfect_score + 9 {
    _letter = "C";
  }
  if player_score <= perfect_score + 6 {
    _letter = "B";
  }
  if player_score <= perfect_score + 3 {
    _letter = "A";
  }
  if player_score <= perfect_score {
    _letter = "S";
  }
  if instance_exists(oBird) {
    _letter = "D";
  }
  
  return _letter;
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
  audio_play_sfx(sndStarGame, false, -6, 0);
};