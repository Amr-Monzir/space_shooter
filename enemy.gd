extends Area2D

@export var health = 2
@export var fireRate = 2
@export var speed = 50

func _ready() -> void:
	pickSprite()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2(0, 1)
	position += velocity * delta * speed

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
	bullet.rotate(PI)
	
	get_parent().call_deferred("add_sibling", bullet)
	# fireRate = count / second
	# time = count / fireRate
	$ShootTimer.start(1/fireRate)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	
	print("Enemey Collision Detected!")  
	print("Body type:", body.get_class()) # Should print "CharacterBody2D", "RigidBody2D", etc.
	
	if body is Bullet && (body as Bullet).type == Bullet.BulletType.enemyBullet:
		return
	if body is Bullet:
		body.queue_free()
	health -= 1
	if health == 0:
		queue_free()
	$CollisionShape2D.set_deferred("disabled", true)


func _on_area_entered(area: Area2D) -> void:
	print("Enemey Collision Detected!")  
	print("Body type:", area.get_class()) # Should print "CharacterBody2D", "RigidBody2D", etc.
	
	if area is Bullet && (area as Bullet).type == Bullet.BulletType.enemyBullet:
		return
	if area is Bullet:
		area.queue_free()
	health -= 1
	if health == 0:
		queue_free()
