extends Node2D

const max_speed: int = 160;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var liikumissuund: Vector2 = Input.get_vector("liigu_vasakule", "liigu_paremale", "liigu_üles", "liigu_alla")
	
	position += liikumissuund.normalized() * max_speed * delta;
	
	
	if (OS.has_feature("pc") and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		rotation = global_position.angle_to_point(get_global_mouse_position())
	
	var vaatamissuund: Vector2 = Input.get_vector("vaata_vasakule", "vaata_paremale", "vaata_üles", "vaata_alla");
	if (vaatamissuund != Vector2.ZERO):
		rotation = vaatamissuund.angle();