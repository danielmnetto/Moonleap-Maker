function place_meeting_wrap(xx, yy, obj, left, right, top, bottom) {
  var _base = place_meeting(xx, yy, obj);
  var _left = place_meeting(xx + -abs(left), yy, obj);
  var _right = place_meeting(xx + abs(right), yy, obj);
  var _top = place_meeting(xx, yy + -abs(top), obj);
  var _bottom = place_meeting(xx, yy + abs(bottom), obj);
  
  return _base or _left or _right or _top or _bottom;
}

function place_meeting_wrap_room(xx, yy, obj) {
  return place_meeting_wrap(xx, yy, obj, room_width, room_width, room_height, room_height);
}

function place_meeting_exception_wrap(xx, yy, obj, obj_exception, left, right, top, bottom) {
	with (obj) {
		var this = id;
    
		if (id == obj_exception) {
      continue;
    }
    
    with (other) {
      if place_meeting(xx, yy, this)
      or place_meeting(xx + -abs(left), yy, obj)
      or place_meeting(xx + abs(right), yy, obj)
      or place_meeting(xx, yy + -abs(top), obj)
      or place_meeting(xx, yy + abs(bottom), obj) {
        return true;
      } 
    }
	}
  
	return false;
}

function place_meeting_exception_wrap_room(xx, yy, obj, obj_exception) {
  return place_meeting_exception_wrap(xx, yy, obj, obj_exception, room_width, room_width, room_height, room_height);
}

/// @desc Checks collision in five positions. The base and four directions from the base.
/// It returns five lists of collisions for each position checked and the count of collisions from all the lists together.
function instance_place_list_wrap(xx, yy, obj, left, right, top, bottom) {
  var _list_base = ds_list_create(),
      _list_left = ds_list_create(),
      _list_right = ds_list_create(),
      _list_top = ds_list_create(),
      _list_bottom = ds_list_create(),
      
      _count_base = instance_place_list(xx, yy, obj, _list_base, true),
      _count_left = instance_place_list(xx + -abs(left), yy, obj, _list_left, true),
      _count_right = instance_place_list(xx + abs(right), yy, obj, _list_right, true),
      _count_top = instance_place_list(xx, yy + -abs(top), obj, _list_top, true),
      _count_bottom = instance_place_list(xx, yy + abs(bottom), obj, _list_bottom, true),
      
      _total_collisions = array_reduce([_count_base, _count_left, _count_right, _count_top, _count_bottom], function(prev, count) { return prev + count }, 0);
  
  return {
    lists: {
      base: _list_base,
      left: _list_left,
      right: _list_right,
      top: _list_top,
      bottom: _list_bottom,
      
      /// @desc Destroys all wrap instance_place lists.
      destroy: method(
        { 
          base: _list_base,
          left: _list_left,
          right: _list_right,
          top: _list_top,
          bottom: _list_bottom
        }, 
        function() {
          ds_list_destroy(base);
          ds_list_destroy(left);
          ds_list_destroy(right);
          ds_list_destroy(top);
          ds_list_destroy(bottom);
        }
      ),
    },
    total_collisions: _total_collisions,
  }
}

function instance_place_list_wrap_room(xx, yy, obj) {
  return instance_place_list_wrap(xx, yy, obj, room_width, room_width, room_height, room_height);
}