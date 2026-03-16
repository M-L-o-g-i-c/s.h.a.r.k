extends CharacterBody2D





















class_name Shark

const SPEED : int = 300
var is_flipped : bool = false

func basic_movement(direction : Vector2):
	velocity = direction * SPEED
	if(direction.x < 0 and is_flipped):
		is_flipped = not is_flipped
		$S_Sprite.flip_h = false
		
	if(direction.x > 0 and not is_flipped):
		is_flipped = not is_flipped
		$S_Sprite.flip_h = true










func _process(_par : float):
	basic_movement(Input.get_vector("left", "right", "up", "down"))
	move_and_slide()
