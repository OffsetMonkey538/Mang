class_name UpgradeManager extends Object

## String to UpgradeResource
var all_upgrades: Dictionary = {};

## String to int
var normal_upgrades: Dictionary = {};

## String of upgrade name
var super_upgrades: Array[String] = [];

## String to int
var current_upgrades: Dictionary = {};

var buttons: Array[Node] = HudManager.levelup_hud.find_child("Upgrades").find_children("Upgrade*Button");
var button1: Button = buttons[0];
var button2: Button = buttons[1];
var button3: Button = buttons[2];
var normal: bool = true;
var levelups: int = 0;

func _init() -> void:
	# Get the upgrades
	var upgrades: Array[UpgradeResource] = load("res://Resources/upgrade/normal/upgrades.tres").value;
	for upgrade in upgrades:
		normal_upgrades[upgrade.nimi] = upgrade.maksimum_tase;
		all_upgrades[upgrade.nimi] = upgrade;
	
	upgrades = load("res://Resources/upgrade/super/upgrades.tres").value;
	for upgrade in upgrades:
		super_upgrades.append(upgrade.nimi);
		all_upgrades[upgrade.nimi] = upgrade;
	super_upgrades.make_read_only();
	
	
	# Normal ugrades
	LevelData.level_up.connect(func():
		normal = true;
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

# Called by Boss on death
func show_super_upgrades() -> void:
	normal = false;
	LevelManager.level_instance.pause_game();
	refresh_options();
	HudManager.show_levelup_hud();

func button_pressed() -> void:
	if (normal): button_pressed_normal();
	else: button_pressed_super();

func button_pressed_normal() -> void:
	levelups -= 1;
	if (levelups <= 0):
		HudManager.hide_levelup_hud();
		LevelManager.level_instance.unpause_game();
		return;
	refresh_options();

func button_pressed_super() -> void:
	HudManager.hide_levelup_hud();
	LevelManager.level_instance.unpause_game();

func upgrade_upgrade(upgrade: String) -> void:
	if (normal): upgrade_upgrade_normal(upgrade);
	else: upgrade_upgrade_super(upgrade);
func upgrade_upgrade_normal(upgrade: String) -> void:
	if current_upgrades.has(upgrade):
		current_upgrades[upgrade] += 1;
	else:
		current_upgrades[upgrade] = 1;
	
	if !all_upgrades.has(upgrade):
		push_error("Upgrade '%s' doesn't exist!" % upgrade);
		return;
	for effect in all_upgrades[upgrade].effekt:
		apply_effect(upgrade, effect);

func upgrade_upgrade_super(upgrade: String) -> void:
	current_upgrades[upgrade] = 1;
	
	if !all_upgrades.has(upgrade):
		push_error("Upgrade '%s' doesn't exist!" % upgrade);
		return;
	
	var upgrade_resource: SuperUpgradeResource = all_upgrades[upgrade];
	
	for effect in upgrade_resource.effekt:
		apply_effect(upgrade, effect);
	
	if (all_upgrades[upgrade].maksimum_tase != -1): all_upgrades.erase(upgrade);
	if (upgrade_resource.unlock == null): return;
	
	all_upgrades[upgrade_resource.unlock.nimi] = upgrade_resource.unlock;
	normal_upgrades[upgrade_resource.unlock.nimi] = upgrade_resource.unlock.maksimum_tase;
	

func apply_effect(upgrade_nimi: String, effekt: UpgradeModifierResource) -> void:
	var väärtus: float = effekt.väärtus;
	
	match effekt.nimi:
		"health": LevelManager.player.health_component.add_health(roundi(väärtus));
		"max_health": LevelManager.player.health_component.add_max_health(roundi(väärtus));
		"speed": LevelManager.player.velocity_component.max_speed += väärtus;
		"damage": LevelManager.player.shooter.damage += roundi(väärtus);
		"shoot_speed": LevelManager.player.shooter.shoot_timer.wait_time += väärtus;
		"piercing": LevelManager.player.shooter.piercing += roundi(väärtus);
		"bullet_count": LevelManager.player.shooter.projectile_count += roundi(väärtus);
		"bullet_spread": LevelManager.player.shooter.set_spread(LevelManager.player.shooter.multishot_range_degrees + väärtus);
		"pickup_range": LevelManager.player.pickup.scale += Vector2(väärtus, väärtus);
		"heal_max": LevelManager.player.health_component.set_health(LevelManager.player.health_component.max_health);
		var name: push_error("Upgrade '%s' has unknown effect '%s'!" % [upgrade_nimi, name]);

func refresh_options() -> void:
	var available: Array[String] = get_available_upgrades();
	
	button1.text = get_random(available);
	button2.text = get_random(available);
	button3.text = get_random(available);

func get_available_upgrades() -> Array[String]:
	return get_available_upgrades_normal() if normal else get_available_upgrades_super();

func get_available_upgrades_normal() -> Array[String]:
	var result: Array[String] = [];
	result.assign(normal_upgrades.keys().duplicate());

	for key in current_upgrades:
		var max_level = (normal_upgrades[key] if normal_upgrades.has(key) else 0);
		if (max_level == -1):
			continue;

		if (max_level - current_upgrades.get(key, 0) <= 0):
			result.erase(key);
	return result;

func get_available_upgrades_super() -> Array[String]:
	var result: Array[String] = super_upgrades.duplicate();
	for key in current_upgrades:
		if (all_upgrades.has(key) && all_upgrades[key].maksimum_tase == -1): continue;
		result.erase(key);
	return result

func get_random(available: Array[String]) -> String:
	if (available.size() <= 0): return "tühi";
	
	var random: int = randi_range(0, available.size() - 1);
	var result: String = available[random];
	
	available.erase(result);
	
	return result;
