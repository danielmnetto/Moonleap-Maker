function level_maker_test_show_missing_objects_message() {
  var _msg = "",
      _msg_count = 0, // used to add line break.
      _duration = 90;
  
  if not oLevelMaker.has_level_a_player() {
    _msg += $"- {LANG.maker_level_test_no_player}";
    _msg_count += 1;
  }
  
  if not oLevelMaker.has_level_a_star() {
    if _msg_count > 0 {
      _msg += "\n";
      _duration += 60;
    }
    _msg += $"- {LANG.maker_level_test_no_star}";
  }
  
  audio_play_sfx(snd_bump, false, -5, 13);
  call_message_popup(_msg, _duration, layer);
}

function level_maker_save_show_missing_objects_message() {
  var _msg = "",
      _msg_count = 0, // used to add line break.
      _duration = 90;
  
  if not oLevelMaker.has_level_a_player() {
    _msg += $"- {LANG.maker_level_save_no_player}";
    _msg_count += 1;
  }
  
  if not oLevelMaker.has_level_a_star() {
    if _msg_count > 0 {
      _msg += "\n";
      _duration += 60;
    }
    _msg += $"- {LANG.maker_level_save_no_star}";
  }
  
  audio_play_sfx(snd_bump, false, -5, 13);
  call_message_popup(_msg, _duration, layer);
}
