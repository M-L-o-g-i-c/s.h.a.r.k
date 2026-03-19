extends CharacterBody2D





















const STARFISH_HEALTH : int = 200
const STARFISH_SPEED : int = 50
const STARFISH_ASSETS : Array[Resource]  = [
	preload("res://assets/art/created_assets/enemies/non_gif/crown of thorns - purple.png"),
 	preload("res://assets/art/created_assets/enemies/non_gif/crown of thorns - red.png"),
 	preload("res://assets/art/created_assets/enemies/non_gif/crown of thorns - yellow.png"),
]
# alternate between three colors

















var randskin = randi_range(0, 2)
@onready var player_instance : Shark = get_node("../SHARK")

func _ready():
	$StarfishSprite.texture = STARFISH_ASSETS[randskin]

var is_caught_in4k : bool = false




func _on_detection_area_body_entered(body):
	if body is Shark:
		# if the body is type shark


		print("entered")
		is_caught_in4k = true





















func _on_detection_area_body_exited(body):
	if body is Shark:
		print("exited")
		is_caught_in4k = false
		#gives up chasing player, goes back to idle
	
func _process(_par : float):
	var shark_position = player_instance.position
	var target_position = (shark_position - position).normalized()
	if(is_caught_in4k):
		velocity = target_position * STARFISH_SPEED
		move_and_slide()
		look_at(shark_position)
		#look at and follow player if player is detected
