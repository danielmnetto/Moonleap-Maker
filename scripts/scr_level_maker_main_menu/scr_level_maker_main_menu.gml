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
    //new MenuOptionCloseMenu(
      //function() { return LANG.maker_menu_play; },
      //function() {
        //instance_create_layer(0, 0, "Instances", oMakerLevelsList);
      //}
    //),

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
      //function() {},
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
