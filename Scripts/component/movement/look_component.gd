class_name LookComponent extends Node

@export var velocity_component: VelocityComponent;

signal rotation_changed(new_rotation: float);

func _ready() -> void:
	if (!velocity_component): push_error("No VelocityComponent set for LookComponent")
	velocity_component.position_changed.connect(func():
		get_parent().rotation = velocity_component.velocity.angle()
		rotation_changed.emit(get_parent().rotation);
	);