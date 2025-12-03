levels = [];
current_level_index = 0;

levels_to_display = 3;
level_display_range_start = 0;
level_display_range_end = levels_to_display - 1;

randomize();
repeat(10) {
  var _name = choose("Moonchild Forest Path","Twilight Thorn Woods","Starlit Grove Run","Spinebrush Clearing","Snailspike Hollow","Lunarsong Canopy","Cloudstep Ascent","Skytrail Drift","GiantLadybug Watch","Batborne Crossing","Softpetal Meadow","Bloomwhisper Field","Starbud Garden","Crackfall Platforms","Moonchild Skyline","Nebula Petal Route","Astral Grove Loop","Aurora Cloud Rise","Starcatcher Bloomway","Lunar Drift Expanse","Moonchild Starwalk","Cosmic Snail Outpost","Voidthorn Passage","Astroblossom Ridge","Galaxywing Crossing","Stellar Bloom Plains","Nebula Spike Trail","Moonveil Orbit Run","Starhaven Heights","Cosmic Bloom Path","Orbitshatter Road","Stellafield Horizon");
  var _author = choose("AeroNova","PixelDrake","LumaShift","CodeRidge","VantaCore","Solunex","RiftMender","HexaTrail","NebulaForge","JadeRunner","ProtoDash","SilentFlux","VoxLancer","NyxStride","IronVale","SkyLumen","LunarCode","EchoNexus","FluxRider","NovaThread","PrimeLynx","TerraPulse","MiraVortex","ZenoCraft","ArgoBlade","CodaSpark","ZenTrail","HyperBrim","RuneShift","MetaHollow","AstraMend","ZephyrArc");
  array_push(levels, new MakerLevel(_name, _author, "1.0001"));
}

scr_inputcreate();

play_sound_on_navigate = function() {
  var _sound = sndUiChange,
      _can_loop = false,
      _gain = -18.3,
      _pitch = 1;

  audio_play_sfx(_sound, _can_loop, _gain, _pitch);
};

play_sound_on_select_option = function() {
  var _ui_select_sound = sndUiChange,
      _priority = 1,
      _loop = false,
      _gain = 0.20 * (global.settings.enable_sfx),
      _offset = 0,
      _pitch = 1.4;

  audio_play_sound(_ui_select_sound, _priority, _loop, _gain, _offset, _pitch);
};

/// @desc Updates the level display range (start and end). Use this command when you change `levels_to_display` value.
function update_level_display_range() {
  level_display_range_start = 0;
  level_display_range_end = levels_to_display - 1;
}