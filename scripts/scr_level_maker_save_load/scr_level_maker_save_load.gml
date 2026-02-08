#macro LEVEL_MAKER_SAVE_SYSTEM_VERSION "1.4"

#macro LEVEL_MAKER_LEVELS_FOLDER_NAME "custom_levels"
#macro LEVEL_MAKER_LEVELS_FOLDER_PATH $"{working_directory}/{LEVEL_MAKER_LEVELS_FOLDER_NAME}"

/// @desc Saves the current Moonleap Maker level into a file with a given name.
function level_maker_save(_level_file_path) {
	with(oLevelMaker) {

    // Get all objects information
		var _objects_data = [];

		for(var _x = 0; _x < room_tile_width; _x++){
			for(var _y = 0; _y < room_tile_height; _y++){
				var _object_data = [];
				var _object_grid = objects_grid[_x, _y];
				
				if is_struct(_object_grid) {
          var _object_name = object_get_name(_object_grid.object.index);

					_object_data = [
  					_object_grid.top_left_x,
  					_object_grid.top_left_y,
  					_object_name,
  					_object_grid.object_width,
  					_object_grid.object_height,
  					_object_grid.xscale,
  					_object_grid.yscale,
  					_object_grid.angle,
					];
				} else {
					_object_data = -1;
				}
				
				_objects_data[_x, _y] = _object_data;
			}
		}

    // Get all tiles information
    var _tiles_data = [];
    var _draft_col_size = tileset_size;
    var _draft_list = ds_list_create();
    var _draft_layers = level_maker_get_decoration_layers().instances;

    for (var l = 0; l < array_length(_draft_layers); l++) {
      var _layer = _draft_layers[l];
      var _layer_name = layer_get_name(_layer);

      for(var xx = 0; xx < room_width; xx += 16) {
        for(var yy = 0; yy < room_height; yy += 16) {
          ds_list_clear(_draft_list);

          var _draft_amount = collision_rectangle_list(xx, yy, xx + 16, yy + 16, oMakerEditorTileDraft, false, true, _draft_list, true);
          var _draft_to_save = noone;

          for (var i = 0; i < _draft_amount and _draft_to_save == noone; i++) {
            var _current_draft = ds_list_find_value(_draft_list, i);
            var _dx = _current_draft.x;
            var _dy = _current_draft.y;
                        
            if _dx == xx and _dy == yy and layer_get_name(_current_draft.layer) == _layer_name {
              _draft_to_save = _current_draft;
            }
          }

          if _draft_to_save != noone {
            var _tilemap_layer = layer_get_element_layer(_draft_to_save.tilemap_id)
            var _tilemap_layer_name = layer_get_name(_tilemap_layer);

            var _draft_data = [
              _draft_to_save.x,
              _draft_to_save.y,
              _layer_name,
              _draft_to_save.tile_id,
              _draft_to_save.is_rotated,
              _draft_to_save.is_mirrored,
              _draft_to_save.is_flipped,
              _tilemap_layer_name,
              _draft_to_save.xscale,
              _draft_to_save.yscale,
              _draft_to_save.angle
            ];

            array_push(_tiles_data, _draft_data);
          }
        }
      }
    }

    ds_list_destroy(_draft_list);

		// Set level information
    var _save_data = {
      version: LEVEL_MAKER_SAVE_SYSTEM_VERSION,
      name: level_name,
      author: level_author_name,
      player_score: -1,
      perfect_score: perfect_score,
      use_night_music: use_night_music,
      style: selected_style,
      objects: _objects_data,
      tiles: _tiles_data
    };
		
    // Write on file
		var _file_name = _level_file_path;
		var _json = json_stringify(_save_data);
		
		if file_exists(_file_name) {
			file_delete(_file_name)
		}
		
		var _file = file_text_open_write(_file_name);
    
		file_text_write_string(_file, _json);
		file_text_close(_file);
	}
}

/// @desc Loads a Moonleap Maker level to the editor from a file.
function level_maker_load(_level_file_path) {
	if not file_exists(_level_file_path) {
    call_message_popup(LANG.maker_level_file_invalid, 180, "Instances");
		return;
	}
	
	// Read json from file
	var _json_string = "";
	var _file = file_text_open_read(_level_file_path);
	while not file_text_eof(_file) {
		_json_string += file_text_read_string(_file);
	}
	file_text_close(_file);
	
	// All level info parsed
	var _loaded_data = json_parse(_json_string);
		
  if not maker_level_data_is_valid(_loaded_data) {
    call_message_popup(LANG.maker_level_file_invalid, 180, "Instances");
    return;
  }
  
	if _loaded_data.version != LEVEL_MAKER_SAVE_SYSTEM_VERSION {
    call_message_popup(LANG.maker_level_file_oldversion, 180, "Instances");
		return;
	}
  
	with(oLevelMaker) {
		var _level_style = struct_read(_loaded_data, "style", LEVEL_MAKER_STYLE.GRASS);
    var _level_objects = struct_read(_loaded_data, "objects", []);
    var _level_tiles = struct_read(_loaded_data, "tiles", []);

    is_level_file_saved_local = true;
    level_file_name = _level_file_path;
    level_name = _loaded_data.name;
    level_author_name = _loaded_data.author;
    use_night_music = _loaded_data.use_night_music;
    perfect_score = _loaded_data.perfect_score;
		selected_style = _level_style;
    current_player_score = _loaded_data.player_score;
    
    update_tilesets_by_style();
		reset_level_objects_grid();
    reset_level_tiles_grid();
		
    if array_length(_level_objects) > 0 {
      for(var _x = 0; _x < room_tile_width; _x++) {
        for(var _y = 0; _y < room_tile_height; _y++) {
          var _loaded_object_grid = array_get(_level_objects[_x], _y);
  
          if _loaded_object_grid == -1 {
            objects_grid[_x, _y] = -1;
          } else {
            var _ox = _loaded_object_grid[0];
            var _oy = _loaded_object_grid[1];
            var _oname = _loaded_object_grid[2];
            var _owidth = _loaded_object_grid[3];
            var _oheight = _loaded_object_grid[4];
            var _oxscale = _loaded_object_grid[5];
            var _oyscale = _loaded_object_grid[6];
            var _oangle = _loaded_object_grid[7];
  
            var _object_index = asset_get_index(_oname);
            var _object_data = undefined;
              
            for(var t = 0; t < oLevelMaker.object_types_length and is_undefined(_object_data); t++) {
              for(var p = 0; p < oLevelMaker.list_positions_length and is_undefined(_object_data); p++) {
                var _object_to_find = oLevelMaker.obj[t, p];
                  
                if is_undefined(_object_to_find) then continue;
                  
                if _object_to_find.index == _object_index then
                  _object_data = _object_to_find;
              }
            }
              
            if not is_undefined(_object_data) {
              objects_grid[_ox, _oy] = new LMObjectGrid(_ox, _oy, _object_data, _owidth, _oheight, _oxscale, _oyscale, _oangle);
            } else {
              objects_grid[_ox, _oy] = -1;
            }
          }
        }
      }
    }

    if array_length(_level_tiles) > 0 { 
      for(var i = 0; i < array_length(_level_tiles); i++) {
        var _loaded_tile = array_get(_level_tiles, i);

        var _tx = _loaded_tile[0];
        var _ty = _loaded_tile[1];
        var _tlayer_name = _loaded_tile[2];
        var _tid = _loaded_tile[3];
        var _trotated = _loaded_tile[4];
        var _tmirrored = _loaded_tile[5];
        var _tflipped = _loaded_tile[6];
        var _ttilemaplayername = _loaded_tile[7];
        var _txscale = _loaded_tile[8];
        var _tyscale = _loaded_tile[9];
        var _tangle = _loaded_tile[10];

        var _tilelist = level_maker_get_tiles_list(_level_style);
        var _tile = undefined;

        for (var t = 0; t < array_length(_tilelist) and is_undefined(_tile); t++) {
          var _type = _tilelist[t];
          for (var p = 0; p < array_length(_type) and is_undefined(_tile); p++) {
            var _tile_from_list = array_get(_type, p);
            var _tile_id = _tile_from_list.original_tile_id;

            if _tile_id == _tid {
                _tile = _tile_from_list;
            }
          }
        }

        if is_undefined(_tile) then continue;

        var _layer_id = layer_get_id(_tlayer_name);
        var _tilemap_id = layer_tilemap_get_id(_ttilemaplayername);

        var _draft = instance_create_layer(_tx, _ty, _layer_id, oMakerEditorTileDraft);
        _draft.type = _tile.is_animated ? DRAFT_TYPE.ANIMATED_TILE : DRAFT_TYPE.TILE;
        _draft.tile_id = _tid;
        _draft.layer_id = _layer_id;
        _draft.tilemap_id = _tilemap_id;
        _draft.is_rotated = _trotated;
        _draft.is_mirrored = _tmirrored;
        _draft.is_flipped = _tflipped;
        _draft.tileset = _tile.tileset;
        _draft.xscale = _txscale;
        _draft.yscale = _tyscale;
        _draft.angle = _tangle;
        
        if _tile.is_animated {
          _draft.sprite_day = _tile.sprite_day;
          _draft.sprite_night = _tile.sprite_night;
        }
      }
    } 
  }
}

/// @desc Creates a folder for custom Moonleap levels in game's directory if not existed yet.
function custom_levels_directory_create() {
  var _directory = LEVEL_MAKER_LEVELS_FOLDER_PATH;
  
  if directory_exists(_directory) {
    return;
  }
  directory_create(_directory);
};

/// @desc Checks whether the maker level data is valid. Returns `true` if so.
function maker_level_data_is_valid(_level_data) {
  return not (
    (not struct_exists(_level_data, "version")          or not is_string(_level_data.version))
    or (not struct_exists(_level_data, "name")             or not is_string(_level_data.name))
    or (not struct_exists(_level_data, "author")           or not is_string(_level_data.author))
    or (not struct_exists(_level_data, "use_night_music")  or not is_bool  (_level_data.use_night_music))
    or (not struct_exists(_level_data, "style")            or not is_real  (_level_data.style))
    or (not struct_exists(_level_data, "player_score")     or not is_real  (_level_data.player_score))
    or (not struct_exists(_level_data, "perfect_score")    or not is_real  (_level_data.perfect_score))
    or (not struct_exists(_level_data, "tiles")            or not is_array (_level_data.tiles))
    or (not struct_exists(_level_data, "objects")          or not is_array (_level_data.objects))
  );
};