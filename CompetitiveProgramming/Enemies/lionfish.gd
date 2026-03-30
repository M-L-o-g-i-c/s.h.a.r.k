extends CharacterBody2D





















class_name Lionfish
@export var l_speed : int = 100
var target : CharacterBody2D
var is_alive : bool = true

func _onready():
	add_to_group("lionfish")
	
func _physics_process(_par):
	if not is_alive: return
	target = _finding_nemo()
	if target:
		var direction = (target.position - position).normalized()
		#target not null
		
		velocity = direction * l_speed
		move_and_slide()

		#check collision



		if position.distance_to(target.position) <= 50:
			target.eaten()
			Game.nemo_killed += 1
		
			if Game.nemo_target == Game.nemo_killed:
				get_tree().change_scene_to_file("res://scenes/menus/ggs.tscn")
				# to be implemented later

		if velocity.x > 0:
			$LionfishSprite.flip_h = false
		else:
			$LionfishSprite.flip_h = true

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
	
func die():
	is_alive = false
	queue_free()
