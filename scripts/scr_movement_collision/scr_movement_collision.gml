enum PLATFORM_ANGLE {
  TOP = 0,
  LEFT = 90,
  BOTTOM = 180,
  RIGHT = 270
}

global.rooms_to_ignore_wrap = [];

/// @param {real} xx The horizontal position.
/// @param {real} yy The vertical position.
/// @param {bool} is_position_relative If true, the xx and yy positions are relative to the object position.
/// If false, they are relative to the room position. Default: true
/// @param {Array<Asset.GMObject>} included_objects An array of objects to included on collision check. Default: empty array
/// @param {Array<Asset.GMObject>} excluded_objects An array of objects to be excluded from collision check. Default: empty array

function has_collided(xx, yy, is_position_relative = true, included_objects = [], excluded_objects = []) {
	xx = (is_position_relative * x) + xx;
	yy = (is_position_relative * y) + yy;
  
  return __collided_wrap_room(xx, yy, included_objects, excluded_objects);
}

function __collided_wrap_room(xx, yy, included_objects = [], excluded_objects = []) {
  // ======================================================
	// Excluded objects collision checking
  // ======================================================
	if place_meeting_wrap_room(xx, yy, excluded_objects) {
		return false;
	}
	
  // ======================================================
	// Included objects collision checking
  // ======================================================
	if place_meeting_wrap_room(xx, yy, included_objects) {
    return true;
  }
	
  // ======================================================
	// Platform objects and their sides collision checking
  // ======================================================

  var _platform_collisions = instance_place_list_wrap_room(xx, yy, oPlatGhost);
  if _platform_collisions.total_collisions > 0 and (
        __platforms_meeting_offset(_platform_collisions.lists.base, 0, 0)
    or  __platforms_meeting_offset(_platform_collisions.lists.left, -room_width, 0)
    or  __platforms_meeting_offset(_platform_collisions.lists.right, room_width, 0)
    or  __platforms_meeting_offset(_platform_collisions.lists.top, 0, -room_height)
    or  __platforms_meeting_offset(_platform_collisions.lists.bottom, 0, room_height)
  ) {
    _platform_collisions.lists.destroy();
    return true;
  }
  _platform_collisions.lists.destroy();
  
  var _angle = PLATFORM_ANGLE.LEFT;
  _platform_collisions = instance_place_list_wrap_room(xx, yy, oPlatGhostL);
  if _platform_collisions.total_collisions > 0 and (
        __platforms_meeting_offset(_platform_collisions.lists.base, 0, 0, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.left, -room_width, 0, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.right, room_width, 0, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.top, 0, -room_height, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.bottom, 0, room_height, _angle)
  ) {
    _platform_collisions.lists.destroy();
    return true;
  }
  _platform_collisions.lists.destroy();

  _angle = PLATFORM_ANGLE.BOTTOM;
  _platform_collisions = instance_place_list_wrap_room(xx, yy, oPlatGhostInv);
  if _platform_collisions.total_collisions > 0 and (
        __platforms_meeting_offset(_platform_collisions.lists.base, 0, 0, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.left, -room_width, 0, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.right, room_width, 0, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.top, 0, -room_height, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.bottom, 0, room_height, _angle)
  ) {
    _platform_collisions.lists.destroy();
    return true;
  }
  _platform_collisions.lists.destroy();

  _angle = PLATFORM_ANGLE.RIGHT;
  _platform_collisions = instance_place_list_wrap_room(xx, yy, oPlatGhostR);
  if _platform_collisions.total_collisions > 0 and (
        __platforms_meeting_offset(_platform_collisions.lists.base, 0, 0, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.left, -room_width, 0, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.right, room_width, 0, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.top, 0, -room_height, _angle)
    or  __platforms_meeting_offset(_platform_collisions.lists.bottom, 0, room_height, _angle)
  ) {
    _platform_collisions.lists.destroy();
    return true;
  }
  _platform_collisions.lists.destroy();

  // ======================================================
	// Other solid objects
  // ======================================================
	if place_meeting_wrap_room(xx, yy, oSolid) {
		return true;
	}
	
	return false;
}

function __one_way_meeting_from_angle(inst, platform, x_offset, y_offset, angle) {
  switch(angle) {
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

function __one_way_meeting_from_platform_angle(inst, platform, x_offset, y_offset) {
  return __one_way_meeting_from_angle(inst, platform, x_offset, y_offset, platform.image_angle);
}

/// @param {Id.DSList} list List of all collided platform instances.
/// @param {real} x_offset The X offset from current instance's horizontal position.
/// @param {real} y_offset The Y offset from current instance's vertical position.
/// @param {real} angle The angle to check one way collision with the collided instances. If not specified, all angles will be checked.
function __platforms_meeting_offset(list, x_offset, y_offset, angle = undefined) {
  var _count_collisions = ds_list_size(list);
  
  if _count_collisions <= 0 {
    return false;
  }
  
  for (var i = 0; i < _count_collisions; i++) {
    var _platform = ds_list_find_value(list, i);
    
    if not is_undefined(angle)
    and __one_way_meeting_from_angle(id, _platform, x_offset, y_offset, angle) {
      return true;
    }
    
    if __one_way_meeting_from_platform_angle(id, _platform, x_offset, y_offset) {
      return true;
    }
  }
  
  return false;
}
