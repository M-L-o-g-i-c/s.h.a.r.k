extends Control





















var can_skip : bool = false

func _ready():
	$CanvasLayer/sk.hide()
	await get_tree().create_timer(1.5).timeout
	$CanvasLayer/sk.show()
	can_skip = true






func _process(_par : float):
	if can_skip and Input.is_action_just_pressed("continue"):
		get_tree().change_scene_to_file("res://scenes/menus/pause/BIGMENU.tscn")
