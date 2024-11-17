class_name Player extends Node2D

@onready var velocity_component: VelocityComponent = $VelocityComponent;
@onready var health_component: HealthComponent = $HealthComponent;
@onready var shooter: ProjectileShooter = $ProjectileShooter;
@onready var pickup: CollisionShape2D = $ItemPickup/CollisionShape2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HudManager.player_health_bar.set_health_component(health_component);
	
	# Restart game when player dies
	health_component.death.connect(func():
		LevelManager.unload_level();
		HudManager.start_button.show();
		HudManager.hide_joysticks();
	);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var liikumissuund: Vector2 = Input.get_vector("liigu_vasakule", "liigu_paremale", "liigu_üles", "liigu_alla")
	
	velocity_component.target_velocity = liikumissuund.normalized() * velocity_component.max_speed;
	
	
	if (OS.has_feature("pc") and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		rotation = global_position.angle_to_point(get_global_mouse_position())
	
	var vaatamissuund: Vector2 = Input.get_vector("vaata_vasakule", "vaata_paremale", "vaata_üles", "vaata_alla");
	if (vaatamissuund != Vector2.ZERO):
		rotation = vaatamissuund.angle();