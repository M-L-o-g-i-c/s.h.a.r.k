extends Area2D





















func _on_body_entered(_bud):
	if Game.levels_won[2]: get_tree().call_deferred("change_scene_to_file", "res://scenes/mainTasks/earlyStage/level_2.tscn")
