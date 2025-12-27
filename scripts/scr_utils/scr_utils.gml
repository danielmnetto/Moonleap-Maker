/// @desc Safe struct value loading
function struct_read(_struct, _property, _default) {
	var _val = variable_struct_get(_struct, _property);
	return is_undefined(_val) ? _default : _val;
}

function struct_clone(_struct) {
	if not is_struct(_struct) then return undefined;
	
	var _new_struct = {};
	var _names = variable_struct_get_names(_struct);
	
	for (var i = 0; i < array_length(_names); i++) {
		var _name = array_get(_names, i);
		var _value = variable_struct_get(_struct, _name);
		
		// If value is struct, apply recursion
		if is_struct(_value) {
			_value = struct_clone(_value);
		} else if is_method(_value) {
			// If value is method, set method reference to the new struct and return it.
			_value = method(_new_struct, _value);
		}
		
		variable_struct_set(_new_struct, _name, _value);
	}
	
    return _new_struct;
}

function room_is(_room_or_room_array) {
    if not is_array(_room_or_room_array) {
        return room == _room_or_room_array;
    }

    for (var i = 0; i < array_length(_room_or_room_array); i++) {
        var _current_room = array_get(_room_or_room_array, i);
    
        if room == _current_room then return true;
    }

    return false;
}

function audio_is_playing_any(_audio_array) {
    for (var i = 0; i < array_length(_audio_array); i++) {
        var _audio = array_get(_audio_array, i);
    
        if audio_is_playing(_audio) then return true;
    }

    return false;
}

function instance_exists_any(_instance_array) {
    for (var i = 0; i < array_length(_instance_array); i++) {
        var _instance = array_get(_instance_array, i);
    
        if instance_exists(_instance) then return true;
    }

    return false;
}

function object_set_room_wrapping() {
   if x < 0 then x += room_width; 
   if x > room_width then x -= room_width;
   if y < 0 then y += room_height;
   if y > room_height then y -= room_height;
}

function object_is_outside_room() {
	return x < 0 or x >= room_width or y < 0 or y >= room_height;
}

function set_pallete_index() {
	if instance_exists(oGrassDay) {
		palette_index = 0;
	} else if instance_exists(oCloudDay) {
		palette_index = 1;
	} else if instance_exists(oFlowerDay) {
		palette_index = 2;
	} else if instance_exists(oSpaceDay) {
		palette_index = 3;
	} else if instance_exists(oDunDay) {
		palette_index = 4;
	}
}

function in_hub_view() {
	var _x1 = min(oCamera.hubx,oCamera.hubx_prev);
	var _y1 = min(oCamera.huby,oCamera.huby_prev);
	var _x2 = max(oCamera.hubx,oCamera.hubx_prev)+oCamera.view_width;
	var _y2 = max(oCamera.huby,oCamera.huby_prev)+oCamera.view_height;
	return rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, _x1, _y1, _x2, _y2);
}

function is_at_hub() {
	return room_is([Room100]);
}

/// @description Checks whether the current OS is one of the items in the array.
/// @param {Array<Constant.OperatingSystem>} os_type_array 
function is_os_type_any(_os_type_array) {
  return array_any(_os_type_array, function(_os_type) { return os_type == _os_type });
}

/// @desc Checks whether the current OS is desktop.
function is_on_desktop() {
	return is_os_type_any([os_windows, os_linux, os_macosx]);
}

/// @desc Checks whether the current OS is console.
function is_on_console() {
	return is_os_type_any([os_ps4, os_ps5, os_xboxseriesxs, os_gdk, os_switch, os_switch2]);
}

/// @desc Checks whether the current OS is mobile.
function is_on_mobile() {
	return is_os_type_any([os_android, os_ios]);
}

function draw_text_shadow(_x, _y, _text, _shadow_offset_x, _shadow_offset_y, _shadow_color) {
	var prev_color = draw_get_color();
	
	draw_set_color(_shadow_color);
	draw_text(_x + _shadow_offset_x, _y + _shadow_offset_y, _text);
	draw_set_color(prev_color);
	draw_text(_x, _y, _text);
}

/// @description Calls the transition effects and redirects to the room target.
/// @param {Asset.GMRoom} room_target The room to transit.
function room_transit(_room_target, _layer = layer) {
	var _transition = instance_create_layer(0, 0, _layer, oTransition);
	_transition.target_room = _room_target;
}

/// @desc Gets the object's sprite horizontal center regardless the sprite origin.
/// @param {Asset.GMObject} _object The object to find the sprite's center.
function object_get_sprite_center_x(_object) {
  with(_object) {
    return x - sprite_xoffset + sprite_width / 2;
  }
}

/// @desc Gets the object's sprite vertical center regardless the sprite origin.
/// @param {Asset.GMObject} _object The object to find the sprite's center.
function object_get_sprite_center_y(_object) {
  with(_object) {
    return y - sprite_yoffset + sprite_height / 2;
  }
}

/// @desc Formats a string to be compatible to files' names.
/// @param {string} _str String to be formatted.
function string_filename_create(_str) {
  var _new_name = _str;
  
  // Removes the start and end spaces.
  _new_name = string_trim(_new_name);
  
  // The inner spaces are replaced by underscores.
  _new_name = string_replace_all(_new_name, " ", "_"); 
  
  // Lowercase to all letters.
  _new_name = string_lower(_new_name);
  
  // Removes all symbols from the name
  for (var i = 32; i <= 255; i++) {
    if (i >= 48 and i <= 57)
    or (i >= 65 and i <= 90)
    or (i == 95)
    or (i >= 97 and i <= 122)
    or (i >= 192 and i <= 214)
    or (i >= 216 and i <= 246)
    or (i >= 248 and i <= 255) {
      continue;
    }
    _new_name = string_replace_all(_new_name, chr(i), "");
  }
  
  return _new_name;
}