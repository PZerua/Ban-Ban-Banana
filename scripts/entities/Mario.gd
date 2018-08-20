extends KinematicBody2D

export (int) var speed  # How fast the player will move (pixels/sec).
var screensize  # Size of the game window.

func _ready():
	add_to_group("player")
	screensize = get_viewport_rect().size
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

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
		$AnimatedSprite.animation = "Jump"
	if right:
		velocity.x += run_speed
		if is_on_floor() and !jumping:
			$AnimatedSprite.animation = "Run"
		lastDirLeft = false
	if left:
		velocity.x -= run_speed
		if is_on_floor() and !jumping:
			$AnimatedSprite.animation = "Run"
		lastDirLeft = true
		
	if velocity.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.animation = "Idle"

	$AnimatedSprite.flip_h = lastDirLeft
		
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
