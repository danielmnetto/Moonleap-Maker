input_delay_frames = max(-1, input_delay_frames - 1);

if input_delay_frames == -1 {
  scr_inputget();
}

if instance_exists(oLevelDescription) {
  input_delay_frames = input_delay_frames_max;
  exit;
}

var _levels = levels_get_orderedby(),
    _levels_length = array_length(_levels),
    _level = _levels_length == 0 ? undefined : _levels[max(0, current_level_index)],

    _input_nav_up = key_up or (key_up_axis_pressed and not key_axis_pressed),
    _input_nav_down = key_down or (key_down_axis_pressed and not key_axis_pressed),
    _input_nav_select = key_start or key_jump_pressed;

if _input_nav_up and current_level_index > -2 {
  play_sound_on_navigate();
  current_level_index -= 1;
  if current_level_index < level_display_range_start {
    level_display_range_start = max(0, current_level_index);
    level_display_range_end = level_display_range_start + (levels_to_display - 1);
  }

} else if _input_nav_down and current_level_index < _levels_length - 1 {
  play_sound_on_navigate();
  current_level_index += 1;
  if current_level_index > level_display_range_end {
    level_display_range_end = current_level_index;
    level_display_range_start = level_display_range_end - (levels_to_display - 1);
  }

} else if _input_nav_select {
  play_sound_on_select_option();

  var _shake_intensity = 0.4,
      _shake_duration = 2;

  shake_gamepad(_shake_intensity, _shake_duration);

  switch(current_level_index) {
    // Go back
    case -2:
      menu_call_layer(menus_get_maker(), "main", "Instances");
      instance_destroy();
    exit;

    // Order by
    case -1:
      levels_orderby += 1;
      if levels_orderby >= LEVELS_ORDERBY.LENGTH {
        levels_orderby = 0;
      }
    break;

    // Levels
    default:
      var _level_description = instance_create_layer(-16, -16, "Instances", oLevelDescription);
      
      _level_description.level = _level;
    break;
  }
}
