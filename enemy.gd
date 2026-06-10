extends RigidBody2D

@export var health = 0
@export var fireRate = 0.5
var canShoot = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickSprite()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pickSprite():
	var spriteTypes = Array([$Type1Shape, $Type2Shape, $Type3Shape, $Type4Shape])
	var sprite = spriteTypes.pick_random()
	for other in spriteTypes:
		(other as Sprite2D).hide()
	(sprite as Sprite2D).show()
	spriteTypes.erase(sprite)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_shoot_timer_timeout() -> void:
	shoot()

func shoot():
	pass;
	
