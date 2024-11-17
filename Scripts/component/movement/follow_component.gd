class_name FollowComponent extends Area2D

@export var velocity_component: VelocityComponent;
@export var self_area: Area2D;
@export var separation_distance: float = 1;
@export var separation_weight: float = 0.5;
@export var target_weight: float = 0.5;

var target: Node2D;

func _ready() -> void:
	if (!velocity_component): push_error("No VelocityComponent set for FollowComponent!")

func _process(_delta: float) -> void:
	velocity_component.target_velocity = _arvuta_suund();

func _arvuta_suund() -> Vector2:
	var eraldumine: Vector2 = Vector2.ZERO;
	var järgimine: Vector2 = Vector2.ZERO;
	
	var parvekaaslased: Array = get_overlapping_areas();
	for parvekaaslane: Area2D in parvekaaslased:
		if (parvekaaslane == self_area || parvekaaslane == null || parvekaaslane.is_queued_for_deletion()): continue;
		
		var distants_parvekaaslaseni: float = global_position.distance_to(parvekaaslane.global_position);
		
		eraldumine -= (parvekaaslane.global_position - global_position).normalized() * velocity_component.max_speed * (separation_distance / distants_parvekaaslaseni);
	
	järgimine = _suund_targetini();
	
	return (
		eraldumine * separation_weight +
		järgimine * target_weight
	).normalized() * velocity_component.max_speed;

func _suund_targetini() -> Vector2:
	if (!target):
		push_error("No target!")
		return Vector2.ZERO;
	
	return (target.global_position - global_position).normalized() * velocity_component.max_speed;
