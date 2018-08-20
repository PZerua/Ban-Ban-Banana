extends KinematicBody2D

var speed = 50
var velocity = Vector2()

func _ready():
	add_to_group("bullet")
	
func start(pos, dir):
	#rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision and !collision.collider.is_in_group("player") and !collision.collider.is_in_group("bullet"):
		queue_free()
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()