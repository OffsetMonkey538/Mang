class_name ProjectileShooter extends Node2D

@export var shoot_speed: float = 1;
@export var projectile_count: int = 1;
@export var multishot_range_degrees: float = 0;
@export var damage: int = 1;
@export var piercing: int = 1;
@export var projectile_scene: PackedScene;

@onready var _multishot_range_radians: float = deg_to_rad(multishot_range_degrees);

var shoot_timer: Timer;

func _ready() -> void:
	shoot_timer = Timer.new();
	shoot_timer.timeout.connect(func(): _shoot_projectiles());
	shoot_timer.wait_time = shoot_speed;
	shoot_timer.autostart = true;
	shoot_timer.one_shot = false;
	add_child(shoot_timer);

func _shoot_projectiles() -> void:
	for current_projectile in range(projectile_count):
		var projectile_rotation_offset: float = (current_projectile - (projectile_count - 1.0) / 2.0) * _multishot_range_radians / projectile_count;
		_shoot(projectile_rotation_offset);

func _shoot(rotation_offset: float):
	var new_projectile: Node2D = projectile_scene.instantiate();
	
	new_projectile.position = global_position;
	new_projectile.rotation = global_rotation + rotation_offset;
	new_projectile.find_child("HurtboxComponent").damage = damage;
	new_projectile.find_child("VelocityComponent").initial_velocity = new_projectile.find_child("VelocityComponent").initial_velocity.rotated(new_projectile.rotation) + get_parent().find_child("VelocityComponent").velocity;
	new_projectile.find_child("PiercingComponent").piercing = piercing;
	
	LevelManager.level_instance.add_child(new_projectile);

func set_spread(new_spread_degrees: float):
	multishot_range_degrees = new_spread_degrees;
	_multishot_range_radians = deg_to_rad(multishot_range_degrees);
