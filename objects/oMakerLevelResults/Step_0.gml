scr_inputget();

if instance_exists_any([oTransition, oMakerTransition]) {
  exit;
}


if key_down and current_option == LEVEL_MAKER_RESULT_OPTION.TRY_AGAIN {
  current_option += 1;
  play_sound_on_navigate();
} else if key_up and current_option == LEVEL_MAKER_RESULT_OPTION.QUIT {
  current_option -= 1;
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
      maker_transition_set_background_color_by_level_style(
        _maker_transition,
        oLevelMaker.selected_style
      );
    break;
  
    case LEVEL_MAKER_RESULT_OPTION.QUIT:
      room_transit(RoomMakerMenu, "Instances");
    break;
  }
}