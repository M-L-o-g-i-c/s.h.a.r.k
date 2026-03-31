extends Control





















func _on_enter_pressed():
	if not Game.replayed:
		get_tree().change_scene_to_file("res://scenes/BUGUANLE/enter_text.tscn")
		Game.replayed = true
	else: get_tree().change_scene_to_file("res://scenes/main.tscn")
# display intro first

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/pause/credit_page.tscn")
	
	
	
	
func _on_quit_pressed():
	get_tree().quit()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
