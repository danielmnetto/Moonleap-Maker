function level_maker_save_update_player_score(_level_file_path, _player_score) {
  try {
  	if not file_exists(_level_file_path) {
      show_debug_message("Couldn't open the level file to update the player score. Player score update skipped.");
  		return;
  	}
    
    var _loaded_data = level_maker_level_file_open(_level_file_path);
    
    _loaded_data.player_score = _player_score;
    
    level_maker_level_file_save(_level_file_path, _loaded_data);
    show_debug_message("PLayer score updated successfully!");
  } catch (_error) {
    show_debug_message("[!!!] Failed to update player score.");
  	show_debug_message(_error);
  }
}