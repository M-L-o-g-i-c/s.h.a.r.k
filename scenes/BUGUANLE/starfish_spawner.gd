extends Marker2D





















@export var starfish_scene: PackedScene = preload("res://scenes/characterScenes/enemies/starfish.tscn")
const MAX_SPAWN: int = 5

func _ready():
	# Loop 5 times
	for i in range(MAX_SPAWN):
		# Create a new Starfish
		var starfish_instance = starfish_scene.instantiate()
		
		# Add a little random scatter around the marker
		starfish_instance.position = position + Vector2(randi_range(-150, 150), randi_range(-150, 150))
		
		# Add it to the scene
		get_parent().add_child.call_deferred(starfish_instance)
		
		# Wait 6 seconds before making the next one
		await get_tree().create_timer(6).timeout
		
		
