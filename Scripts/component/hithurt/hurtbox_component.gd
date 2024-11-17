class_name HurtboxComponent extends Area2D

@export var damage: int = 1;

signal hit(what: HitboxComponent);

func _ready() -> void:
	area_entered.connect(hitbox_entered);

func hitbox_entered(area: Area2D) -> void:
	if not area is HitboxComponent: return;
	if get_parent().is_queued_for_deletion(): return;
	
	area.hurtbox_entered(self);
	hit.emit(area);