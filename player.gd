extends Area2D

@export var speed = 400
@export var fireRate = 0.5
var canShoot = false

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
		print("shot")
 	
	velocity = velocity.normalized()
	
	position += velocity * delta * speed
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _on_shoot_timer_timeout() -> void:
	canShoot = true
