/// @desc Draw draft preview on editor

var _object_sprite = object.sprite_index,
    _object_frame = 0,
    _object_x = x,
    _object_y = y,
    _object_xscale = xscale,
    _object_yscale = yscale,
    _object_angle = angle,
    _object_blend = c_white,
    _object_alpha = 1;

draw_sprite_ext(_object_sprite, _object_frame, _object_x, _object_y, _object_xscale, _object_yscale, _object_angle, _object_blend, _object_alpha);
