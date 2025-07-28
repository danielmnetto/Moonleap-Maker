type = LEVEL_CURSOR_TYPE.CURSOR;

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

is_erasing = function() {
  return false;
};

draw_preview_object = function() {
  var _layer = oLevelMaker.current_layer;
  
  if _layer != LEVEL_CURRENT_LAYER.OBJECTS {
    return;
  }
  
  if not is_into_level_area() {
    return;
  }
  
  var _grid_tile_size = oLevelMaker.tile_size;
  var _preview_object = oLevelMaker.cursor_object_hovering;
  
  if is_undefined(_preview_object) {
    return;
  }

  var _preview_sprite = object_get_sprite(_preview_object.index),
    _preview_frame = 0,
    _preview_x = x div _grid_tile_size * _grid_tile_size,
    _preview_y = y div _grid_tile_size * _grid_tile_size,
    _preview_xscale = 1,
    _preview_yscale = 1,
    _preview_angle = image_angle,
    _preview_blend = c_white,
    _preview_alpha = 0.6;

  var _preview_frame_horizontal = _preview_object.preview_image_index_horizontal;
  var _preview_frame_vertical = _preview_object.preview_image_index_vertical;
    
  if not is_undefined(_preview_frame_horizontal) {
    _preview_frame = _preview_frame_horizontal;
    _preview_xscale = 1;
  }

  if not is_undefined(_preview_frame_vertical) {
    _preview_frame = _preview_frame_vertical;
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
  
  if not level_maker_is_editing() or _helper_text == "" {
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
}