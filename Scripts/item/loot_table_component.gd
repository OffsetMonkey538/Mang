class_name LootTableComponent extends Node

## Key should be String of the Item Name and value should be Int of chance
@export var loot_table: Dictionary;
@export var rolls: int;
@export var health_component: HealthComponent;

var _dropped_item_scene: PackedScene = preload("res://Scenes/loot/dropped_item.tscn");

func _ready() -> void:
	health_component.death.connect(func(): drop_items());

func drop_items():
	var total_chance: int = _get_total_chance();

	for i in range(0, rolls):
		var item: DroppedItem = _get_random_roll(total_chance);
		LevelManager.level_instance.call_deferred("add_child", item);

func _get_random_roll(total_chance: int) -> DroppedItem:
	var item: DroppedItem = _dropped_item_scene.instantiate();
	item.position = get_parent().position + (Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * randf_range(0, 20));

	var random_num: int = randi_range(0, total_chance);
	var partial_sum: int = 0;
	for key in loot_table.keys():
		partial_sum += loot_table[key];
		if partial_sum < random_num: continue;
		item.set_item(key);
		break;

	return item;

func _get_total_chance() -> int:
	var result: int = 0;
	for chance in loot_table.values():
		result += chance;
	return result;
