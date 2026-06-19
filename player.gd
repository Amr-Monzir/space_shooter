extends Area2D

@export var speed = 400
@export var fireRate = 0.5
var health = 3
var canShoot = false
@export var bullet_scene: PackedScene
var screenSize

func _ready() -> void:
	screenSize = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
	if Input.is_action_pressed("move_down"):
		velocity.y = 1
	if Input.is_action_pressed("move_up"):
		velocity.y = -1
	if Input.is_action_just_pressed("shoot") && canShoot:
		canShoot = false
		$ShootTimer.start(fireRate)      
		Input.action_release("shoot")
		shoot()
 	
	velocity = velocity.normalized()
	
	position += velocity * delta * speed
	position = position.clamp(Vector2(37,0), Vector2(screenSize.x-37, screenSize.y))

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _on_shoot_timer_timeout() -> void:
	canShoot = true
	
func shoot():
	var bullet: Bullet = Bullet.new_player_bullet()
	bullet.position = ($ShootMarker as Marker2D).global_position
	get_parent().call_deferred("add_sibling", bullet)
 
func game_over():
	print("game over")

func _on_safe_timer_timeout() -> void:
	$CollisionShape2D.set_deferred("disabled", false)

func _on_area_entered(area: Area2D) -> void:
	if area is Bullet && (area as Bullet).type == Bullet.BulletType.playerBullet:
		return
	health -= 1
	if health == 0:
		game_over()
	$CollisionShape2D.set_deferred("disabled", true)
	$SafeTimer.start(1)
