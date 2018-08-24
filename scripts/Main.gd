extends Node

export (PackedScene) var Banana

func _process(delta):
	if $BulletCoolDown.is_stopped() and Input.is_action_pressed('B'):
		var banana = Banana.instance()
		add_child_below_node($Player, banana)
		var bananaOffset
		if $Player.lastDirLeft:
			banana.start($Player.position + Vector2(-10, 0), PI)
		else:
			banana.start($Player.position + Vector2(10, 0), 0)

		$BulletCoolDown.start()
		
	# Sync background and post-process shader positions with camera. TODO: Fix this hack
	var cam_pos = $Player/Pivot/CameraOffset/Camera2D.get_camera_screen_center()
	$ShaderOverlay.rect_position = cam_pos - Vector2(80, 72)
	$Background.rect_position = cam_pos - Vector2(80, 72)

func _on_BulletCoolDown_timeout():
	$BulletCoolDown.stop()
	