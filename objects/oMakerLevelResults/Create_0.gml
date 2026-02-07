level_name = "";
level_author = "";
player_score = 0;
perfect_score = 0;
time_played = 0;

rank_get_result_letter = function() {
  var _letter = "D";
  
  if player_score <= perfect_score + 9 {
    _letter = "C";
  }
  if player_score <= perfect_score + 6 {
    _letter = "B";
  }
  if player_score <= perfect_score + 3 {
    _letter = "A";
  }
  if player_score <= perfect_score {
    _letter = "S";
  }
  if instance_exists(oBird) {
    _letter = "D";
  }
  
  return _letter;
};

time_played_get_formatted = function() {
  var _time_rounded = floor(time_played),
      _minutes = _time_rounded div 60,
      _seconds = _time_rounded mod 60,
      _tenths = floor((time_played - _time_rounded) * 10),
      _minutes_string = string_replace_all(string_format(_minutes, 2, 0), " ", "0"),
      _seconds_string = string_replace_all(string_format(_seconds, 2, 0), " ", "0");
  
  return $"{_minutes_string}:{_seconds_string}.{_tenths}";
};
