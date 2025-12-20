function call_message_popup(_message, _duration_frames = undefined, _layer = "Instances") {
  if instance_exists(oMessagePopup) {
    return;
  }
  var _message_popup = instance_create_layer(0, 0, _layer, oMessagePopup);
  
  _message_popup.message = _message;
  if not is_undefined(_duration_frames) and is_real(_duration_frames) {
    _message_popup.duration_frames = _duration_frames;  
  }
}
