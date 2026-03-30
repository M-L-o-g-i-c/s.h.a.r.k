extends Node2D





















var starfish_scene : PackedScene = preload("res://scenes/characterScenes/enemies/starfish.tscn")
const MAX_SPAWN : int = 10
@export var spawned_starfish : int = 0


func _on_spawn_timeout():
	if(spawned_starfish <= MAX_SPAWN):
		spawned_starfish += 1;
		var starfish_instance : Node2D = starfish_scene.instantiate()
		starfish_instance.position = position + Vector2(randi_range(-150, 150), randi_range(-150, 150))
	
		get_parent().add_child(starfish_instance)

	# spawner needs a good remake https://www.qianwen.com/chat/8a9b9872d74543f28aea71a58410d58c








																	 
