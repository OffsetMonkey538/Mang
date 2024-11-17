extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var health_component: HealthComponent = $HealthComponent;

func _ready() -> void:
	sprite.material.set_shader_parameter("hue_shift", randf_range(0, 1));
	
	health_component.death.connect(func():
		LevelData.upgrades.show_super_upgrades();
	);