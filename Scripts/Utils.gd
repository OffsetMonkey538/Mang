class_name Utils extends Object

static func deferr_free_node(node: Node) -> void:
	node.queue_free();
	node.get_parent().remove_child.call_deferred(node);