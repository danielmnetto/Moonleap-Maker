/// @param {real} xx The horizontal position.
/// @param {real} yy The vertical position.
/// @param {bool} is_position_relative If true, the xx and yy positions are relative to the object position.
/// If false, they are relative to the room position. Default: true
/// @param {Array<Asset.GMObject>} included_objects An array of objects to included on collision check. Default: empty array
/// @param {Array<Asset.GMObject>} excluded_objects An array of objects to be excluded from collision check. Default: empty array

function has_collided(xx, yy, is_position_relative = true, included_objects = [], excluded_objects = []) {
	xx = (is_position_relative * x) + xx;
	yy = (is_position_relative * y) + yy;

	//var _will_wrap = false;
	//var _xx_wrap = xx;
	//var _yy_wrap = yy;
	//
	//if xx < 0 or xx > room_width or yy < 0 or yy > room_height {
		//_will_wrap = true;
		//if xx < 0 then _xx_wrap = xx + room_width;
	   //if xx > room_width then _xx_wrap = xx - room_width;
	   //if yy < 0 then _yy_wrap = yy + room_height;
	   //if yy > room_height then _yy_wrap = yy - room_height;
	//}
	
	// Excluded objects collision checking
	if place_meeting_wrap_room(xx, yy, excluded_objects)
	//or (_will_wrap and place_meeting(_xx_wrap, _yy_wrap, excluded_objects)) {
  {
		return false;
	}
	
	// Included objects collision checking
	if place_meeting_wrap_room(xx, yy, included_objects)
	//or (_will_wrap and place_meeting(_xx_wrap, _yy_wrap, included_objects)) {
  {
    return true;
  }
	
  // ========================================
	// Platforms' sides collision checking
  // ========================================
  
  // The oPlatGhost object is used exclusively on Moonleap Maker due to the 
  // player be able to rotate it.
  var _platform_collisions = instance_place_list_wrap_room(xx, yy, oPlatGhost);
  if _platform_collisions.total_collisions > 0 {
    
    // Check base collision
    var _list = _platform_collisions.lists.base;
    if platforms_meeting_offset(_list, 0, 0) {
      _platform_collisions.lists.destroy();
      return true;
    }
    
    // Check left collision
    _list = _platform_collisions.lists.left;
    if platforms_meeting_offset(_list, -room_width, 0) {
      _platform_collisions.lists.destroy();
      return true;
    }

    // Check right collision
    _list = _platform_collisions.lists.right;
    if platforms_meeting_offset(_list, room_width, 0) {
      _platform_collisions.lists.destroy();
      return true;
    }

    // Check top collision
    _list = _platform_collisions.lists.top;
    if platforms_meeting_offset(_list, 0, -room_height) {
      _platform_collisions.lists.destroy();
      return true;
    }

    // Check bottom collision
    _list = _platform_collisions.lists.bottom;
    if platforms_meeting_offset(_list, 0, room_height) {
      _platform_collisions.lists.destroy();
      return true;
    }
  }
  
  _platform_collisions.lists.destroy();
  
  
	//var platform_list = ds_list_create();
	//var platform_count = instance_place_list_wrap_room(xx, yy, oPlatGhost, platform_list, true);
  //
	//if platform_count > 0 {
		//var p = 0;
		//var collided = false;
		//repeat(platform_count) {
			//var platform = ds_list_find_value(platform_list, p);
			//
      //if platform_side_meeting(id, platform, xx + platform.x, yy + platform.y) {
        //ds_list_destroy(platform_list);
				//return true;
      //}
      
			//switch(platform.image_angle) {
				//case 90:
					//collided = bbox_right <= platform.bbox_left;
					//break;
				//case 180:
					//collided = bbox_top >= platform.bbox_bottom;
					//break;
				//case 270:
					//collided = bbox_left >= platform.bbox_right;
					//break;
				//default:
					//collided = bbox_bottom <= platform.bbox_top;
					//break;
			//}
			//
			//if collided {
				//ds_list_destroy(platform_list);
				//return true;
			//}
			
			//p++;
		//}
	//}
	
	//ds_list_clear(platform_list);
	//platform_count = instance_place_list_wrap_room(xx, yy, oPlatGhostL, platform_list, true);
	//if (platform_count > 0) {
		//var p = 0;
		//repeat(platform_count) {
			//var platform = ds_list_find_value(platform_list, p);
			//if bbox_right <= platform.bbox_left {
				//ds_list_destroy(platform_list);
				//return true;
			//}
			//p++;
		//}
	//}
	//
	//ds_list_clear(platform_list);
	//platform_count = instance_place_list_wrap_room(xx, yy, oPlatGhostR, platform_list, true);
	//if (platform_count > 0) {
		//var p = 0;
		//repeat(platform_count) {
			//var platform = ds_list_find_value(platform_list, p);
			//if bbox_left >= platform.bbox_right {
				//ds_list_destroy(platform_list);
				//return true;
			//}
			//p++;
		//}
	//}
	//
	//ds_list_clear(platform_list);
	//platform_count = instance_place_list_wrap_room(xx, yy, oPlatGhostInv, platform_list, true);
	//if (platform_count > 0) {
		//var p = 0;
		//repeat(platform_count) {
			//var platform = ds_list_find_value(platform_list, p);
			//if bbox_top >= platform.bbox_bottom {
				//ds_list_destroy(platform_list);
				//return true;
			//}
			//p++;
		//}
	//}
	
	//if _will_wrap {
		//ds_list_clear(platform_list);
		//platform_count = instance_place_list_wrap_room(_xx_wrap, _yy_wrap, oPlatGhostL, platform_list, true);
		//if (platform_count > 0) {
			//var p = 0;
			//repeat(platform_count) {
				//var platform = ds_list_find_value(platform_list, p);
				//if bbox_right <= platform.bbox_left {
					//ds_list_destroy(platform_list);
					//return true;
				//}
				//p++;
			//}
		//}
	//
		//ds_list_clear(platform_list);
		//platform_count = instance_place_list_wrap_room(_xx_wrap, _yy_wrap, oPlatGhostR, platform_list, true);
		//if (platform_count > 0) {
			//var p = 0;
			//repeat(platform_count) {
				//var platform = ds_list_find_value(platform_list, p);
				//if bbox_left >= platform.bbox_right {
					//ds_list_destroy(platform_list);
					//return true;
				//}
				//p++;
			//}
		//}
	//
		//ds_list_clear(platform_list);
		//platform_count = instance_place_list_wrap_room(_xx_wrap, _yy_wrap, oPlatGhostInv, platform_list, true);
		//if (platform_count > 0) {
			//var p = 0;
			//repeat(platform_count) {
				//var platform = ds_list_find_value(platform_list, p);
				//if bbox_top >= platform.bbox_bottom {
					//ds_list_destroy(platform_list);
					//return true;
				//}
				//p++;
			//}
		//}
	//}
	
	//ds_list_destroy(platform_list);
	
	if place_meeting_wrap_room(xx, yy, oSolid)
	//or (_will_wrap and place_meeting(_xx_wrap, _yy_wrap, oSolid))  
  {
		return true;
	}
	
	return false;
}

function platform_side_meeting(inst, platform, x_offset, y_offset) {
  switch(platform.image_angle) {
    case 90:
      return (inst.bbox_right + x_offset) <= platform.bbox_left;
    case 180:
      return (inst.bbox_top + y_offset) >= platform.bbox_bottom;
    case 270:
      return (inst.bbox_left + x_offset) >= platform.bbox_right;
    default:
      return (inst.bbox_bottom + y_offset) <= platform.bbox_top;
  }
}

function platforms_meeting_offset(list, x_offset, y_offset) {
  var _count_collisions = ds_list_size(list);
  
  if _count_collisions <= 0 {
    return false;
  }
  
  for (var i = 0; i < _count_collisions; i++) {
    var _platform = ds_list_find_value(list, i);
    
    if platform_side_meeting(id, _platform, x_offset, y_offset) {
      return true;
    }
  }
  
  return false;
}
