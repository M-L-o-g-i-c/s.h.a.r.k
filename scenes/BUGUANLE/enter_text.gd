extends Control





















var can_skip : bool = false

func _ready():
	$CanvasLayer/Label.hide()
	await get_tree().create_timer(5.0).timeout
	can_skip = true
	$CanvasLayer/Label.show()
	
func _process(_par : float):
	if(Input.is_action_just_pressed("continue")): get_tree().change_scene_to_file("res://scenes/main.tscn")
