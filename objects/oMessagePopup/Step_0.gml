duration_frames = max(-1, duration_frames - 1);
if duration_frames == -1 {
  alpha = max(0, alpha - alpha_fade_speed);
}
if alpha == 0 {
  instance_destroy();
}
