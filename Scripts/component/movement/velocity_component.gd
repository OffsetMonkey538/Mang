class_name VelocityComponent extends Node

@export var max_speed: float = 100;
@export var acceleration: float = 1;
@export var initial_velocity: Vector2 = Vector2.ZERO;

@onready var velocity: Vector2 = initial_velocity;
var target_velocity: Vector2 = Vector2.ZERO;

signal position_changed();

func _process(delta: float) -> void:
	if (acceleration == -1): velocity = target_velocity;
	else: velocity = lerp(velocity, target_velocity, delta * acceleration);
	
	velocity = velocity.limit_length(max_speed);
	
	get_parent().position += velocity * delta;
	position_changed.emit();