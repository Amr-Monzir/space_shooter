extends RigidBody2D

@export var health = 2
@export var fireRate = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickSprite()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y = position.y+1;

func pickSprite():
	var spriteTypes = Array([$Type1Shape, $Type2Shape, $Type3Shape, $Type4Shape])
	var sprite = spriteTypes.pick_random()
	for other in spriteTypes:
		(other as Sprite2D).hide()
	(sprite as Sprite2D).show()
	spriteTypes.erase(sprite)

func _on_shoot_timer_timeout() -> void:
	shoot()

func shoot():
	var bullet: Bullet = Bullet.new_enemy_bullet()
	bullet.position = $ShootMarker.global_position
	bullet.rotate(180)
	
	get_parent().call_deferred("add_sibling", bullet)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	if body is Bullet:
		body.queue_free()
	health -= 1
	if health == 0:
		queue_free()
