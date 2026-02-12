scr_inputget();

duration_frames = max(-1, duration_frames - 1);
input_interval_frames = max(-1, input_interval_frames - 1);

if (key_jump or key_start) and input_interval_frames == -1 and duration_frames >= 0 {
  duration_frames = -1;
}

if duration_frames == -1 {
  alpha = max(0, alpha - alpha_fade_speed);
}
if alpha == 0 {
  instance_destroy();
}
