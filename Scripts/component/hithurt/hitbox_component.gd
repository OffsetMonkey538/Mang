class_name HitboxComponent extends Area2D

@export var health_component: HealthComponent;

signal hit(by: HurtboxComponent)

func hurtbox_entered(hurtbox: HurtboxComponent) -> void:
	if hurtbox.is_queued_for_deletion(): return;
	if get_parent().is_queued_for_deletion(): return;
	
	hit.emit(hurtbox);
	
	if (health_component): health_component.remove_health(hurtbox.damage);