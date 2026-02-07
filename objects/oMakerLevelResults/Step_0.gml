scr_inputget();

if instance_exists_any([oTransition, oMakerTransition]) {
  exit;
}

var _input_nav = key_down - key_up

current_option += _input_nav;
current_option = clamp(current_option, 0, LEVEL_MAKER_RESULT_OPTION.LENGTH - 1);

if _input_nav != 0 {
  play_sound_on_navigate();
}

if key_jump or key_start {
  play_sound_on_select_option();
  
  switch(current_option) {
    case LEVEL_MAKER_RESULT_OPTION.TRY_AGAIN:
      var _maker_transition = maker_transition_start(room);
      _maker_transition.on_end_fade_out = function() {
        oLevelMaker.time_played_timer.reset();
        oLevelMaker.reset_level();
        instance_destroy(oMakerLevelResults);
      }
    break;
  
    case LEVEL_MAKER_RESULT_OPTION.QUIT:
      room_transit(RoomMakerMenu, "Instances");
    break;
  }
}