object = -1;
angle = 0;
xscale = 1;
yscale = 1;
width = 16;
height = 16;

object_instance_id = undefined;
layer_id = layer_get_id("Instances");

place_in_room = function() {
  object_instance_id = instance_create_layer(x, y, layer_id, object);
  object_instance_id.image_xscale = xscale;
  object_instance_id.image_yscale = yscale;
  object_instance_id.image_angle = angle;
};

remove_from_room = function() {
  instance_destroy(object_instance_id, false);
};