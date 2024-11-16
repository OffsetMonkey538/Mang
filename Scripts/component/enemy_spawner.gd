class_name EnemySpawner extends Node2D

@export var enemy: PackedScene;
@export var spawn_frequecy_seconds: float = 1;
@export var spawn_amount: int = 1;
@export var spawn_radius: float = 150;
@export var instant_spawn: bool = false;

var _time: float = 0;

func _ready() -> void:
	_time = spawn_frequecy_seconds;
	if (instant_spawn): _spawn_enemies();

func _process(delta: float) -> void:
	if (_time <= 0):
		_spawn_enemies();
		_time = spawn_frequecy_seconds;
		return;
	_time -= delta;

func _spawn_enemies():
	var radians_per_enemy: float = TAU / spawn_amount;
	
	for i in range(spawn_amount):
		var new_enemy: Node2D = enemy.instantiate();
		
		new_enemy.position = global_position + Vector2.UP.rotated(i * radians_per_enemy) * spawn_radius;
		
		LevelManager.level_instance.add_child.call_deferred(new_enemy);

func set_frequency(new_frequency: float) -> void:
	spawn_frequecy_seconds = new_frequency;
	_time = minf(_time, spawn_frequecy_seconds);