var _cam_offset_x = camera_get_view_x(view_camera[0]);
var _cam_offset_y = camera_get_view_y(view_camera[0]);
var _cam_width = camera_get_view_width(view_camera[0]);
var _cam_height = camera_get_view_height(view_camera[0]);
var _cam_interpolation = 0;
var _app_surface_x = 0;
var _app_surface_y = 0;
var _gui_scale_x = 0;
var _gui_scale_y = 0;

with oLevelMaker {
  camera_current_interpolation += level_maker_is_editing() ? -0.07 : 0.07;
  camera_current_interpolation = clamp(camera_current_interpolation, 0, 1);
  
  _cam_interpolation = camera_current_interpolation;
}

// Recalculate the mouse position since I'm using oAppSurfaceManager to resize the application surface to keep it pixel perfect
// this is instead of using the actual camera cause then it would look ugly zoomed in
_app_surface_x = lerp(0, _cam_offset_x, _cam_interpolation);
_app_surface_y = lerp(0, _cam_offset_y, _cam_interpolation);
	
_gui_scale_x = lerp(1, _cam_width / room_width, _cam_interpolation);
_gui_scale_y = lerp(1, _cam_height / room_height, _cam_interpolation);
  
x = (mouse_x - _app_surface_x) / _gui_scale_x;
y = (mouse_y - _app_surface_y) / _gui_scale_y;