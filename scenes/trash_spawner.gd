extends Marker2D





















@export var trash_scene : PackedScene
var oil_arr : Array[Texture2D] =    [
	preload("res://assets/art/created_assets/OBJ/oil/oil 1.png"),
	preload("res://assets/art/created_assets/OBJ/oil/oil 2.png"),
	preload("res://assets/art/created_assets/OBJ/oil/oil 3.png"),
	preload("res://assets/art/created_assets/OBJ/oil/oil 4.png"),
	]
@export var spawn_spread : int = 400
	
	
	
var plastic_arr : Array[Texture2D] = [
	preload("res://assets/art/created_assets/OBJ/plastic/plastic 1.png"),
	preload("res://assets/art/created_assets/OBJ/plastic/plastic 2.png"),
	preload("res://assets/art/created_assets/OBJ/plastic/plastic 3.png"),
	preload("res://assets/art/created_assets/OBJ/plastic/plastic 2.png")
]
	

# texture2d < resource	
	
	

var general_arr : Array[Texture2D] = [
	preload("res://assets/art/created_assets/OBJ/other/can 2.png"),
	preload("res://assets/art/created_assets/OBJ/other/can 1.png"),
	preload("res://assets/art/created_assets/OBJ/plastic/net 1.png"),
	preload("res://assets/art/created_assets/OBJ/plastic/net 2.png"),
]
var trashnode : PackedScene = preload("res://scenes/BUGUANLE/trash.tscn")

func _ready():
	for i in range(4):
		var trash1 = trashnode.instantiate()
		var trash2 = trashnode.instantiate()
		var trash3 = trashnode.instantiate()
		add_child(trash1)
		add_child(trash2)
		add_child(trash3)
		trash1.trash_type = "OIL"
		trash2.trash_type = "GENERAL"
		trash3.trash_type = "PLASTIC"
		trash1.trash_look = oil_arr[i]
		trash2.trash_look = general_arr[i]
		trash3.trash_look = plastic_arr[i]
		@warning_ignore("integer_division")
		var offset1 = Vector2(randi_range(-spawn_spread/2, spawn_spread/2), randi_range(-spawn_spread/2, spawn_spread/2))
		@warning_ignore("integer_division")
		# don't worry guyz we don't need precise points so ill just blur this out
		var offset2 = Vector2(randi_range(-spawn_spread/2, spawn_spread/2), randi_range(-spawn_spread/2, spawn_spread/2))
		@warning_ignore("integer_division")
		var offset3 = Vector2(randi_range(-spawn_spread/2, spawn_spread/2), randi_range(-spawn_spread/2, spawn_spread/2))
		trash1.global_position = global_position + offset1
		trash2.global_position = global_position + offset2
		trash3.global_position = global_position + offset3
		
