extends Node2D

@onready var health: HealthComponent = $HealthComponent;
@onready var hurtbox: HurtboxComponent = $HurtboxComponent;

func _ready() -> void:
	health.set_both(roundi(health.max_health * LevelData.difficulty_multiplier));
	hurtbox.damage = roundi(hurtbox.damage * LevelData.difficulty_multiplier);