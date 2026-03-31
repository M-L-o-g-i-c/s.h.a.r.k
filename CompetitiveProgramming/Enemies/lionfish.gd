extends CharacterBody2D





















class_name Lionfish

@export var l_speed: int = 100
@export var detection_range: int = 500
var target: CharacterBody2D = null
var is_alive: bool = true

func _ready():  # 修复1: 修正函数名
	add_to_group("lionfish")

func _physics_process(_delta):
	if not is_alive: 
		return
	
	# 修复2: 统一使用global_position
	target = _finding_nemo()
	
	if target:
		# 修复3: 使用global_position计算方向
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * l_speed
		move_and_slide()
		
		# 修复4: 使用global_position计算距离
		if global_position.distance_to(target.global_position) <= 50:
			target.die()
			Game.nemo_killed += 1
			
			if Game.nemo_target == Game.nemo_killed:
				get_tree().change_scene_to_file("res://scenes/menus/ggs.tscn")
	
	# 修复5: 统一使用global_position
	if velocity.x > 0:
		$LionfishSprite.flip_h = false
	else:
		$LionfishSprite.flip_h = true

func _finding_nemo() -> CharacterBody2D:
	var nearest_nemo: CharacterBody2D = null
	var min_distance: float = detection_range  # 修复6: 使用检测范围作为初始值
	
	for nemo in get_tree().get_nodes_in_group("Nemos"):
		if nemo is CharacterBody2D and nemo.is_alive:  # 修复7: 只追踪存活目标
			var distance = global_position.distance_to(nemo.global_position)
			if distance < min_distance:
				min_distance = distance
				nearest_nemo = nemo
	
	return nearest_nemo

func die():
	is_alive = false
	queue_free()
