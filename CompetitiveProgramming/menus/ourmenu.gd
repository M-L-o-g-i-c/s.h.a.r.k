extends Control





















func _on_enter_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/pause/credit_page.tscn")
	
func _on_quit_pressed():
	get_tree().quit()
	
