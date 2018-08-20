extends KinematicBody2D

export (int) var gravity = 200
var speed = 110
var velocity = Vector2()

func start(pos, dir):
	#rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	velocity.y += gravity * delta
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
		#if collision.collider.has_method("hit"):
			#collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()