class_name HealthBar extends MyProgressBar

@export var health_component: HealthComponent;

func _ready() -> void:
	super._ready();
	
	if (!health_component):
		push_error("No HealthComponent set for HealthBar!");
		return;
	
	# Texture
	texture_progress = preload("res://Textures/Hud/ProgressBar/health.png");
	
	# Signals
	health_component.health_changed.connect(func(_old: int, new: int): _on_value_changed(new));
	health_component.max_health_changed.connect(func(_old: int, new: int): _on_max_value_changed(new));
	
	health_component.ready.connect(func():
		_on_max_value_changed(health_component.max_health);
		_on_value_changed(health_component.health);
);