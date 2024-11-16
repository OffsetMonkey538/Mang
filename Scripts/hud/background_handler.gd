class_name BackgroundHandler extends ParallaxBackground

var parallax_layer: ParallaxLayer = ParallaxLayer.new();

@export var sprite: Texture2D;
@export var sprite_scale: Vector2 = Vector2(1, 1);

@onready var sprite_laius: float = sprite.get_width() * sprite_scale.x;
@onready var sprite_kõrgus: float = sprite.get_height() * sprite_scale.y;

func _ready() -> void:
	add_child(parallax_layer);
	_handle_change();
	
	get_viewport().size_changed.connect(func(): _handle_change());

func _handle_change() -> void:
	_reset_layer();
	
	var viewport_suurus: Vector2 = get_viewport().get_visible_rect().size;
	var viewport_laius: float = viewport_suurus.x;
	var viewport_kõrgus: float = viewport_suurus.y;
	
	var vajatud_laius: int = ceili(2 * viewport_laius / sprite_laius);
	var vajatud_kõrgus: int = ceili(2 * viewport_kõrgus / sprite_kõrgus);
	
	parallax_layer.set_mirroring(Vector2(
		vajatud_laius * sprite_laius,
		vajatud_kõrgus * sprite_kõrgus
	));
	
	for x in range(vajatud_laius):
		for y in range(vajatud_kõrgus):
			var praegune_sprait: Sprite2D = Sprite2D.new();
			praegune_sprait.texture = sprite;
			praegune_sprait.scale = sprite_scale;
			
			praegune_sprait.position = Vector2(
				sprite_laius * x,
				sprite_kõrgus * y
			);
			
			parallax_layer.add_child(praegune_sprait);

func _reset_layer() -> void:
	parallax_layer.queue_free();
	remove_child(parallax_layer);
	
	parallax_layer = ParallaxLayer.new();
	add_child(parallax_layer);
