extends Node

var level_instance: Node = null;
var player: Player = null;

func unload_level() -> void:
	Callable(func():
		Utils.deferr_free_node(level_instance);
		level_instance = null;
	).call_deferred();

func reload_level() -> void:
	Callable(func():
		if level_instance:
			Utils.deferr_free_node(level_instance)
		
		var level: Resource = preload("res://Scenes/level.tscn");
	
		level_instance = level.instantiate();
	
		get_node("/root/Main").add_child(level_instance);
	
		player = level_instance.get_node("Player");
	).call_deferred();

func _ready() -> void:
	reload_level();