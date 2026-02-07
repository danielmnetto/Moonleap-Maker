function maker_transition_start(_room_target, _title = "", _subtitle = "", _background_color = COLOR_NICE_BLACK) {
  var _transition = instance_create_layer(-16, -16, "Instances", oMakerTransition);
  
  _transition.room_target = _room_target;
  _transition.show_title = string_length(_title) > 0;
  _transition.title = _title;
  _transition.subtitle = _subtitle;
  _transition.transition_background_color = _background_color ?? COLOR_NICE_BLACK;
  
  return _transition;
}

function maker_transition_is_running() {
  return instance_exists(oMakerTransition) and not oMakerTransition.state_machine.state_is("fade_in")
}