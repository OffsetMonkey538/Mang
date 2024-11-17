class_name PiercingComponent extends Node

@export var hurtbox: HurtboxComponent;
@export var piercing: int = 1;

func _ready() -> void:
	if (!hurtbox):
		push_error("No HurtboxComponent set for PiercingComponent!");
		return;
	
	hurtbox.hit.connect(func(_what: HitboxComponent):
		piercing -= 1;
		if (piercing > 0): return;
		Utils.deferr_free_node(get_parent());
	);