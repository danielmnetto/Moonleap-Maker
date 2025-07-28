type = LEVEL_CURSOR_TYPE.CURSOR;

if collision_point(x, y, [oButtonMaker, oButtonMakerObj], false, true) {
  type = LEVEL_CURSOR_TYPE.FINGER;
}

if mouse_check_button(mb_right) and is_into_level_area() {
  type = LEVEL_CURSOR_TYPE.ERASER;
}