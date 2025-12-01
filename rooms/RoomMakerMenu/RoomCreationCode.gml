var _menus = {
  main: menu_get_main(),
  options: menu_get_options(),
  assist: menu_get_assist(),
  soundvideo: menu_get_soundvideo(),
  deletesure: menu_get_deletesure(),
};

call_menu(_menus, "main", true, true);