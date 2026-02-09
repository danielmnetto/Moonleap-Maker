enum LEVEL_MAKER_OBJECT_SPRITE_ORIGIN { TOP_LEFT, CENTER, BOTTOM, OFFSET5 }

/// @description A "Level Maker Object" constructor. Use this as base to create
/// an object for the level editor.
/// @param {Asset.GMObject} _object_index The matching object index of the level object.
function LMObject(_object_index) constructor {
	label = "";
	index = _object_index;
	size_x = 16;
	size_y = 16;
	origin_type = LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.TOP_LEFT;
	tags = [];

	preview_sprite_frame_flip_h = undefined;
	preview_sprite_frame_flip_v = undefined;
	
	button_sprite_sprite_index = undefined;
	button_sprite_image_index = 0;
	button_sprite_x_offset = 0;
	button_sprite_y_offset = 0;
	button_sprite_part_left = 0;
	button_sprite_part_top = 0;
	button_sprite_part_width = 16;
	button_sprite_part_height = 16;
  
  on_begin_draw_button_sprite = function(_sprite, _frame) {};
  on_end_draw_button_sprite = function(_sprite, _frame) {};

  /// @desc Sets the size of the object in the level editor.
  /// @param {real} _width The object width in pixels in the editor.
  /// @param {real} _height The object height in pixels in the editor.
  static set_size = function(_width, _height) {
    size_x = _width;
    size_y = _height;
    return self;
  };
  
  /// @param {real} _origin The sprite origin to be relative when positioning the object in the level editor.
  /// Use a `LEVEL_MAKER_OBJECT_SPRITE_ORIGIN` enumerator value.
  static set_sprite_origin = function(_origin) {
    if is_nan(_origin) {
      throw "The object sprite origin must be a number or a value from LEVEL_MAKER_OBJECT_SPRITE_ORIGIN enumerator."
      return;
    }
    
    origin_type = _origin;
    return self;
  };
	
  /// @desc Sets the sprite frame that will be used when the preview sprite is flipped horizontally.
  /// @param {real} _frame_flipped The sprite frame that has the object's sprite flipped.
	static set_preview_sprite_frame_flip_h = function(_frame_flipped = 0) {
		preview_sprite_frame_flip_h = _frame_flipped;
		return self;
	}
	
  /// @desc Sets the sprite frame that will be used when the preview sprite is flipped vertically.
  /// @param {real} _frame_flipped The sprite frame that has the object's sprite flipped.
	static set_preview_sprite_frame_flip_v = function(_frame_flipped = 0) {
		preview_sprite_frame_flip_v = _frame_flipped;
		return self;
	}
	
  /// @desc Configs the part of the object sprite that is displayed in a Level Maker button.
  /// @param {Asset.GMSprite} _sprite The object's sprite index.
  /// @param {real} _frame The object' sprite frame.
  /// @param {real} _part_left The left point of the object's sprite.
  /// @param {real} _part_top The top point of the object's sprite.
  /// @param {real} _x_offset The horizontal offset of the object's sprite position.
  /// @param {real} _y_offset The vertical offset of the object's sprite position.
  /// @param {real} _part_width The right point of the object's sprite.
  /// @param {real} _part_height The bottom point of the object's sprite.
	static set_button_sprite_draw_config = function(
		_sprite,
		_frame,
		_part_left,
		_part_top,
		_x_offset, 
		_y_offset,
		_part_width = undefined,
		_part_height = undefined
	) {
		button_sprite_sprite_index = _sprite;
		button_sprite_image_index = _frame;
		button_sprite_part_left = _part_left;
		button_sprite_part_top = _part_top;
		button_sprite_x_offset = _x_offset;
		button_sprite_y_offset = _y_offset;
		button_sprite_part_width = is_undefined(_part_width) ? button_sprite_part_width : _part_width;
		button_sprite_part_height = is_undefined(_part_height) ? button_sprite_part_width : _part_height;
    
		return self;
	}
	
	static draw_sprite_button = function(_x, _y) {
    if is_method(on_begin_draw_button_sprite) {
      on_begin_draw_button_sprite(button_sprite_sprite_index, button_sprite_image_index);
    }
    
		var _sprite = button_sprite_sprite_index,
		    _sprite_nineslice = sprite_get_nineslice(_sprite),
		    _prev_nineslice_enabled = _sprite_nineslice.enabled;
		
		_sprite_nineslice.enabled = false;
		draw_sprite_part(
      _sprite,
      button_sprite_image_index,
      button_sprite_part_left,
      button_sprite_part_top,
      button_sprite_part_width,
      button_sprite_part_height,
      _x + button_sprite_x_offset,
      _y + button_sprite_y_offset
    );
		_sprite_nineslice.enabled = _prev_nineslice_enabled;
    
    if is_method(on_end_draw_button_sprite) {
      on_end_draw_button_sprite(button_sprite_sprite_index, button_sprite_image_index);
    }
	}
	
  /// @desc Adds a tag to the object.
  /// @param {string} tags One or more tags to add to the object.
	static add_tag = function() {
    if argument_count <= 0 {
      throw "You forgot to add tags to the object here. Also, make sure that they are strings.";
    }
    
    for (var i = 0; i < argument_count; i++) {
      var _tag = argument[i];
			
			if typeof(_tag) != "string" {
        throw "A tag must be a string.";
      }
			array_push(tags, _tag);
    }
		
		return self;
	}
	
  /// @desc Checks whether the object has a defined tag in it.
  /// @param {String} _tag The tag to be checked
	static has_tag = function(_tag) {
		return array_find_index_of_value(tags, _tag) == -1 ? false : true;
	}
	
	/// @desc Gets the `x` and `y` position of the object's sprite origin depending of its origin type.
	/// @returns {Array<real>} Array of `x` and `y` position of the sprite origin respectively.
	static get_sprite_offset_typed = function(_tile_size, _object_tile_width, _object_tile_height) {
		var _sprite = object_get_sprite(index);
		var _offx = sprite_get_xoffset(_sprite);
		var _offy = sprite_get_yoffset(_sprite);
		var _w = sprite_get_width(_sprite);
		var _h = sprite_get_height(_sprite);
		
		switch(origin_type){
			case LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.OFFSET5:
				return [
					_offx - 8,
					_offy - 8
				];
			case LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.TOP_LEFT:
				return [
					_offx,
					_offy
				];
			case LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h + _object_tile_height * _tile_size,
				];
			case LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h / 2 + _object_tile_height * _tile_size / 2
				];
		}
	}
	
	static get_size = function(_tile_size = 8) {
		var _tiled_width = size_x / _tile_size;
		var _tiled_height = size_y / _tile_size;
		
		var _offset = get_sprite_offset_typed(_tile_size, _tiled_width, _tiled_height);
		
		return [_tiled_width, _tiled_height, _offset[0], _offset[1]];
	}
	
	return self;
}

/// @desc Object data used to compose the main object grid data.
/// @param {real} _top_left_x The left origin of the object
/// @param {real} _top_left_y The top origin of the object
/// @param {Asset.GMObject} _object The object index
/// @param {real} _object_width The object width
/// @param {real} _object_height The object height
/// @param {real} _xscale The object horizontal scale
/// @param {real} _yscale The object vertical scale
/// @param {real} _angle The object angle (0 - 359)
function LMObjectGrid(
  _top_left_x,
  _top_left_y,
  _object,
  _object_width,
  _object_height,
  _xscale,
  _yscale,
  _angle
) constructor {
	top_left_x = _top_left_x;
	top_left_y = _top_left_y;
	object = _object;
	object_width = _object_width;
	object_height = _object_height;
	xscale = _xscale;
	yscale = _yscale;
	angle = _angle;
}

/// @desc Returns an object array of `LMObject` objects that is used to display on Level Editor in buttons.
function level_maker_get_objects_list() {
	var _objects = [];
	
  // ==============================
  // Page 1
  // ==============================
  
	_objects[0, 00] =	new LMObject(oPlayer)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("is_unique", "is_player");
  
	_objects[0, 01] =	new LMObject(oSolid)
    .set_size(16, 16)
    .add_tag("grid_16", "is_holdable");
  
	_objects[0, 02] =	new LMObject(oBrokenStone)
    .set_size(16, 16)
    .add_tag("grid_16", "is_holdable");
  
	_objects[0, 03] =	new LMObject(oPlatGhost)
    .set_size(16, 16)
    .add_tag("can_spin");
  
	_objects[0, 04] =	new LMObject(oSolidRamp)
    .set_size(32, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sBlockRampEditor, 0, 16, 0, -8, -8);
  
	_objects[0, 05] =	new LMObject(oPermaSpike)
    .set_size(16, 16)
    .add_tag("is_holdable");
  
	_objects[0, 06] =	new LMObject(oSolidDay)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.OFFSET5)
    .add_tag("grid_16", "is_holdable")
    .set_button_sprite_draw_config(sGrassGre, 0, 8, 8, 0, 0);
  _objects[0, 06].on_begin_draw_button_sprite = method(
    { main: _objects[0, 06] }, 
    function() {
      var _sprite = sGrassGre;
      switch(oLevelMaker.selected_style) {
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
      
      main.button_sprite_sprite_index = _sprite;
    }
  );
  
	_objects[0, 07] =	new LMObject(oSolidNight)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.OFFSET5)
    .add_tag("grid_16", "is_holdable");
  _objects[0, 07].on_begin_draw_button_sprite = method(
    { main: _objects[0, 07] }, 
    function() {
      var _sprite = sGrassOre;
      
      switch(oLevelMaker.selected_style) {
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
      
      main.button_sprite_sprite_index = _sprite;
    }
  );
  
	_objects[0, 08] =	new LMObject(oLadderDay)
    .set_size(16, 16);
  
	_objects[0, 09] =	new LMObject(oLadderNight)
    .set_size(16, 16);
  
	_objects[0, 10] =	new LMObject(oStar)
    .set_size(16, 16)
    .add_tag("can_spin");
  
	_objects[0, 11] =	new LMObject(oStarRunning)
    .set_size(16, 16);
  
	_objects[0, 12] =	new LMObject(oSnail)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sSnailWalk, 0, 0, 2, -9, 0);
  
	_objects[0, 13] =	new LMObject(oSnailNight)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sSnailIdleNight, 0, 0, 2, -11, 0, 18);
  
	_objects[0, 14] =	new LMObject(oLady)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_preview_sprite_frame_flip_h(1);
  
	_objects[0, 15] =	new LMObject(oBat)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip", "grid_16")
    .set_button_sprite_draw_config(sBat, 0, 10, 4, -7, -8);
	
  // ==============================
  // Page 2
  // ==============================
  
	_objects[1, 00] =	new LMObject(oPlayerDir)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("is_unique", "is_player");
  
	_objects[1, 01] =	new LMObject(oBigSolid)
    .set_size(32, 32)
    .add_tag("grid_16", "is_holdable")
    .set_button_sprite_draw_config(sBlockGrayGiant, 0, 0, 0, 0, 0);
  
	_objects[1, 02] =	new LMObject(oBrokenStoneBig)
    .set_size(32, 32)
    .add_tag("grid_16", "is_holdable")
    .set_button_sprite_draw_config(sBrokenStoneBig, 0, 0, 0, 0, 0);
  
	_objects[1, 03] =	new LMObject(oLadderNeutral)
    .set_size(16, 16);
  
	_objects[1, 04] =	new LMObject(oStarColor)
    .set_size(16, 16);
  
	_objects[1, 05] =	new LMObject(oStarRunningColor)
    .set_size(16, 16);
  
	_objects[1, 06] =	new LMObject(oMush)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_spin");
  
	_objects[1, 07] =	new LMObject(oMushGray)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_spin")
    .set_button_sprite_draw_config(sMushGrayUI, 0, 0, 0, 0, 0);
  
	_objects[1, 08] =	new LMObject(oSnailGray)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_flip");
  
	_objects[1, 09] =	new LMObject(oLadyGray)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sLadyGrayUI, 0, 3, 0, -8, -8);
  
	_objects[1, 10] =	new LMObject(oLadyVer)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip", "is_vertical")
    .set_preview_sprite_frame_flip_v(1)
    .set_button_sprite_draw_config(sLadyVerUI, 0, 3, 1, -8, -8);
  
	_objects[1, 11] =	new LMObject(oLadyGiant)
    .set_size(48, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_preview_sprite_frame_flip_h(1)
    .set_button_sprite_draw_config(sLadyGiant, 0, 19, 1, -8, -8);
  
	_objects[1, 12] =	new LMObject(oLadyGiant4)
    .set_size(64, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_preview_sprite_frame_flip_h(1)
    .set_button_sprite_draw_config(sLadyGiant4, 0, 14, 1, -8, -8);
  
	_objects[1, 13] =	new LMObject(oBatVer)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip", "grid_16", "is_vertical")
    .set_preview_sprite_frame_flip_v(1)
    .set_button_sprite_draw_config(sBatDown, 0, 10, 4, -7, -8);
  
	_objects[1, 14] =	new LMObject(oBatGiant)
    .set_size(48, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sBatGiant, 0, 21, 1, -8, -8)
  
	_objects[1, 15] =	new LMObject(oBatSuperGiant)
    .set_size(64, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER)
    .add_tag("can_flip")
    .set_button_sprite_draw_config(sBatGiant4, 0, 12, 1, -8, -8);
	
  // ==============================
  // Page 3
  // ==============================
  
	_objects[2, 00] =	new LMObject(oPlayerNeutral)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("is_unique", "is_player");
  
	_objects[2, 01] =	new LMObject(oBird)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("can_flip", "is_unique");
  
	_objects[2, 02] =	new LMObject(oKey)
    .set_size(16, 16);
  
	_objects[2, 03] =	new LMObject(oKeyDoor)
    .set_size(16, 16);
  
	_objects[2, 04] =	new LMObject(oKeyTall)
    .set_size(16, 32)
    .set_button_sprite_draw_config(sKeyDoorTallUI, 0, 0, 8, -8, -8);
  
	_objects[2, 05] =	new LMObject(oKeyDoorTall)
    .set_size(16, 32)
    .set_button_sprite_draw_config(sKeyDoorTall, 0, 0, 8, -8, -8);
  
	_objects[2, 06] =	new LMObject(oKeyWide)
    .set_size(32, 16)
    .set_button_sprite_draw_config(sKeyDoorWideUI, 0, 8, 0, -8, -8);
  
	_objects[2, 07] =	new LMObject(oKeyDoorWide)
    .set_size(32, 16)
    .set_button_sprite_draw_config(sKeyDoorWide, 0, 8, 0, -8, -8);
  
	_objects[2, 08] =	new LMObject(oKeyTallWide)
    .set_size(32, 32)
    .set_button_sprite_draw_config(sKeyDoorTallWideUI, 0, 0, 0, -8, -8);
  
	_objects[2, 09] =	new LMObject(oKeyDoorTallWide)
    .set_size(32, 32)
    .set_button_sprite_draw_config(sKeyDoorWideTall, 0, 0, 0, -8, -8);
  
	_objects[2, 10] =	new LMObject(oMagicOrb)
    .set_size(16, 16)
    .set_sprite_origin(LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM)
    .add_tag("is_unique", "is_orb");
  
	_objects[2, 11] =	new LMObject(oStarFly)
    .set_size(16, 16);
  
	_objects[2, 12] =	new LMObject(oSolidInv)
    .set_size(16, 16)
    .add_tag("grid_16", "is_holdable");
  
	_objects[2, 13] =	undefined;
  
	_objects[2, 14] =	undefined;
  
	_objects[2, 15] =	undefined;

	return _objects;
}
