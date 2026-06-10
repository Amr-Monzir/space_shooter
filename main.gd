extends Node

@export var score = 0

func _ready() -> void:
	new_game()
	
func new_game():
	score = 0
	$Player.start($PlayerStartPosition.position)
