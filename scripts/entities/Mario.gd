extends KinematicBody2D

var screensize  # Size of the game window.
var lookDirection = Vector2(1.0, 0.0)

func _ready():
	screensize = get_viewport_rect().size
	$BananaSprite.animation = "Firing"
	$BananaSprite.position.x = 7
	pass

export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 1200

var velocity = Vector2()
var jumping = false
var lastDirLeft = false

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('RIGHT')
	var left = Input.is_action_pressed('LEFT')
	var jump = Input.is_action_just_pressed('A')
	var firing = Input.is_action_just_pressed('B')
	
	if firing:
		$BananaSprite.frame = 0
		$BananaSprite.play()

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
		$BodySprite.animation = "Jump"
	if right:
		$BananaSprite.position.x = 7
		velocity.x += run_speed
		if is_on_floor() and !jumping:
			$BodySprite.animation = "Run"
		lookDirection = Vector2(1.0, 0.0)
		lastDirLeft = false
	if left:
		$BananaSprite.position.x = -7
		velocity.x -= run_speed
		if is_on_floor() and !jumping:
			$BodySprite.animation = "Run"
		lookDirection = Vector2(-1.0, 0.0)
		lastDirLeft = true

	if is_on_floor():
		$BodySprite.animation = "Idle"

	$BodySprite.flip_h = !lastDirLeft
	$BananaSprite.flip_h = !lastDirLeft
			
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_BananaSprite_animation_finished():
	$BananaSprite.stop()
	pass # replace with function body
