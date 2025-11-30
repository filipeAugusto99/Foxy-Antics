extends Control


@onready var score_label: Label = $MarginContainer/ScoreLabel


var _score: int = 0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit") == true:
		GameManager.load_main()


func _ready() -> void:
	pass # Replace with function body.


func _enter_tree() -> void:
	SignalHub.on_scored.connect(on_scored)
	
	
func on_scored(points: int) -> void:
	_score += points
	score_label.text = "%05d" % _score
