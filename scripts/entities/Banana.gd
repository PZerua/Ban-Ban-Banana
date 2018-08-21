extends KinematicBody2D

export (int) var gravity = 120
var speed = 140
var velocity = Vector2()

func start(pos, dir):
	$AnimationPlayer.stop(true)
	randomize()
	rotation = randf();
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	velocity.y += gravity * delta
	rotate((randf() * 2.0 - 1.0) * 0.2)
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity.x = 0.0
		if (!$AnimationPlayer.is_playing()):
			$AnimationPlayer.play("Destroy")
		#if collision.collider.has_method("hit"):
			#collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	pass # replace with function body
