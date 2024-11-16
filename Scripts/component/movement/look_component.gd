class_name LookComponent extends Node

@export var velocity_component: VelocityComponent;

func _ready() -> void:
	if (!velocity_component): push_error("No VelocityComponent set for LookComponent")
	velocity_component.position_changed.connect(func(): get_parent().rotation = velocity_component.velocity.angle());