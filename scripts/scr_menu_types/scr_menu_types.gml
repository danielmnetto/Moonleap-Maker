function menu_get_main() {
  var _menu_main = [
    // Start
    new MenuOptionActionCall(
      function() { return LANG.text_start; },
      function() {
        audio_play_sfx(sndStarGame, false, -6, 0);
        show_debug_message("start game!");
      }
    ),

    // Options
    new MenuOptionMenuCall(
      function() { return LANG.text_options; },
      "options",
    ),

    // Credits
    new MenuOptionActionCall(
      function() { return LANG.text_credits; },
      function() {
        audio_play_sfx(sndStarGame, false, -6, 0);
        show_debug_message("credits!");
      }
    )
  ];

  if is_on_desktop() {
    // Level Maker
    array_push(_menu_main, new MenuOptionActionCall(
      function() { return LANG.maker_name; },
      function() {
        audio_play_sfx(sndStarGame, false, -6, 0);
        show_debug_message("level maker!");
      }
    ));

    // Exit game
    array_push(_menu_main, new MenuOptionActionCall(
      function() { return LANG.text_exit; },
      function() {
        audio_play_sfx(sndStarGame, false, -6, 0);
        show_debug_message("exit game!");
      }
    ));
  }

  return _menu_main;
};

function menu_get_options() {
  var _menu_options = [
    // Vibrate
    new MenuOptionActionCall(
      function() { 
        var _vibration_percent = round(global.settings.vibration * 100);
        return $"{LANG.text_vibrate}{_vibration_percent}%";
      },
      function() {
        global.settings.vibration += 0.1;
        if (global.settings.vibration > 1)
          global.settings.vibration = 0;
        shake_gamepad(0.75, 10);
      }
    ),

    // Sound & Video
    new MenuOptionMenuCall(
      function() { return LANG.text_soundvideo; },
      "soundvideo"
    ),

    // Assist
    new MenuOptionMenuCall(
      function() { return LANG.text_assist; },
      "assist"
    ),

    // Language
    new MenuOptionValueToggle(
      function() { return $"{LANG.text_language}{lang_get()}"; },
      ["EN", "PT-BR", "JA", "ES", "IT", "ZH"],
      function(_langs) {
        return array_find_index_of_value(_langs, lang_get())
      },
      function(_lang) {
        lang_set(_lang);
      }
    ),

    // Go back
    new MenuOptionMenuCall(
      function() { return LANG.text_back; },
      "main",
      function() { oSaveManager.save = true; }
    ),
  ];

  return _menu_options;
}