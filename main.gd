extends Node

@export var score = 0
@export var mob_scene: PackedScene
var screenSize

func _ready() -> void:
	var window = get_window()
	screenSize = window.size
	new_game()
	
func new_game():
	score = 0
	$Player.start($PlayerStartPosition.position)
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout() -> void:
	spawn_mob()
	
func spawn_mob():
	var mob = mob_scene.instantiate()

	mob.position = Vector2( randi_range(100, screenSize.x - 100) , 0)
	
	add_child(mob)
	
func game_over():
	$MobTimer.stop()
	$ScoreTimer.stop()
	
	
