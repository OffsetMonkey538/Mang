class_name DifficultyManager extends Node

const step: float = 0.5;
const enemy_material: ShaderMaterial = preload("res://Materials/enemy_material.tres")

@export var boss_spawner: EnemySpawner;
@export var enemy_spawner: EnemySpawner;

var timeth: int = 0;

func _ready() -> void:
	enemy_material.set_shader_parameter("hue_shift", 0.0);
	boss_spawner.before_spawn.connect(func(): _try_increment());

func _try_increment() -> void:
	timeth += 1;
	
	var new_multiplier: float = snappedf(timeth**2 * 0.1 + 1, step);
	
	if (new_multiplier <= LevelData.difficulty_multiplier): return;
	
	LevelData.difficulty_multiplier = new_multiplier;
	on_increment();

func on_increment() -> void:
	enemy_material.set_shader_parameter("hue_shift", fmod(timeth * 0.05, 1));
	enemy_spawner.spawn_amount = roundi(6 * LevelData.difficulty_multiplier + 3);
	enemy_spawner.set_frequency(max(5, -2 * LevelData.difficulty_multiplier + 15));
	