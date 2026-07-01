sprite_index = night ? sStarDaySpike : sStarDay;

on_ground_var = has_collided(0, 1, true, [oPermaSpike]);
if not on_ground_var and image_angle == 0 {
	vsp += 0.125;
}

if vsp > 4 {
	vsp = 4;
}

object_set_room_wrapping();
