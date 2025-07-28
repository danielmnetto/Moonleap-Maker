draw_preview_object();
draw_preview_tile();

//// Draw item preview on cursor
//if current_layer == LEVEL_CURRENT_LAYER.OBJECTS {
  
//	if not is_erasing()
//	and is_into_level_area() 
//	and level_maker_is_editing()
//	and not instance_exists(oPauseMenu)
//	and not is_undefined(cursor_object_hovering) //sprite_exists(sprite_index)
//	and not has_object_below_cursor {
//		var _new_image_index = 0;
//		var _new_x_scale = image_xscale;
//		var _new_y_scale = image_yscale;
//		var sprite = object_get_sprite(cursor_object_hovering.index);
//		var _preview_index_horizontal = cursor_object_hovering.preview_image_index_horizontal;
//		var _preview_index_vertical = cursor_object_hovering.preview_image_index_vertical;
				
//		if not is_undefined(_preview_index_horizontal) {
//			_new_image_index = image_xscale == -1 ? _preview_index_horizontal : 0;
//			_new_x_scale = 1;
//		}
				
//		if not is_undefined(_preview_index_vertical) {
//			_new_image_index = image_yscale == -1 ? _preview_index_vertical : 0;
//			_new_y_scale = 1;
//		}
	
//		var alpha = 0.6;
//		draw_sprite_ext(sprite_index, _new_image_index, x + item_preview_offset_x, y + item_preview_offset_y, _new_x_scale, _new_y_scale, image_angle, c_white, alpha);
//	}
//} else {
//	if cursor != LEVEL_CURSOR_TYPE.ERASER
//	and is_cursor_inside_level 
//   and not is_undefined(selected_tile)
//	and level_maker_is_editing() 
//	and not instance_exists(oPauseMenu) {
//		var _x = floor(x / tileset_size) * tileset_size;
//		var _y = floor(y / tileset_size) * tileset_size;

//		draw_set_alpha(0.6);
//		selected_tile.draw_sprite_cursor(_x, _y);
//		draw_set_alpha(1);
//	}
//}