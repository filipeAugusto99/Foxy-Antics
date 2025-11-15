extends CharacterBody2D


class_name Player


@export var fell_off_y: float = 800.0


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel
@onready var shooter: Shooter = $Shooter
@onready var sound: AudioStreamPlayer2D = $Sound


const JUMP_SPEED: float = -310.0 
const RUN_SPEED: float = 100.0
const MAX_FALL: float = 350.0

var _gravity: float = ProjectSettings.get('physics/2d/default_gravity')


func _ready() -> void:
	pass # Replace with function body.


func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") == true:
		var dir: Vector2 = Vector2.LEFT if sprite_2d.flip_h else \
					Vector2.RIGHT
		shooter.shoot(dir)


func _physics_process(delta: float) -> void:
	velocity.y += delta * _gravity
	
	if is_on_floor() and Input.is_action_just_pressed('jump') == true:
		jump(delta)
		sound.play()
		
	run()
	move_and_slide()
	update_debug_label()
	fallen_off()
	
	
func jump(delta: float) -> void:
	if Input.is_action_just_pressed('jump') == true:
			velocity.y = JUMP_SPEED
	
	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_FALL)

func run() -> void:
	var movement = Input.get_axis('left', 'right')
	velocity.x = RUN_SPEED * movement
	
	if is_equal_approx(velocity.x, 0.0) == false:
		sprite_2d.flip_h = velocity.x < 0


func update_debug_label() -> void:
	var ds: String = ""
	ds += "Floor:%s\n" % [is_on_floor()]
	ds += "V:%.1f, %.1f\n" % [velocity.x, velocity.y]
	ds += "P:%.1f, %.1f" % [global_position.x, global_position.y]
	debug_label.text = ds


func fallen_off() -> void:
	if global_position.y > fell_off_y:
		queue_free()
