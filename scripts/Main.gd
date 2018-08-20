extends Node

export (PackedScene) var Banana

func _process(delta):
	if $BulletCoolDown.is_stopped() and Input.is_action_pressed('B'):
		var banana = Banana.instance()
		add_child(banana)
		var bananaOffset
		if $Mario.lastDirLeft:
			banana.start($Mario.position + Vector2(-10, 0), PI)
		else:
			banana.start($Mario.position + Vector2(10, 0), 0)

		$BulletCoolDown.start()
		
	# Sync background and post-process shader positions with camera. TODO: Fix this hack
	$ShaderOverlay.rect_position = $Mario/Pivot/CameraOffset/Camera2D.get_camera_screen_center() - Vector2(80, 72)
	$Background.rect_position = $Mario/Pivot/CameraOffset/Camera2D.get_camera_screen_center() - Vector2(80, 72)

func _on_BulletCoolDown_timeout():
	$BulletCoolDown.stop()

