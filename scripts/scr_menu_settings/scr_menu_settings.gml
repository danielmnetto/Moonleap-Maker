/// @desc The constructor of an option for a menu.
/// @param {string|Function} label The menu label. Can be a string for hardcoded label or a function to return a dynamic label.
/// @param {string|Function} description OPTIONAL. The description to display at the window footer. Can be a string for hardcoded description or a function to return a dynamic description.
function MenuOptionBase(_label, _description = undefined) constructor {
  label = _label;
  description = _description;
  is_dangerous = false;
  can_play_select_sound = true;

  get_label = function() {
    if is_method(label) {
      return label();
    }
    return label;
  };

  get_description = function() {
    if is_method(description) {
      return description();
    }
    return description;
  };
}

/// @param {string|Function} label The menu label. Can be a string for hardcoded label or a function to return a dynamic label.
/// @param {Function} action The action when this option is selected.
/// @param {string|Function} description OPTIONAL. The description to display at the window footer. Can be a string for hardcoded description or a function to return a dynamic description.
function MenuOptionActionCall(_label, _action, _description = undefined): MenuOptionBase(_label, _description) constructor {
  action = _action;

  trigger_action = function() {
    if not is_method(action) {
      return;
    }
    action();
  };
}

/// @param {string|Function} label The menu label. Can be a string for hardcoded label or a function to return a dynamic label.
/// @param {string} menu_name The menu which will be changed when selecting this option.
/// @param {Function} action OPTIONAL. The action when this option is selected.
/// @param {string|Function} description OPTIONAL. The description to display at the window footer. Can be a string for hardcoded description or a function to return a dynamic description.
function MenuOptionMenuCall(_label, _menu_name, _action = undefined, _description = undefined): MenuOptionActionCall(_label, _action, _description) constructor {
  menu_name = _menu_name;
}

/// @param {string|Function} label The menu label. Can be a string for hardcoded label or a function to return a dynamic label.
/// @param {Array<any>} values The values contained in this option.
/// @param {real|Function} value_index The selected value position into the `values` array. Can be a real number for hardcoded value or a function to return a dynamic value.
/// @param {Function} action The action when this option has its value changed.
/// @param {string|Function} description OPTIONAL. The description to display at the window footer. Can be a string for hardcoded description or a function to return a dynamic description.
function MenuOptionValueToggle(_label, _values, _value_index, _action, _description): MenuOptionActionCall(_label, _action, _description) constructor {
  values = _values;
  value_index = _value_index;
}

/// @desc Calls the menu controller with given menus and configuration.
/// @param {Struct} menu_list_struct The menus list in struct format.
/// @param {string} first_menu_name The name of the first menu to display on screen.
/// @param {bool} use_draw_end Whether the menu will be drawn in Draw End event or not. Default: `false`.
/// @param {bool} fill_background Whether the entire background will be filled. Default: `false`.
/// @param {bool} show_game_version Whether the game version will be displayed at bottom right corner with the menu. Default: `false`.
function call_menu(_menu_list_struct, _first_menu_name, _use_draw_end = false, _fill_background = false, _show_game_version = false) {
  var _menu_controller = instance_create_depth(0, 0, -16000, oMenuController);
  _menu_controller.menus = _menu_list_struct;
  _menu_controller.current_menu_name = _first_menu_name;
  _menu_controller.use_draw_end = _use_draw_end;
  _menu_controller.fill_background = _fill_background;
  _menu_controller.show_game_version = _show_game_version;
}