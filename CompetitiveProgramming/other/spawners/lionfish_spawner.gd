extends Node2D





















@export var lionfish_scene: PackedScene
@export var clownfish_scene: PackedScene

# 
# x = Width, y = Height of the spawning area
@export var spawn_area_size: Vector2 = Vector2(800, 600) 

# Counts
@export var lionfish_count: int = 3
@export var clownfish_count: int = 12

func _ready():
	randomize()
	
	# Spawn the enemies
	spawn_fish(lionfish_scene, lionfish_count, "enemies")
	
	
	# Spawn the friends
	spawn_fish(clownfish_scene, clownfish_count, "clownfish")

func spawn_fish(scene: PackedScene, count: int, group_name: String):
	
	if scene == null:
		push_error("Missing Scene Reference! Drag the .tscn file into the Inspector.")
		return

	for i in range(count):
		# 1. Create the instance
		var fish = scene.instantiate()
		
		# 2. Calculate Random 2D Position
		# We pick a random X and Y relative to the center (0,0)
		var random_x = randf_range(-spawn_area_size.x / 2, spawn_area_size.x / 2)
		var random_y = randf_range(-spawn_area_size.y / 2, spawn_area_size.y / 2)
		
		# Set position
		fish.position = Vector2(random_x, random_y)
		
		# 3. Add to Group (for logic lookup)
		fish.add_to_group(group_name)
		
		# 4. Add to the Scene Tree
		add_child(fish)
