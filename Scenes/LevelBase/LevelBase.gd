extends Node2D


const ENEMY_BULLET = preload("res://Scenes/BaseBullet/EnemyBullet.tscn")
const PLAYER_BULLET = preload("res://Scenes/BaseBullet/PlayerBullet.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("test") == true:
		var b = PLAYER_BULLET.instantiate()
		add_child(b)
	elif event.is_action_pressed("quit") == true:
		GameManager.load_main()
