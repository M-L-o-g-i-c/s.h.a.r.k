extends Marker2D





















@export var fish_scene: PackedScene
@export var count: int = 5

func _ready():
	for i in range(count):
		var new_fish = fish_scene.instantiate()
		# Just add some random noise to the position
		new_fish.position = Vector2(randi() % 100 - 50, randi() % 100 - 50)
		add_child.call_deferred(new_fish)
