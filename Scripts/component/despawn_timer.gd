class_name DespawnTimer extends Timer

func _ready() -> void:
	timeout.connect(func(): Utils.deferr_free_node(get_parent()));
	autostart = true;