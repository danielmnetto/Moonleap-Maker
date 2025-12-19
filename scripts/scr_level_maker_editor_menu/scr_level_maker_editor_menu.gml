function menus_get_level_editor() {
  var _menu_list = {
    main: menu_level_editor_get_main(),
    level_options: menu_level_editor_get_level_options(),
    options: menu_get_options(),
    assist: menu_get_assist(),
    soundvideo: menu_get_soundvideo(),
    deletesure: menu_get_deletesure()
  };

  return _menu_list;
}

function menu_level_editor_get_main() {
  var _menu_level_editor_main = [
    // Resume
    new MenuOptionCloseMenu(
      function() { return LANG.text_resume; }
    ),
    
    // Level Options
    new MenuOptionMenuCall(
      function() { return "opções da fase"; },
      "level_options"
    ),

    // Options
    new MenuOptionMenuCall(
      function() { return LANG.text_options; },
      "options"
    ),
    
    // Quit
    new MenuOptionActionCall(
      function() { return LANG.text_exit; },
      function() {
        menu_play_redirect_option_sound();
        room_transit(RoomMakerMenu);
      }
    )
  ];
  
  return _menu_level_editor_main;
};

function menu_level_editor_get_level_options() {
  var _menu_level_editor_level_options = [
    // Edit level name
    new MenuOptionCloseMenu(
      function() { return "editar nome da fase"; },
      function() { 
        var _text_input = instance_create_layer(x, y, "Instances", oTextInput);
        _text_input.user_input = oLevelMaker.level_name;
        _text_input.input_string_min = LEVEL_MAKER_LEVEL_NAME_LENGTH_MIN;
        _text_input.input_string_max = LEVEL_MAKER_LEVEL_NAME_LENGTH_MAX;
        _text_input.title = "editar nome da fase";
        _text_input.on_finish = function(_user_input) {
          oLevelMaker.level_name = _user_input;
          menu_call_layer(menus_get_level_editor(), "level_options", "Instances", true, false, true, true);
        }
      }
    ),
    
    // Edit author name
    new MenuOptionCloseMenu(
      function() { return "editar nome do autor da fase"; },
      function() { 
        var _text_input = instance_create_layer(x, y, "Instances", oTextInput);
        _text_input.user_input = oLevelMaker.level_author_name;
        _text_input.input_string_min = LEVEL_MAKER_LEVEL_AUTHOR_LENGTH_MIN;
        _text_input.input_string_max = LEVEL_MAKER_LEVEL_AUTHOR_LENGTH_MAX;
        _text_input.title = "editar nome do autor da fase";
        _text_input.on_finish = function(_user_input) {
          oLevelMaker.level_author_name = _user_input;
          menu_call_layer(menus_get_level_editor(), "level_options", "Instances", true, false, true, true);
        }
      }
    ),
    
    // Edit perfect score
    new MenuOptionActionCall(
      function() {
        var _perfect_score = $"{oLevelMaker.perfect_score}";
        
        return $"pontuação perfeita: {_perfect_score}";
      },
      function() {
        var _perfect_score = oLevelMaker.perfect_score;
        
        _perfect_score += 1;
        if _perfect_score > LEVEL_MAKER_MAX_PERFECT_SCORE {
          _perfect_score = LEVEL_MAKER_MIN_PERFECT_SCORE;
        }
        oLevelMaker.perfect_score = _perfect_score;
      },
      function() {
        return "o máximo de vezes que o jogador\npode mudar para conseguir o melhor rank"
      }
    ),

    // Toggle night music
    new MenuOptionActionCall(
      function() {
        var _night_music = oLevelMaker.use_night_music ? LANG.text_ON : LANG.text_OFF;
        
        return $"música da noite: {_night_music}";
      },
      function() { 
        oLevelMaker.use_night_music = not oLevelMaker.use_night_music;
      }
    ),
    
    // Options
    new MenuOptionMenuCall(
      function() { return LANG.text_back; },
      "main"
    ),
  ];
  
  return _menu_level_editor_level_options;
}
