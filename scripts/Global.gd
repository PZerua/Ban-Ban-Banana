extends Node

func _ready():
	AudioServer.set_bus_volume_db(0, -30)