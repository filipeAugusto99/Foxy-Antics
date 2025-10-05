extends CharacterBody2D


class_name Player


@onready var sprite_2d: Sprite2D = $Sprite2D


const JUMP_SPEED: float = -310.0 
const RUN_SPEED: float = 100.0


var _gravity: float = ProjectSettings.get('physics/2d/default_gravity')


func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	velocity.y += delta * _gravity
	
	
	if is_on_floor() and Input.is_action_just_pressed('jump') == true:
		jump(delta)
	
	run()
	move_and_slide()
	
	
func jump(delta: float) -> void:
	if Input.is_action_just_pressed('jump') == true:
			velocity.y = JUMP_SPEED
	

func run() -> void:
	var movement = Input.get_axis('left', 'right')
	velocity.x = RUN_SPEED * movement
	
	if is_equal_approx(velocity.x, 0.0) == false:
		sprite_2d.flip_h = velocity.x < 0
