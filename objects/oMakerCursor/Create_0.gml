type = LEVEL_CURSOR_TYPE.CURSOR;

input = {
  rotate: function() {
    return keyboard_check_pressed(ord("Z"));
  },
  flip_mirror: function() {
    return keyboard_check_pressed(ord("X"));
  },
};

object_transform = {
  x: 0,
  y: 0,
  xscale: 1,
  yscale: 1,
  angle: 0
};

helper_text = {
  content: "",
  shadow_position: {
    x: 0,
    y: 2
  },
  color: {
    text: make_color_rgb(170, 255, 255),
    shadow: make_color_rgb(0, 0, 72),
  }
};

is_into_level_area = function() {
  return x > 0 and x < room_width and y > 0 and y < room_height;
};

update_cursor_type = function() {
  if type == LEVEL_CURSOR_TYPE.ERASER {
    return;
  }
  
  var _layer = oLevelMaker.current_layer;
  var _selected_object = oLevelMaker.selected_object;
  var _object_hover = oLevelMaker.object_grid_hovering
  
  type = LEVEL_CURSOR_TYPE.CURSOR;

  if collision_point(x, y, [oButtonMaker, oButtonMakerObj], false, true) {
    type = LEVEL_CURSOR_TYPE.FINGER;
  }
	
  if _layer == LEVEL_CURRENT_LAYER.OBJECTS
  and _object_hover != -1 {
  	type = not is_undefined(_selected_object) and _selected_object.has_tag("is_holdable") ? LEVEL_CURSOR_TYPE.CANCEL : LEVEL_CURSOR_TYPE.FINGER;
  }
};

reset_object_rotation_and_scaling = function() {
  object_transform.xscale = 1;
  object_transform.yscale = 1;
  object_transform.angle = 0;
};

check_input_to_rotate_object = function() {
  var _layer = oLevelMaker.current_layer;
  
  if is_undefined(_layer != LEVEL_CURRENT_LAYER.OBJECTS) {
    return;
  }
  
  var _selected_object = oLevelMaker.selected_object;
  
  if is_undefined(_selected_object) {
    return;
  }
  
  if not _selected_object.has_tag("can_spin") {
    object_transform.angle = 0;
    return;
  }
  
	if not input.rotate() {
    return;
	}
  
  object_transform.angle += 90;
	if object_transform.angle >= 360 {
    object_transform.angle = 0;
  }
	audio_play_sfx(sndPress, false, -5, 13);
};

check_input_to_scale_object = function() {
  var _layer = oLevelMaker.current_layer;
  
  if is_undefined(_layer != LEVEL_CURRENT_LAYER.OBJECTS) {
    return;
  }
  
  var _selected_object = oLevelMaker.selected_object;
  
  if is_undefined(_selected_object) {
    return;
  }
  
  if not _selected_object.has_tag("can_flip") {
		object_transform.xscale = 1;
    return;
	}
  
  if not input.flip_mirror() {
    return;
	}
  
  if _selected_object.has_tag("is_vertical") {
		object_transform.yscale *= -1;
	} else {
		object_transform.xscale *= -1;
	}
	audio_play_sfx(sndPress, false, -5, 13);
};

update_object_cursor_position = function() {
  var _layer = oLevelMaker.current_layer;
  
  if is_undefined(_layer != LEVEL_CURRENT_LAYER.OBJECTS) {
    return;
  }
  
  var _selected_object = oLevelMaker.selected_object;
  var _object_tile_size = oLevelMaker.tile_size;
  var _room_tile_width = oLevelMaker.room_tile_width;
  var _room_tile_height = oLevelMaker.room_tile_height;
  var _tile_scale = not is_undefined(_selected_object) and _selected_object.has_tag("grid_16") ? 2 : 1;
  var _selected_object_sprite = -1;
  
  if not is_undefined(_selected_object) {
    _selected_object_sprite = object_get_sprite(_selected_object.index);
  }

  var _object_width = 1;
  var _object_height = 1;
  var _sprite_offset_x = _selected_object_sprite == -1 ? 0 : sprite_get_xoffset(_selected_object_sprite);
  var _sprite_offset_y = _selected_object_sprite == -1 ? 0 : sprite_get_yoffset(_selected_object_sprite);

  var _size = is_undefined(_selected_object) ? [1, 1, 0, 0] : _selected_object.get_size(_object_tile_size, _object_width, _object_height);

  _object_width = _size[0];
  _object_height = _size[1];
  _sprite_offset_x = _size[2];
  _sprite_offset_y = _size[3];

  var _selected_object_mouse_tile_x = round((x - _object_width * _object_tile_size / 2) / (_tile_scale * _object_tile_size)) * _tile_scale;
  var _selected_object_mouse_tile_y = round((y - _object_height * _object_tile_size / 2) / (_tile_scale * _object_tile_size)) * _tile_scale;

  _selected_object_mouse_tile_x = clamp(_selected_object_mouse_tile_x, 0, _room_tile_width - _object_width);
  _selected_object_mouse_tile_y = clamp(_selected_object_mouse_tile_y, 0, _room_tile_height - _object_height);

  var _new_offset = oLevelMaker.rotate_object_offset(_object_width, _object_height, _sprite_offset_x, _sprite_offset_y, object_transform.angle);

  _sprite_offset_x = _new_offset[0];
  _sprite_offset_y = _new_offset[1];

  //placing objects with centered visuals
  object_transform.x = _selected_object_mouse_tile_x * _object_tile_size + _sprite_offset_x;
  object_transform.y = _selected_object_mouse_tile_y * _object_tile_size + _sprite_offset_y;
};

set_object_in_level = function() {
  
};

set_tile_in_level = function() {
  
};

draw_preview_object = function() {
  var _object_hover = oLevelMaker.cursor_object_hovering;
  var _has_object_below_cursor = oLevelMaker.has_object_below_cursor;
  var _layer = oLevelMaker.current_layer;
  
  if instance_exists(oPauseMenu)
  or not level_maker_is_editing()
  or is_undefined(_object_hover)
  or _has_object_below_cursor
  or not is_into_level_area()
  or type == LEVEL_CURSOR_TYPE.ERASER 
  or _layer != LEVEL_CURRENT_LAYER.OBJECTS {
    return;
  }

  var _preview_object = oLevelMaker.cursor_object_hovering;
  
  if is_undefined(_preview_object) {
    return;
  }
  
  var _grid_tile_size = oLevelMaker.tile_size;
  var _preview_sprite = object_get_sprite(_preview_object.index),
      _preview_frame = 0,
      _preview_frame_horizontal = _preview_object.preview_image_index_horizontal,
      _preview_frame_vertical = _preview_object.preview_image_index_vertical,
      _preview_x = object_transform.x,
      _preview_y = object_transform.y,
      _preview_xscale = object_transform.xscale,
      _preview_yscale = object_transform.yscale,
      _preview_angle = object_transform.angle,
      _preview_blend = c_white,
      _preview_alpha = 0.6;

  if not is_undefined(_preview_frame_horizontal) {
    _preview_frame = object_transform.xscale == -1 ? _preview_frame_horizontal : 0;
    _preview_xscale = 1;
  }

  if not is_undefined(_preview_frame_vertical) {
    _preview_frame = object_transform.yscale == -1 ? _preview_frame_vertical : 0;
    _preview_yscale = 1;
  }

  draw_sprite_ext(_preview_sprite, _preview_frame, _preview_x, _preview_y, _preview_xscale, _preview_yscale, _preview_angle, _preview_blend, _preview_alpha);
};

draw_preview_tile = function() {
  var _layer = oLevelMaker.current_layer;
  
  if _layer == LEVEL_CURRENT_LAYER.OBJECTS {
    return;
  }
  
  if not is_into_level_area() {
    return;
  }
  
  var _preview_tile = oLevelMaker.selected_tile;
  
  if is_undefined(_preview_tile) {
    return;
  }
  
  var _preview_tile_size = oLevelMaker.tileset_size;
  var _x = x div _preview_tile_size * _preview_tile_size;
	var _y = y div _preview_tile_size * _preview_tile_size;
  var _preview_alpha = 0.6;

	draw_set_alpha(_preview_alpha);
  
	_preview_tile.draw_sprite_cursor(_x, _y);
  
	draw_set_alpha(1);
};

draw_helper_text = function() {
  var _helper_text = oLevelMaker.hover_text;
  
  if not level_maker_is_editing() {
    return;
  }
  
  if _helper_text == "" {
    return;
  }
  
  var _x = x;
  var _y = y;
  var _x_offset_right = 14;
  var _x_offset_left = 7;

  draw_set_color(helper_text.color.text);
  
  if x < room_width / 2 {
  	draw_set_halign(fa_left)
  	draw_text_shadow(_x + _x_offset_right, _y, _helper_text, helper_text.shadow_position.x, helper_text.shadow_position.y, helper_text.color.shadow);
  } else {
  	draw_set_halign(fa_right)
  	draw_text_shadow(_x - _x_offset_left, _y, _helper_text, helper_text.shadow_position.x, helper_text.shadow_position.y, helper_text.color.shadow);
  }
  
  draw_set_color(-1);
};

draw_cursor = function() {
  draw_sprite(sCursor, type, x, y);
};