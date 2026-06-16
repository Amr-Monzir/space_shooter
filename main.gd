extends Node

@export var score = 0
@export var mob_scene: PackedScene

func _ready() -> void:
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

	var window = get_window()
	var size = window.size

	mob.position = Vector2( randi_range(0, size.x) , 0)
	
	add_child(mob)
	
func game_over():
	$MobTimer.stop()
	$ScoreTimer.stop()
	
	
