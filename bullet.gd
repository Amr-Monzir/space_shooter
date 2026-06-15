class_name Bullet
extends Area2D


enum Direction {up, down}
enum BulletType {playerBullet, enemyBullet}

var direction: Direction = Direction.up
var type: BulletType = BulletType.enemyBullet

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
	if direction == Direction.up:
		position.y = position.y - 5;
	else:
		position.y = position.y + 5;
		

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
