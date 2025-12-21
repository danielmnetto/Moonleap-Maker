scr_inputget();

var _messages_length = array_length(messages);

if _messages_length > 1 {
  if key_right_pressed and message_index < _messages_length - 1 {
    play_sound_on_change_page();
    message_index += 1;
  } else if key_left_pressed and message_index > 0 {
    play_sound_on_change_page();
    message_index -= 1;
  }
}
if key_jump_pressed or key_start {
  play_sound_on_change_page();
  instance_destroy();
}
