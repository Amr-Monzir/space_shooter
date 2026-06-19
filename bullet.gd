class_name Bullet
extends Area2D

enum Direction {up, down}
enum BulletType {playerBullet, enemyBullet}

var direction: Direction = Direction.up
var type: BulletType = BulletType.enemyBullet

@export var speed = 800

	
static func new_enemy_bullet():
	var my_scene: PackedScene = preload("res://bullet.tscn")
	var newBullet: Bullet = my_scene.instantiate()
	newBullet.direction = Direction.down
	newBullet.type = BulletType.enemyBullet
	return newBullet
	
static func new_player_bullet():
	var my_scene: PackedScene = preload("res://bullet.tscn")
	var newBullet: Bullet = my_scene.instantiate()
	newBullet.direction = Direction.up
	newBullet.type = BulletType.playerBullet
	return newBullet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickSprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if direction == Direction.up:
		velocity = Vector2(0, -1)
	else:
		velocity = Vector2(0, 1)
	
	position += delta * velocity * speed
	
	# DEBUG: Show what the bullet "sees"
	var overlap = get_overlapping_bodies()
	if overlap.size() > 0:
		print("Overlapping bodies:", overlap)


func pickSprite():
	var sprite;
	var otherSprite;
	if type == BulletType.enemyBullet:
		sprite = $EnemyBulletSprite
		otherSprite = $PlayerBulletSprite
	else:
		sprite = $PlayerBulletSprite
		otherSprite = $EnemyBulletSprite
	sprite.show()
	otherSprite.hide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	print("✅ HIT!", body.name)
	queue_free()
