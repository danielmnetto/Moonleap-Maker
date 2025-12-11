if room_is(RoomMaker0) {
  show_debug_message("[Maker] entered on level editor!");
  if level_filename != "" and level_filename != undefined {
    level_maker_load(level_filename);
    show_debug_message("[Maker] *** loaded level data!");
  }
  instance_destroy();
  show_debug_message("[Maker] data transition destroyed!");
}