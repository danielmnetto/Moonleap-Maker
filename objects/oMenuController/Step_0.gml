if is_disabled {
  exit;
}

oCamera.pause_delay = 10;

var _menus_length = struct_get_names(menus);

if instance_exists_any([oIntro, oTransition, oMessagePopup])
or array_length(_menus_length) == 0 {
  exit;
}

scr_inputget();
check_debugging_mode();

__handle_options_selection();
__handle_option_activation();
__handle_option_value_toggling();
