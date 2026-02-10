// Draw button
var button_sprite = oLevelMaker.current_layer == LEVEL_MAKER_LAYERS.OBJECTS ? sButtonsMakerObj : sButtonsMakerTile;

draw_sprite(button_sprite, 0, xstart, ystart + drawplus);

// Draw object/tile
switch (oLevelMaker.current_layer) {
	case LEVEL_MAKER_LAYERS.OBJECTS:
		if not is_undefined(object)
    and not is_undefined(object.button_sprite_sprite_index) {
      object.draw_sprite_button(xx, yy + drawplus);
    } else if sprite_exists(sprite_index) {
      var _object = object.index,
          _sprite = sprite_index,
          _frame = 0;

      draw_sprite_ext(_sprite, _frame, xx, yy + drawplus, scale, scale, image_angle, image_blend, 1);
    }
		
		if global.settings.filter and object.can_change then
			draw_sprite(sColorBlind, object.is_moon_variant, xstart, ystart + drawplus);
		break;
	default:
		if not is_undefined(tile) and tile != 0
			tile.draw_sprite_preview(x - 8, y - 8 + drawplus);
		
		if global.settings.filter and tile.can_change then
			draw_sprite(sColorBlind, 0, x, y + drawplus);
		break;
}