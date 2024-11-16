class_name PlayerHitboxComponent extends HitboxComponent

var _counter: float = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_counter += delta;
	if (_counter < 0.25): return;
	
	_counter = 0;
	if (!health_component): return;
	
	for area in get_overlapping_areas():
		if not area is HurtboxComponent: return;
		if is_queued_for_deletion(): return;
		health_component.remove_health(area.damage);
