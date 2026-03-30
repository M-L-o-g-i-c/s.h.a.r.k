extends Marker2D





















@export var lionfish_scene: PackedScene 

@export var count: int = 3
@export var delay: float = 6.0

func _ready():
	for i in range(count):
		if lionfish_scene:
			var new_fish = lionfish_scene.instantiate()
			# Add random scatter
			new_fish.position = position + Vector2(randi_range(-100, 100), randi_range(-100, 100))
			get_parent().add_child.call_deferred(new_fish)
		
		# Wait for the next one
		await get_tree().create_timer(delay).timeout
