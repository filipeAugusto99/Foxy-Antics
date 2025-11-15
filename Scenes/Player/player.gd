extends CharacterBody2D


class_name Player


const JUMP = preload("res://assets/sound/jump.wav")
const DAMAGE = preload("res://assets/sound/damage.wav")


@export var fell_off_y: float = 800.0


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel
@onready var shooter: Shooter = $Shooter
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var hurt_timer: Timer = $HurtTimer


const JUMP_SPEED: float = -310.0 
const RUN_SPEED: float = 100.0
const MAX_FALL: float = 350.0
const HURT_JUMP_VELOCITY: Vector2 = Vector2(0, -130.0)


var _gravity: float = ProjectSettings.get('physics/2d/default_gravity')
var _is_hurt: bool = false


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
	
	get_input()
	
	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_FALL)
	
	
	move_and_slide()
	update_debug_label()
	fallen_off()
	

func play_effect(effect: AudioStream) -> void:
	sound.stop()
	sound.stream = effect	
	sound.play()


func get_input() -> void:
	
	if _is_hurt == true:
		return
	
	if is_on_floor() and Input.is_action_just_pressed('jump') == true:
		velocity.y = JUMP_SPEED
		play_effect(JUMP)
	
	run()
	
	
	
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


func apply_hurt_jump() -> void:
	_is_hurt = true
	velocity = HURT_JUMP_VELOCITY
	hurt_timer.start()
	play_effect(DAMAGE)


func apply_hit() -> void:
	apply_hurt_jump()


func _on_hit_box_area_entered(area: Area2D) -> void:
	call_deferred("apply_hit")


func _on_hurt_timer_timeout() -> void:
	_is_hurt = false
