class_name RangedFollowComponent extends Node2D

@export var velocity_component: VelocityComponent;
@export var target_separation_distance: float;

var target: Node2D;

func _ready() -> void:
	if (!velocity_component): push_error("No VelocityComponent set for FollowComponent!")
	if (!target): push_error("No target!")

func _process(_delta: float) -> void:
	velocity_component.target_velocity = _arvuta_suund();
	get_parent().rotation = (target.global_position - global_position).angle();
	get_parent().find_child("HealthBar").rotation = -global_rotation;

func _arvuta_suund() -> Vector2:
	var järgimine: Vector2 = (target.global_position - global_position);
	
	if (järgimine.length() < target_separation_distance): järgimine = Vector2.ZERO;
	
	return järgimine.normalized() * velocity_component.max_speed;
