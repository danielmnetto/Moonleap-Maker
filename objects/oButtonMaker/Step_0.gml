scr_inputget();

var _is_left_pressing = mouse_check_button(mb_left),
    _has_left_pressed = mouse_check_button_pressed(mb_left),
    _is_mouse_hover = collision_point(global.level_maker_mouse_x, global.level_maker_mouse_y, self, false, false);

// Button shaking effect
drawx = random_range(-holding_button_frames, holding_button_frames);
drawy = random_range(-holding_button_frames, holding_button_frames);

if has_cleared_level {
	drawx = 0;
	drawy = 0;
}

drawtarget = 0;

// Lerp play button position to be visible in play state
if image_index == LEVEL_MAKER_BUTTON_TYPE.TEST_LEVEL {
    //editor is opened
	if level_maker_is_editing() {
		x = lerp(x, start_pos_x, 0.2);
		y = lerp(y, start_pos_y, 0.2);
		
		image_xscale = lerp(image_xscale, 1, 0.2);
		image_yscale = image_xscale;
	} else {
		x = lerp(x, (32-small_size) / 2, 0.2);
		y = lerp(y, room_height - 16 - small_size / 2, 0.2);

		image_xscale = lerp(image_xscale,small_size/32, 0.2);
		image_yscale = image_xscale;
	}
} else if not level_maker_is_editing()
  or instance_exists(oPauseUI) {
  exit;
}

update_hover_text();

if _is_mouse_hover and _is_left_pressing { 
  drawplus = 2;
} else {
	holding_button_frames = 0; 
	has_cleared_level = false;
	_has_left_pressed = false;
}

// ===================================
// BUTTON ACTIONS BY USING SHORTCUTS
// ===================================

if image_index == LEVEL_MAKER_BUTTON_TYPE.PAGE_UP
and (key_up or mouse_wheel_up()) {
	action_items_page_up();
}

if image_index == LEVEL_MAKER_BUTTON_TYPE.PAGE_DOWN
and (key_down or mouse_wheel_down()) {
	action_items_page_down();
}

if image_index == LEVEL_MAKER_BUTTON_TYPE.SAVE_LEVEL
and keyboard_check(vk_control)
and keyboard_check_pressed(ord("S")) {
  action_save_level();
}

if image_index == LEVEL_MAKER_BUTTON_TYPE.LOAD_LEVEL
and keyboard_check(vk_control)
and keyboard_check_pressed(ord("O")) {
  action_load_level();
}

// Before, the shortcut was 'SPACEBAR' to test the level.
// It was changed to 'F5' because it was conflicting with
// player's jump input.
if image_index == LEVEL_MAKER_BUTTON_TYPE.TEST_LEVEL
and keyboard_check_pressed(vk_f5) {
  action_test_level();
}

// ===================================
// BUTTON ACTIONS BY PRESSING IT
// ===================================

if image_index == LEVEL_MAKER_BUTTON_TYPE.CLEAR_LEVEL {
	action_clear_level();
}

if _has_left_pressed and _is_mouse_hover {
  switch(image_index) {
    case LEVEL_MAKER_BUTTON_TYPE.PAGE_UP:
      action_items_page_up();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.PAGE_DOWN:
      action_items_page_down();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.MENU:
      action_menu();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.SAVE_LEVEL:
      action_save_level();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.LOAD_LEVEL:
      action_load_level();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.TEST_LEVEL:
      action_test_level();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.HELP:
      action_help();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.CHANGE_STYLE:
      action_change_style();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.ERASER:
      action_eraser();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.CHANGE_LAYER:
      action_change_layer();
    break;
  }
}