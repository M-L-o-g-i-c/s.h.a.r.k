extends Area2D






















func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
	


func _on_body_entered(_bd : Node2D):
	get_tree().call_deferred("change_scene_to_file", "res://scenes/mainTasks/earlyStage/level_1.tscn")
