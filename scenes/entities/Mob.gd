extends KinematicBody2D

signal enemy_killed
var direction = Vector2()
var screensize 
var follow = false
var distance
var speed = 0
var enemySpeedMin = 10
var enemySpeedMax = 15
var jumping = false

export (int) var run_speed = 20
export (int) var jump_speed = -400
export (int) var gravity = 1200

var velocity = Vector2()

onready var player = get_parent().get_node("Mario")
func _ready():
	# Initiate Randomization
	randomize()
	# Init variables
	# get Screensize 
	screensize = get_viewport_rect().size
	# set speed between Min & Max values
	speed = rand_range(enemySpeedMin, enemySpeedMax)
	# init AI variables 
	follow = false
	
		
func _physics_process(delta):
	velocity.x = 0
	# AI rules
	# get direction / distance of player
	direction = player.position - self.position
	distance = sqrt(direction.x * direction.x + direction.y * direction.y)
	if distance < 70:
		follow = true
	else:
		follow = false
	# Move Enemy towards player if follow is true
	if follow == true:
		# Determine whether to flip enemy image to face player
		if direction.x > 0:
			velocity.x += run_speed
			# Set Enemy facing right
			$AnimatedSprite.flip_h = true
		else:
			velocity.x -= run_speed
			# Set Enemy facing left
			$AnimatedSprite.flip_h = false
	
	if is_on_wall():
		jumping = true
		velocity.y = jump_speed
		
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))

	
	print(velocity)