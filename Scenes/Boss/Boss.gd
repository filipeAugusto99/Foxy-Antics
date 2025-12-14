extends Node2D


@onready var animation_tree: AnimationTree = $AnimationTree
@onready var hit_box: Area2D = $Visuals/HitBox
@onready var shooter: Shooter = $Visuals/Shooter


var _player_ref: Player


func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)
	if _player_ref == null:
		queue_free()
		

func shoot() -> void:
	shooter.shoot(
		shooter.global_position.direction_to(
			_player_ref.global_position
		)	
	)


func activate_collisions() -> void:
	hit_box.set_deferred("monitoring", true)
	hit_box.set_deferred("monitorable", true)


func _on_trigger_area_entered(area: Area2D) -> void:
	animation_tree["parameters/conditions/on_trigger"] = true
