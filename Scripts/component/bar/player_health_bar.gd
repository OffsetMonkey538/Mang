class_name PlayerHealthBar extends HealthBar

func _ready() -> void:
	super._ready();
	texture_progress = preload("res://Textures/Hud/ProgressBar/health.png");

func set_health_component(new_component: HealthComponent):
	health_component = new_component;
	call_deferred("_update_health_component");

func _update_health_component() -> void:
	health_component.health_changed.connect(func(_old, new): _on_value_changed(new));
	health_component.max_health_changed.connect(func(_old, new): _on_max_value_changed(new));
	
	value = health_component.health;
	max_value = health_component.max_health;
	label.text = str(value);
