extends Node

@export var life_timer: float = 20.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(life_timer).timeout
	get_parent().call_deferred("queue_free")
	
