if ani > 0 {
  draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
} else {
  draw_self();
}