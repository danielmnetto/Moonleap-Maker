function level_maker_save_update_player_score(_level_file_path, _player_score) {
  if not file_exists(_level_file_path) {
    show_debug_message("Couldn't open the level file to update the player score. Player score update skipped.");
		return;
	}
  
  var _json_string = "",
	    _file = file_text_open_read(_level_file_path);
	
  while not file_text_eof(_file) {
		_json_string += file_text_read_string(_file);
	}
	file_text_close(_file);

	var _loaded_data = json_parse(_json_string);
  
  _loaded_data.player_score = _player_score;
  
  var _new_level_json = json_stringify(_loaded_data),
      _new_file = file_text_open_write(_level_file_path);
  
  file_text_write_string(_new_file, _new_level_json);
  file_text_close(_new_file);
  
  show_debug_message("Player score updated successfully!");
}