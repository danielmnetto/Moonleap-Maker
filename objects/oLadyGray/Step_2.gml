//scr_moving_plat()
calc_subpixel_movement();

repeat abs(vsp_final) {
	if has_collided(0, sign(vsp_final)) {
		vsp = 0;
    vsp_final = 0;
    break;
	}
	
	y += sign(vsp_final);
}

repeat abs(hsp_final) {
	if has_collided(sign(hsp_final), 0) {
		hsp = 0;
    hsp_final = 0;
		break;
	}
	
	x += sign(hsp_final);
}