if instance_exists_any([oTransition, oMakerTransition]) {
  exit;
}

scr_inputget();

var _input_nav_up = key_up or (key_up_axis_pressed and not key_axis_pressed),
    _input_nav_down = key_down or (key_down_axis_pressed and not key_axis_pressed),
    _input_nav_select = key_start or key_jump_pressed;

if _input_nav_up and current_option > 0 {
  play_sound_on_navigate();
  current_option -= 1;
  confirm_erase_count = 0;

} else if _input_nav_down and current_option < LEVEL_MAKER_DESCRIPTION_OPTION.LENGTH - 1 {
  play_sound_on_navigate();
  current_option += 1;
  confirm_erase_count = 0;

} else if _input_nav_select {
  play_sound_on_select_option();

  var _shake_intensity = 0.4,
      _shake_duration = 2;

  shake_gamepad(_shake_intensity, _shake_duration);

  switch(current_option) {
    // Play
    case LEVEL_MAKER_DESCRIPTION_OPTION.PLAY:
      play_transition_sound();
      var _data_trasition = instance_create_layer(-16, -16, "Instances", oMakerLevelDataTransition),
          _transition_title = level.name,
          _transition_subtitle = level.author;
      
      _data_trasition.level_filename = level.filename;
      _data_trasition.is_true_test = true;
      
      var _transition = maker_transition_start(
        RoomMaker0,
        _transition_title,
        _transition_subtitle,
      );
    exit;
      
    // Edit
    case LEVEL_MAKER_DESCRIPTION_OPTION.EDIT:
      play_transition_sound();
      var _data_edit_trasition = instance_create_layer(-16, -16, "Instances", oMakerLevelDataTransition);
      
      _data_edit_trasition.level_filename = level.filename;
      _data_edit_trasition.is_true_test = false;
      
      maker_transition_start(RoomMaker0);
    exit;

    // Erase
    case LEVEL_MAKER_DESCRIPTION_OPTION.DELETE:
      confirm_erase_count += 1;
      if confirm_erase_count < confirm_erase_count_max {
        break;
      }
      if file_exists(level.filename) {
        file_delete(level.filename);  
      }
      var _sfx_death = choose(
          sfx_luano_death_pause_01,
          sfx_luano_death_pause_02,
          sfx_luano_death_pause_03,
          sfx_luano_death_pause_04,
          sfx_luano_death_pause_05
        ),
          _loop = false,
          _gain = -8.79,
          _pitch_random = 5;

      audio_play_sfx(_sfx_death, _loop, _gain, _pitch_random);
      
      if instance_exists(oMakerLevelsList) {
        oMakerLevelsList.import_levels_from_levels_folder();
        oMakerLevelsList.current_level_index = -2;
      }
      instance_destroy();
    break;

    // Go back
    case LEVEL_MAKER_DESCRIPTION_OPTION.GO_BACK:
      instance_destroy();
    break;
  }
}