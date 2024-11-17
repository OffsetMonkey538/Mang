class_name XpBar extends MyProgressBar

func _ready() -> void:
	super._ready();
	
	LevelData.xp_changed.connect(func(_old: float, new: float):
		value = new;
	);
	
	LevelData.xp_level_changed.connect(func(_old: float, new: float):
		value = LevelData.xp;
		label.text = str(new);
		max_value = LevelData.get_xp_for_next_level();
	);
	
	reset();

	texture_progress = preload("res://Textures/Hud/ProgressBar/xp.png");

func reset():
	value = 0;
	label.text = "";
	max_value = LevelData.get_xp_for_next_level();