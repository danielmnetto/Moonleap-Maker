function menus_get_maker() {
  var _menu_list = {
    main: menu_maker_get_main(),
  };

  if global.is_maker_mode {
    _menu_list.options = menu_get_options();
    _menu_list.assist = menu_get_assist();
    _menu_list.soundvideo = menu_get_soundvideo();
    _menu_list.deletesure = menu_get_deletesure();
  }
  
  return _menu_list;
}

function menu_maker_get_main() {
  var _menu_maker_main = [
    // Play a level
    new MenuOptionCloseMenu(
      function() { return LANG.maker_menu_play; },
      function() {
        instance_create_layer(0, 0, "Instances", oMakerLevelsList);
      }
    ),

    // Create a level
    new MenuOptionActionCall(
      function() { return LANG.maker_menu_make; },
      function() {
        menu_play_redirect_option_sound();
        room_transit(RoomMaker0, "Instances");
      },
    ),

    // Import a level
    //new MenuOptionActionCall(
      //function() { return LANG.maker_menu_import; },
      //function() {
        //try {
        	//var _level_filename = get_open_filename("*.moonlevel", "mylevelname");
//
          //if (_level_filename != "") {
            //if not directory_exists(LEVEL_MAKER_LEVELS_FOLDER_PATH) {
              //directory_create(LEVEL_MAKER_LEVELS_FOLDER_PATH);
            //}
            //
            //file_copy(_level_filename, _level_filename);
            //call_message_popup(LANG.maker_level_upload_success, 120, "Instances");
          //}
        //}
        //catch (_error) { 
          //call_message_popup(LANG.maker_level_save_error, 180, "Instances");
          //show_debug_message($"{_error}");
        //}
      //},
    //),
  ];

  if global.is_maker_mode {
    // Options
    array_push(_menu_maker_main, 
      new MenuOptionMenuCall(
        function() { return LANG.text_options; },
        "options",
    ))
  }
  
  // Go back / Exit game (Maker mode)
  array_push(_menu_maker_main, new MenuOptionActionCall(
    function() { return global.is_maker_mode ? LANG.text_exit : LANG.text_back; },
    function() {
      if global.is_maker_mode {
        game_end();
        return;
      }
      
      menu_play_redirect_option_sound();
      room_transit(RoomMenu, "Instances");
    }
  ));
  
  return _menu_maker_main;
};
