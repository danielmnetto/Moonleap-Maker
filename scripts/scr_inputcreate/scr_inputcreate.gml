function scr_inputcreate() {
	gamepad_set_axis_deadzone(0, 0.3);
  
	key_right = 0;
	key_left = 0;
	key_right_pressed = 0;
	key_left_pressed = 0;
	key_down = 0;
	key_up = 0;
	key_jump_pressed = 0;
	key_jump = 0;
	key_start = 0;
  key_reset = 0;
	key_down_axis_pressed = 0;
	key_up_axis_pressed = 0;
	key_axis_pressed = 0;
	key_down_notpressed = 0;
  
  // Level Maker
  key_cursor_move_down = false;
  key_cursor_move_up = false;
  key_cursor_move_left = false;
  key_cursor_move_right = false;
  key_cursor_left_click_pressing = false;
  key_cursor_left_click_pressed = false;
  key_cursor_left_click_released = false;
  key_cursor_right_click_pressing = false;
  key_cursor_right_click_pressed = false;
  key_cursor_right_click_released = false;
  
  key_maker_toggle_test = false;
  key_maker_list_page_up = false;
  key_maker_list_page_down = false;
  key_maker_item_select_left = false;
  key_maker_item_select_right = false;
  key_maker_creator_menu = false;
}