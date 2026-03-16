extends Node2D





















var starfish_scene : PackedScene = preload("res://scenes/characterScenes/enemies/starfish.tscn")
const MAX_SPAWN : int = 10
@export var spawned_starfish : int = 0


func _on_timer_timeout():
	spawned_starfish += 1;
	var starfish_instance : Node2D = starfish_scene.instantiate()
	starfish_instance.position = position + Vector2(randi_range(-150, 150), randi_range(-150, 150))
	get_parent().add_child(starfish_instance)
