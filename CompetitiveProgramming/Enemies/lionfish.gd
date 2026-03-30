extends CharacterBody2D





















@export var l_speed : int = 100
var target : CharacterBody2D
#nemo

func _physics_process(_par):
	target = _finding_nemo()
	# nemo is gonna be cooked if they eat nemo
	if target:
		var direction = (target.position - position).normalized()
		#target not null
		
		velocity = direction * speed
		move_and_slide()

		#check collision



		if position.distance_to(target.position) <= 50:
			target.eaten()
			Game.nemo_killed += 1
		
			if Game.nemo_target == Game.nemo_killed:
				print("you won this level")
				# to be implemented later

		if velocity.x < 0 and $LionfishSprite.flip_x == true:
			$LionfishSprite.flip_x = false
		elif velocity.x > 0 and $LionfishSprite.flip_x == false:
			%LionfishSprite.flip_x = true

# nemo is kind of cooked

func _finding_nemo() -> CharacterBody2D:
	var near_nemo : CharacterBody2D = null
	#set to null first
	var min_dis = 10000005
	for idv_nemo in get_tree().get_nodes_in_group("Nemos"):
		if idv_nemo is CharacterBody2D:
			var distance = position.distance_to(idv_nemo.position)
			if distance < min_dis:
				min_dis = distance
				near_nemo = idv_nemo
	return near_nemo
