/// @desc Returns a struct of key bindings. 
function input_get_bindings() {
  var _gamepad_deadzone = 0.3;
  
  return {
    // Player inputs
    move_right: keyboard_check(ord("D"))
                or keyboard_check(vk_right)
                or gamepad_button_check(0, gp_padr)
                or gamepad_axis_value(0, gp_axislh) > _gamepad_deadzone
                or obDirection.key_right,
                
    move_left: keyboard_check(ord("A"))
                or keyboard_check(vk_left) 
                or gamepad_button_check(0, gp_padl)
                or (gamepad_axis_value(0, gp_axislh) < -_gamepad_deadzone)
                or obDirection.key_left,
                
    jump: keyboard_check_pressed(vk_space)
          or keyboard_check_pressed(ord("X"))
          or keyboard_check_pressed(ord("Z"))
          or gamepad_button_check_pressed(0, gp_face1)
          or gamepad_button_check_pressed(0, gp_face2)
          or gamepad_button_check_pressed(0, gp_face3)
          or obJump.key_jump,
          
    climb: keyboard_check(vk_space)
          or keyboard_check(ord("X"))
          or keyboard_check(ord("Z"))
          or gamepad_button_check(0, gp_face1)
          or gamepad_button_check(0, gp_face2)
          or gamepad_button_check(0, gp_face3)
          or obJump.key_jump,
          
    change_skin: keyboard_check(ord("S"))
                  or keyboard_check(vk_down)
                  or gamepad_button_check(0, gp_padd)
                  or obDirection.key_down,
                  
    reset: keyboard_check_pressed(ord("R"))
            or gamepad_button_check_pressed(0, gp_select),
    
    // Menu Inputs
    ui_menu: keyboard_check_pressed(vk_enter)
              or gamepad_button_check_pressed(0, gp_start)
              or oBpause.key_start,

    ui_select: keyboard_check_pressed(vk_space)
                or keyboard_check_pressed(ord("X"))
                or keyboard_check_pressed(ord("Z"))
                or gamepad_button_check_pressed(0, gp_face1)
                or gamepad_button_check_pressed(0, gp_face2)
                or gamepad_button_check_pressed(0, gp_face3)
                or obJump.key_jump,
    
    ui_nav_up: keyboard_check(ord("W"))
                or keyboard_check(vk_up)
                or gamepad_button_check(0, gp_padu)
                or gamepad_axis_value(0, gp_axislv) < -_gamepad_deadzone
                or obDirection.key_up,
                
    ui_nav_up_pressed: keyboard_check_pressed(ord("W"))
                or keyboard_check_pressed(vk_up)
                or gamepad_button_check_pressed(0, gp_padu)
                or obDirection.key_up,

    ui_nav_down: keyboard_check(ord("S"))
                  or keyboard_check(vk_down)
                  or gamepad_button_check(0, gp_padd)
                  or gamepad_axis_value(0, gp_axislv) > _gamepad_deadzone
                  or obDirection.key_down,
    
    ui_nav_down_pressed: keyboard_check_pressed(ord("S"))
                          or keyboard_check_pressed(vk_down)
                          or gamepad_button_check_pressed(0, gp_padd)
                          or obDirection.key_down,
    
    ui_nav_left: keyboard_check(ord("A"))
                  or keyboard_check(vk_left)
                  or gamepad_button_check(0, gp_padl)
                  or gamepad_axis_value(0, gp_axislh) < -_gamepad_deadzone
                  or obDirection.key_left,
                  
    ui_nav_left_pressed: keyboard_check_pressed(ord("A"))
                          or keyboard_check_pressed(vk_left)
                          or gamepad_button_check_pressed(0, gp_padl)
                          or gamepad_axis_value(0, gp_axislh) < -_gamepad_deadzone
                          or obDirection.key_left,
                          
    ui_nav_right: keyboard_check(ord("D"))
                  or keyboard_check(vk_right)
                  or gamepad_button_check(0, gp_padr)
                  or gamepad_axis_value(0, gp_axislh) > _gamepad_deadzone
                  or obDirection.key_right,
                  
    ui_nav_right_pressed: keyboard_check_pressed(ord("D"))
                            or keyboard_check_pressed(vk_left)
                            or gamepad_button_check_pressed(0, gp_padl)
                            or gamepad_axis_value(0, gp_axislh) > -_gamepad_deadzone
                            or obDirection.key_right,
  };
}