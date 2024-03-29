extends CanvasLayer

@onready var TheBang = $ColorRect

func _ready():
	$ChopSuey.wait_time = 1
	create_tween().tween_property(TheBang, "color", Color(1,1,1,0), .5)
	get_parent().Activate()

func _on_chop_suey_timeout():
	queue_free()
