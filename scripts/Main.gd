extends Node

export (PackedScene) var Banana

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if $BulletCooldown.is_stopped() and Input.is_action_pressed('B'):
		var banana = Banana.instance()
		add_child(banana)
		var bananaOffset
		if $Mario.lastDirLeft:
			banana.start($Mario.position + Vector2(-10, 0), PI)
		else:
			banana.start($Mario.position + Vector2(10, 0), 0)

		$BulletCooldown.start()

func _on_BulletCoolDown_timeout():
	$BulletCooldown.stop()
	pass # replace with function body
