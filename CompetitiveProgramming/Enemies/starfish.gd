extends CharacterBody2D





















const STARFISH_HEALTH : int = 200
const STARFISH_SPEED : int = 50
const STARFISH_ASSETS : Array[Resource]  = [preload("res://scenes/almostUseless/don'tGoonToThis/icon.svg"), preload("res://assets/art/parrotfish/parrotfish.png"), preload("res://assets/art/Hermit_crab_animation_loop/Hermit_crab.png")]
var randskin = randi_range(0, 2)
@onready var player_instance : Shark = get_node("../SHARK")

func _ready():
	$StarfishSprite.texture = STARFISH_ASSETS[randskin]

var is_caught_in4k : bool = false




func _on_detection_area_body_entered(body):
	is_caught_in4k = true







func _on_detection_area_body_exited(body):
	is_caught_in4k = false
	
	
func _process(_par : float):
	var shark_position = player_instance.position
	var target_position = (shark_position - position).normalized()
	if(is_caught_in4k):
		velocity = target_position * STARFISH_SPEED
		move_and_slide()
		look_at(shark_position)
