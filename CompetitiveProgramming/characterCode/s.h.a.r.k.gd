extends CharacterBody2D





















class_name Shark

var SPEED : int = 200
# I decided to make speed a variable instead of a CONSTANT
var is_flipped : bool = false
# we actually don't need this but clarity > conciseness 
var parent : Node2D = get_parent()



















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
const BOOST_MULTIPLIER : int = 3











func boost():
	if Input.is_action_pressed("boost") and can_boost:
		is_boosting = true
		can_boost = false
		$DashTime.start()

		





func _on_dash_time_timeout():
	is_boosting = false
	$DashCooldownTime.start()



func _on_dash_cooldown_time_timeout():
	can_boost = true
	
	
var hunger_pause : bool = false;
#every 0.5 seconds decrease by 25	
	
	








func _on_hunger_timer_timeout():
	hunger_pause = false
	
	
func sub_calories():
	if(abs(velocity.x) > 0 and not hunger_pause and abs(velocity.y) > 0):
		$Calories.value -= 10
		$HungerTimer.start()
		hunger_pause = true
		print($Calories.value)
		if($Calories.value <= 0): get_tree().change_scene_to_file("res://scenes/menus/ggs.tscn")
		
		

func _process(_par : float):
	basic_movement(Input.get_vector("left", "right", "up", "down"))
	boost()
	if is_boosting: velocity *= BOOST_MULTIPLIER
	sub_calories()
	move_and_slide()


@onready var starfish_ins : Starfish = get_node("../starfish")

func _on_boost_attack_body_entered(body : Node2D):
	if body is Starfish and is_boosting: is_boosting = false
	
		
