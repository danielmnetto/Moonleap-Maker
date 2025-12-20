scr_inputget();

if key_jump_pressed or key_start {
  audio_play_sfx(sndUiChange, false, -18.3, 1);
  instance_destroy();
}
