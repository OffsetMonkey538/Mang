extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.material.set_shader_parameter("hue_shift", randf_range(0, 1));