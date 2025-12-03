scr_inputget();

var _levels_length = array_length(levels),
    _level = levels[current_level_index],

    _input_nav_up = key_up or (key_up_axis_pressed and not key_axis_pressed),
    _input_nav_down = key_down or (key_down_axis_pressed and not key_axis_pressed),
    _input_nav_select = key_start or key_jump_pressed;

if _input_nav_up and current_level_index > 0 {
  play_sound_on_navigate();
  current_level_index -= 1;
  if current_level_index < level_display_range_start {
    level_display_range_start = current_level_index;
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
}
