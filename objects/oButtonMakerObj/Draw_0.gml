// Draw button
var button_sprite = oLevelMaker.current_layer == LEVEL_MAKER_LAYERS.OBJECTS ? sButtonsMakerObj : sButtonsMakerTile;

draw_sprite(button_sprite, 0, xstart, ystart + drawplus);

// Draw object/tile
switch (oLevelMaker.current_layer) {
	case LEVEL_MAKER_LAYERS.OBJECTS:
		if not is_undefined(object) and not is_undefined(object.sprite_button_sprite_index) then
			object.draw_sprite_button_part(xx, yy + drawplus);
		else if sprite_exists(sprite_index) {
      var _object = object.index;
      var _sprite = sprite_index;
      var _frame = 0;
      
      if _object == oSolidDay {
        switch(oLevelMaker.selected_style) {
          case LEVEL_MAKER_STYLE.GRASS:
            _sprite = sGrassGre;
          break;
          case LEVEL_MAKER_STYLE.CLOUDS:
            _sprite = sCloudDay;
          break;
          case LEVEL_MAKER_STYLE.FLOWERS:
            _sprite = sFlowerDay;
          break;
          case LEVEL_MAKER_STYLE.SPACE:
            _sprite = sSpaceGre;
          break;
          case LEVEL_MAKER_STYLE.DUNGEON:
            _sprite = sDunDay;
          break;
        }
      }

      if _object == oSolidNight {
        switch(oLevelMaker.selected_style) {
          case LEVEL_MAKER_STYLE.GRASS:
            _sprite = sGrassOre;
          break;
          case LEVEL_MAKER_STYLE.CLOUDS:
            _sprite = sCloudNight;
          break;
          case LEVEL_MAKER_STYLE.FLOWERS:
            _sprite = sFlowerNight;
          break;
          case LEVEL_MAKER_STYLE.SPACE:
            _sprite = sSpacePurple;
          break;
          case LEVEL_MAKER_STYLE.DUNGEON:
            _sprite = sDunNight;
          break;
        }
      }
      
      if _object == oSolidDay or _object == oSolidNight {
        var _sprite_nineslice = sprite_get_nineslice(_sprite);
        
        _sprite_nineslice.enabled = false;
        draw_sprite_part_ext(_sprite, _frame, 8, 8, 16, 16, xx, yy + drawplus, scale, scale, image_blend, 1);
        _sprite_nineslice.enabled = true;
      } else {
        draw_sprite_ext(_sprite, _frame, xx, yy + drawplus, scale, scale, image_angle, image_blend, 1);
      }
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