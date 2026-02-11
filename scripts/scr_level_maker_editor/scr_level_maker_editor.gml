#macro LEVEL_MAKER_MIN_PERFECT_SCORE 0
#macro LEVEL_MAKER_MAX_PERFECT_SCORE 30
#macro LEVEL_MAKER_LEVEL_NAME_LENGTH_MIN 6
#macro LEVEL_MAKER_LEVEL_NAME_LENGTH_MAX 32
#macro LEVEL_MAKER_LEVEL_AUTHOR_LENGTH_MIN 3
#macro LEVEL_MAKER_LEVEL_AUTHOR_LENGTH_MAX 20
#macro LEVEL_MAKER_GRID_OBJECTS_TILE_SIZE 8
#macro LEVEL_MAKER_GRID_TILESETS_TILE_SIZE 16

enum LEVEL_MAKER_CURSOR { NOTHING, CURSOR, FINGER, ERASER, CANCEL }
enum LEVEL_MAKER_STYLE { GRASS, CLOUDS, FLOWERS, SPACE, DUNGEON, LENGTH }
enum LEVEL_MAKER_EDITOR_MODE { EDITING, TESTING, PLAYING }

/*
 * Change 'global.is_maker_mode' value to true to skip the intro and
 * redirect to the level maker.
 */ 
global.is_maker_mode = true;

function level_maker_is_editing() {
	return instance_exists(oLevelMaker) and oLevelMaker.mode == LEVEL_MAKER_EDITOR_MODE.EDITING;
}

function level_maker_update_style() {
	instance_destroy(oGrassDay);
	instance_destroy(oCloudDay);
	instance_destroy(oFlowerDay);
	instance_destroy(oSpaceDay);
	instance_destroy(oDunDay)
	
	switch(selected_style) {
		case LEVEL_MAKER_STYLE.GRASS:		instance_create_layer(-64, -64, layer, oGrassDay);		break;
		case LEVEL_MAKER_STYLE.CLOUDS:	instance_create_layer(-64, -64, layer, oCloudDay);		break;
		case LEVEL_MAKER_STYLE.FLOWERS:	instance_create_layer(-64, -64, layer, oFlowerDay);		break;
		case LEVEL_MAKER_STYLE.SPACE:		instance_create_layer(-64, -64, layer, oSpaceDay);		break;
		case LEVEL_MAKER_STYLE.DUNGEON:	instance_create_layer(-64, -64, layer, oDunDay);		break;
	}
	
	for (var yy = list_positions_length - 1; yy >= 0; yy -= 1) {
		for (var xx = object_types_length - 1; xx >= 0; xx -= 1) {
			var object = obj[xx,yy];
			
			if is_undefined(object) then continue;

			with(object.index) {
				palette_index = oLevelMaker.selected_style;
			}
		}
	}
}

function level_maker_check_level_validation() {
  return oLevelMaker.has_level_a_player() 
  and oLevelMaker.has_level_a_star();
}

function level_maker_test_show_missing_objects_message() {
  var _msg = "",
      _msg_count = 0, // used to add line break.
      _duration = 90;
  
  if not oLevelMaker.has_level_a_player() {
    _msg += $"- {LANG.maker_level_test_no_player}";
    _msg_count += 1;
  }
  
  if not oLevelMaker.has_level_a_star() {
    if _msg_count > 0 {
      _msg += "\n";
      _duration += 60;
    }
    _msg += $"- {LANG.maker_level_test_no_star}";
  }
  
  audio_play_sfx(snd_bump, false, -5, 13);
  call_message_popup(_msg, _duration, layer);
}

function level_maker_save_show_missing_objects_message() {
  var _msg = "",
      _msg_count = 0, // used to add line break.
      _duration = 90;
  
  if not oLevelMaker.has_level_a_player() {
    _msg += $"- {LANG.maker_level_save_no_player}";
    _msg_count += 1;
  }
  
  if not oLevelMaker.has_level_a_star() {
    if _msg_count > 0 {
      _msg += "\n";
      _duration += 60;
    }
    _msg += $"- {LANG.maker_level_save_no_star}";
  }
  
  audio_play_sfx(snd_bump, false, -5, 13);
  call_message_popup(_msg, _duration, layer);
}