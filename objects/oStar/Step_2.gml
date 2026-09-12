calc_subpixel_movement();

apply_stop_going_against_moving_platform();
apply_moving_platform_movement();

repeat(abs(vsp_final)) {
	if has_collided(0, sign(vsp_final), true, [oPermaSpike]) {
		vsp = 0;
    vsp_final = 0;
    break;
	}
	
	y += sign(vsp_final);
}

repeat(abs(hsp_final)) {
  apply_slopes_movement();
	
	if has_collided(sign(hsp_final), 0, true, [oPermaSpike]) {
		hsp = 0;
    hsp_final = 0;
		break;
	}
	
	x += sign(hsp_final);
}
