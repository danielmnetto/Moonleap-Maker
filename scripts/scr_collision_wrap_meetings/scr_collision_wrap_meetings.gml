function place_meeting_wrap(xx, yy, obj, left, right, top, bottom) {
  var _self = place_meeting(xx, yy, obj);
  var _left = place_meeting(xx + -abs(left), yy, obj);
  var _right = place_meeting(xx + abs(right), yy, obj);
  var _top = place_meeting(xx, yy + -abs(top), obj);
  var _bottom = place_meeting(xx, yy + abs(bottom), obj);
  
  return _self or _left or _right or _top or _bottom;
}

function place_meeting_wrap_room(xx, yy, obj) {
  return place_meeting_wrap(xx, yy, obj, room_width, room_width, room_height, room_height);
}

function instance_place_list_wrap(xx, yy, obj, list, ordered, left, right, top, bottom) {
  var _self = instance_place_list(xx, yy, obj, list, ordered);
  var _left = instance_place_list(xx + -abs(left), yy, obj, list, ordered);
  var _right = instance_place_list(xx + abs(right), yy, obj, list, ordered);
  var _top = instance_place_list(xx, yy + -abs(top), obj, list, ordered);
  var _bottom = instance_place_list(xx, yy + abs(bottom), obj, list, ordered);
  
  return array_reduce([_self, _left, _right, _top, _bottom], function(prev, count) { return prev + count }, 0);
}

function instance_place_list_wrap_room(xx, yy, obj, list, ordered) {
  return instance_place_list_wrap(xx, yy, obj, list, ordered, room_width, room_width, room_height, room_height);
}