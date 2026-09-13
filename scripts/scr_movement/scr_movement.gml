#macro MOVING_PLATFORM_OBJECTS [oSnail, oSnailNight, oSnailGray, oLady, oLadyVer, oBat, oBatVer]

/// @desc This function initializes variables and methods related to object's movement and it must be called in the object's Create event.
function init_movement_variables() {
  hsp = 0;
  vsp = 0;
  hsp_final = 0;
  vsp_final = 0;
  _hsp_rest = 0;
  _vsp_rest = 0;
  
  _moving_platform = noone;
  
  /// @desc Calculates the current horizontal and vertical speeds, making them integer numbers and storing the decimal rest to sum the speeds on the next calculation.
  __calc_subpixel_movement = function() {
    _hsp_rest += hsp;
   	_vsp_rest += vsp;
   	hsp_final = floor(_hsp_rest);
   	vsp_final = floor(_vsp_rest);
   	_hsp_rest -= hsp_final;
   	_vsp_rest -= vsp_final;
  };
  
  /// @desc Applies movement when moving up or down on slopes.
  __apply_slopes_movement = function() {
    var _place_meeting = can_collision_wrap() ? place_meeting_wrap_room : place_meeting;
    
    if _place_meeting(x + sign(hsp), y, oSolid)
    and not _place_meeting(x + sign(hsp), y - 1, oSolid) {
      y -= 1;
    }

    if vsp >= 0
    and not _place_meeting(x + sign(hsp), y, oSolid)
    and not _place_meeting(x + sign(hsp), y + 1, oSolid)
    and _place_meeting(x + sign(hsp), y + 2, oSolid) {
      y += 1;
    }
  };
  
  /// @desc Calculates collision and movement when on moving platforms.
  __apply_moving_platform_movement = function() {
    var _platforms_bottom = can_collision_wrap() 
      ? instance_place_array_wrap_room(x, y + 1, MOVING_PLATFORM_OBJECTS)
      : instance_place_array(x, y + 1, MOVING_PLATFORM_OBJECTS, true);
    
    if array_length(_platforms_bottom) == 0 {
      return;
    }

    var _platform = _platforms_bottom[0],
        _step = sign(vsp_final);
    
    array_push(_platforms_bottom, oSolid);
    
    repeat abs(vsp_final) {
      var _place_met = can_collision_wrap()
        ? place_meeting_wrap_room(x, y + _step, _platforms_bottom)
        : place_meeting(x, y + _step, _platforms_bottom);
      
      if _place_met {
        vsp = 0;
        vsp_final = 0;
        break;
      }
      
      y += _step;
    }
    
    vsp_final += _platform.vsp_final;
    hsp_final += _platform.hsp_final;
  }
  
  /// @desc Calculates collision and movement when this object is moving against moving platform horizontally in order to stop it.
  __apply_stop_going_against_moving_platform = function() {
    if sign(hsp_final) == 0 {
      return;
    }
    
    var _step = sign(hsp_final),
        _platforms_side = can_collision_wrap() ?
          instance_place_array_wrap_room(x + sign(hsp_final), y, MOVING_PLATFORM_OBJECTS)
          : instance_place_array(x + sign(hsp_final), y, MOVING_PLATFORM_OBJECTS, true);
    
    if array_length(_platforms_side) == 0 {
      return;
    }

    var _platform = _platforms_side[0];
    
    array_push(_platforms_side, oSolid);
    
    repeat abs(hsp_final) {
      var _place_met = can_collision_wrap()
        ? place_meeting_wrap_room(x + _step, y, _platforms_side)
        : place_meeting(x + _step, y, _platforms_side);
      
      if _place_met {
        hsp = 0;
        hsp_final = 0;
        break;
      }
      
      x += _step;
    }
  };
  
  /// @desc Moves the object by its final speeds and stops moving when colliding with wall objects.
  /// @param {bool} enable_slopes_movement When `true`, when moving horizontally, it will detect for slopes to move on them. It's not suitable for flying objects. Default: `true`
  /// @param {bool} avoid_other_moving_platforms  When `true`, this object will not be moved by other moving platforms. It's suitable for moving platforms. Default: `false`.
  apply_movement_collision = function(enable_slopes_movement = true, avoid_other_moving_platforms = false) {
    __calc_subpixel_movement();
    
    if not avoid_other_moving_platforms {
      __apply_stop_going_against_moving_platform();
      __apply_moving_platform_movement();
    }
    
    repeat(abs(vsp_final)) {
    	if has_collided(0, sign(vsp_final)) {
    		vsp = 0;
        vsp_final = 0;
        break;
    	}
    	
    	y += sign(vsp_final);
    }
    
    repeat(abs(hsp_final)) {
      if enable_slopes_movement then __apply_slopes_movement();
    	
    	if has_collided(sign(hsp_final), 0) {
    		hsp = 0;
        hsp_final = 0;
    		break;
    	}
    	
    	x += sign(hsp_final);
    }
  }
}