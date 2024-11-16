class_name MyProgressBar extends TextureProgressBar

@export var look_component: LookComponent;
var label: Label;

func _ready() -> void:
	# Set up progress bar
	nine_patch_stretch = true;
	stretch_margin_left = 3;
	stretch_margin_top = 3;
	stretch_margin_right = 3;
	stretch_margin_bottom = 3;
	texture_under = preload("res://Textures/Hud/ProgressBar/under.png");
	texture_over = preload("res://Textures/Hud/ProgressBar/border.png");
	step = 0;
	z_index = 1;
	if (texture_progress == null): texture_progress = preload("res://Textures/missing.png");

	# Create label
	label = Label.new();
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;
	label.autowrap_mode = TextServer.AUTOWRAP_ARBITRARY;
	label.label_settings = LabelSettings.new();
	label.label_settings.font_size = 64;
	label.scale = Vector2(0.00125, 0.00125) * max(size.x, size.y);
	label.size = size / label.scale;
	add_child(label);
	
	# Set up signals
	if (look_component): look_component.rotation_changed.connect(func(new: float): self.rotation = -new);
	
	process_mode = Node.PROCESS_MODE_DISABLED;

func _on_value_changed(new_value: float) -> void:
	value = new_value;
	label.text = str(value);

func _on_max_value_changed(new_max_value: float) -> void:
	max_value = new_max_value;