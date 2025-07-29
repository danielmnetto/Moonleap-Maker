draw_set_font(oCamera.font);
draw_set_color(color.nice_white);

if not level_maker_is_editing() or instance_exists(oPauseMenu) {
	draw_sprite_ext(sPauseMaker,0,0,0,1,1,0,c_white,0.5)
}

draw_set_halign(fa_center)

// GET SELECTED OBJECT NAME
if current_layer == LEVEL_CURRENT_LAYER.OBJECTS {
	var object = obj[selected_object_type,selected_object_position]
	var object_name = is_undefined(object) ? "" : LANG[$ $"maker_object_{object_get_name(object.index)}"];

	var room_x_offset = 16;
	if global.level_maker_mouse_x > -room_x_offset 
		and global.level_maker_mouse_x < room_width + room_x_offset 
	{
		var object_name_x = (160 + global.level_maker_mouse_x * 3) / 4;
	
		draw_text(object_name_x, -20, object_name);
	}
}

draw_set_color(-1);
draw_set_halign(-1);