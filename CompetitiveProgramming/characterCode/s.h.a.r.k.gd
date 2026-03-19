extends CharacterBody2D





















class_name Shark

var SPEED : int = 300
# I decided to make speed a variable instead of a CONSTANT
var is_flipped : bool = false
# we actually don't need this but clarity > conciseness 




















func basic_movement(direction : Vector2):
	velocity = direction * SPEED
	if direction.x < 0 and is_flipped:
		is_flipped = not is_flipped
		$S_Sprite.flip_h = false
		# flip left
	elif direction.x > 0 and not is_flipped:
		is_flipped = not is_flipped
		$S_Sprite.flip_h = true
		# flip right






# please make sure to use more functions so our process code is more concise





	
	
	
	
	
	
	
	
	
	
	
	
	
	


# below is the code for our boosting functions








var is_boosting : bool = false






var can_boost : bool = true
const BOOST_SPEED : int = 3

 









func boost():
	if(Input.is_action_pressed("boost") and can_boost):
		is_boosting = true
		can_boost = false
		$DashCooldownTime.start()
		$DashTime.start()
		velocity *= BOOST_SPEED

func _process(_par : float):
	
	
	basic_movement(Input.get_vector("left", "right", "up", "down"))
	move_and_slide()
