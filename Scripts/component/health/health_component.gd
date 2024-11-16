class_name HealthComponent extends Node

@export var max_health: int = 100;

var health: int;

var is_dead: bool = false;

signal death;
signal health_changed(old_value: int, new_value: int);
signal max_health_changed(old_value: int, new_value: int);

func _ready() -> void:
	health = max_health;

func remove_health(amount: int) -> void:
	if is_dead: return;
	
	var old_health: int = health;
	health -= amount;
	
	health_changed.emit(old_health, health);
	if health > 0: return;
	
	is_dead = true;
	
	death.emit();
	Utils.deferr_free_node(get_parent());

func add_health(amount: int) -> void:
	if is_dead: return;
	
	var old_health: int = health;
	health = min(max_health, health + amount);
	
	if old_health == health: return;
	health_changed.emit(old_health, health);

func set_health_max() -> void:
	if is_dead: return;
	
	var old_health: int = health;
	health = max_health;
	
	if old_health == health: return;
	health_changed.emit(old_health, health);

func add_max_health(amount: int) -> void:
	var old_health: int = health;
	var old_max_health: int = max_health;
	
	var suhe: float = float(old_health) / float(old_max_health)
	
	max_health += amount;
	
	health = roundi(suhe * max_health);
	
	max_health_changed.emit(old_max_health, max_health);
	health_changed.emit(old_health, health);

func set_max_health(amount: int):
	var old_max_health: int = max_health;
	max_health = amount;
	max_health_changed.emit(old_max_health, max_health)

func set_health(amount: int):
	var old_health: int = health;
	health = amount;
	health_changed.emit(old_health, health);

func set_both(amount: int):
	set_max_health(amount);
	set_health(amount);
