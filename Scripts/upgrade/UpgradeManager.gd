class_name UpgradeManager extends Object

## String to UpgradeResource
var all_upgrades: Dictionary = {};

## String to int
var normal_upgrades: Dictionary = {};

## String to int
var current_upgrades: Dictionary = {};

var buttons: Array[Node] = HudManager.levelup_hud.find_child("Upgrades").find_children("Upgrade*Button");
var button1: Button = buttons[0];
var button2: Button = buttons[1];
var button3: Button = buttons[2];
var levelups: int = 0;

var rng: RandomNumberGenerator = RandomNumberGenerator.new();

func _init() -> void:
	# Get the upgrades
	var upgrades: Array[UpgradeResource] = load("res://Resources/upgrade/normal/upgrades.tres").value;
	for upgrade in upgrades:
		normal_upgrades[upgrade.nimi] = upgrade.maksimum_tase;
		all_upgrades[upgrade.nimi] = upgrade;
	
	# Normal ugrades
	LevelData.level_up.connect(func():
		LevelManager.level_instance.pause_game();
		
		levelups += 1;
		refresh_options();
		HudManager.show_levelup_hud();
	);
	
	# General
	for button in buttons:
		button.pressed.connect(func(): button_pressed());
	button1.pressed.connect(func(): upgrade_upgrade(button1.text));
	button2.pressed.connect(func(): upgrade_upgrade(button2.text));
	button3.pressed.connect(func(): upgrade_upgrade(button3.text));

func button_pressed() -> void:
	levelups -= 1;
	if (levelups <= 0):
		HudManager.hide_levelup_hud();
		LevelManager.level_instance.unpause_game();
		return;
	refresh_options();

func upgrade_upgrade(upgrade: String) -> void:
	if current_upgrades.has(upgrade):
		current_upgrades[upgrade] += 1;
	else:
		current_upgrades[upgrade] = 1;
	
	if !all_upgrades.has(upgrade):
		push_error("Upgrade '%s' doesn't exist!" % upgrade);
		return;
	for effect in all_upgrades[upgrade].effekt:
		apply_effect(upgrade, effect);

func apply_effect(upgrade_nimi: String, effekt: UpgradeModifierResource) -> void:
	var väärtus: float = effekt.väärtus;
	
	match effekt.nimi:
		"liikumiskiirus": LevelManager.player.velocity_component.max_speed += väärtus; 
		var name: push_error("Upgrade '%s' has unknown effect '%s'!" % [upgrade_nimi, name]);

func refresh_options() -> void:
	var available: Array[String] = get_available_upgrades();
	
	button1.text = get_random(available);
	button2.text = get_random(available);
	button3.text = get_random(available);

func get_available_upgrades() -> Array[String]:
	var result: Array[String] = [];
	result.assign(normal_upgrades.keys().duplicate());

	for key in current_upgrades:
		var max_level = (normal_upgrades[key] if normal_upgrades.has(key) else 0);
		if (max_level == -1):
			continue;

		if (max_level - current_upgrades.get(key, 0) <= 0):
			result.erase(key);
	return result;

func get_random(available: Array[String]) -> String:
	if (available.size() <= 0): return "tühi";
	
	var random: int = rng.randi_range(0, available.size() - 1);
	var result: String = available[random];
	
	available.erase(result);
	
	return result;
