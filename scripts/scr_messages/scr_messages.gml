function call_message_popup(_message, _duration_frames = undefined, _layer = "Instances", _show_on_draw_gui = false) {
  if instance_exists(oMessagePopup) {
    return;
  }
  var _message_popup = instance_create_layer(0, 0, _layer, oMessagePopup);
  
  _message_popup.message = _message;
  _message_popup.show_on_draw_gui = _show_on_draw_gui;
  if not is_undefined(_duration_frames) and is_real(_duration_frames) {
    _message_popup.duration_frames = _duration_frames;  
  }
}

function call_message_info(_messages, _layer = "Instances") {
  if instance_exists(oMessageInfo) {
    return;
  }
  var _message_info = instance_create_layer(0, 0, _layer, oMessageInfo);
  
  _message_info.messages = _messages;
}