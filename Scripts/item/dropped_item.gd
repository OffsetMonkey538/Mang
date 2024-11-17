class_name DroppedItem extends Node2D

var item_name: String = "missing";
var _sprite_texture: Texture2D = preload("res://Textures/missing.png");

@onready var sprite: Sprite2D = $Sprite2D;

func _ready() -> void:
	sprite.texture = _sprite_texture;

func set_item(new_name: String) -> void:
	item_name = new_name;
	_sprite_texture = load("res://Textures/Item/%s.png" % item_name);