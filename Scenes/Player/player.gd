extends CharacterBody2D


var _gravity: float = ProjectSettings.get('physics/2d/default_gravity')


func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	velocity.y += delta * _gravity
	
	move_and_slide()
	
	if is_on_floor():
		jump(delta)
	
	
func jump(delta: float) -> void:
	if Input.is_action_just_pressed('jump') == true:
			velocity.y = -350.0	
	
