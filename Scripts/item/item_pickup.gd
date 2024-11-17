extends Area2D

func _ready() -> void:
	area_entered.connect(func(area): pickup_item(area));

func pickup_item(itemArea: Area2D) -> void:
	var item: DroppedItem = itemArea.get_parent();
	Utils.deferr_free_node(item);
	
	if (item.item_name == "xp"):
		LevelData.add_xp(1);