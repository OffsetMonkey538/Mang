extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var health_component: HealthComponent = $HealthComponent;
@onready var shooter: ProjectileShooter = $ProjectileShooter;

func _ready() -> void:
	health_component.set_both(roundi(health_component.max_health * LevelData.difficulty_multiplier));
	shooter.damage = roundi(shooter.damage * LevelData.difficulty_multiplier);
	shooter.projectile_count = floori(LevelData.difficulty_multiplier) * 2 - 1;
	shooter.set_spread(minf(70, roundi(shooter.projectile_count * 5)));
	
	sprite.material.set_shader_parameter("hue_shift", randf_range(0, 1));
	
	health_component.death.connect(func():
		LevelData.upgrades.show_super_upgrades();
	);