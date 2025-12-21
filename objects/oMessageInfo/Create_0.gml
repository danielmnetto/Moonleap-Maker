messages = [];
message_index = 0;
current_message = "";

message_color = COLOR_NICE_WHITE;
bg_color = COLOR_NICE_BLACK;

scr_inputcreate();

play_sound_on_change_page = function() {
  audio_play_sfx(sndUiChange, false, -18.3, 1);
};