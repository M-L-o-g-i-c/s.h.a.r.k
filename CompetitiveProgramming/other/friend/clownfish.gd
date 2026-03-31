extends CharacterBody2D





















class_name Nemo

@export var idle_speed: int = 80      # 无威胁时游动速度
@export var panic_speed: int = 200    # 被追逐时逃跑速度
@export var idle_range: int = 100     # 左右游动范围半径

var is_alive = true
var spawn_position: Vector2           # 出生点位置
var idle_direction: int = 1           # 1=向右, -1=向左

func _ready():
	add_to_group("Nemos")
	spawn_position = global_position   # 记录出生点
	$ClownfishSprite.flip_h = false   # 初始朝向右

func _physics_process(_delta):
	if not is_alive: return

	# 1. 检测威胁
	var enemies = get_tree().get_nodes_in_group("lionfish")
	var nearest = null
	if enemies.size() > 0:
		nearest = enemies[0]

	# 2. 行为逻辑
	if nearest:
		# **被追逐时：沿X轴逃离**
		if global_position.x < nearest.global_position.x:
			# 狮子鱼在右侧 → 向左逃
			velocity = Vector2(-panic_speed, 0)
			$ClownfishSprite.flip_h = true
		else:
			# 狮子鱼在左侧 → 向右逃
			velocity = Vector2(panic_speed, 0)
			$ClownfishSprite.flip_h = false
	else:
		# **无威胁时：左右游动**
		# 检查是否超出范围
		if global_position.x > spawn_position.x + idle_range:
			idle_direction = -1  # 向左转
			$ClownfishSprite.flip_h = true
		elif global_position.x < spawn_position.x - idle_range:
			idle_direction = 1   # 向右转
			$ClownfishSprite.flip_h = false
		
		# 按当前方向移动
		velocity = Vector2(idle_speed * idle_direction, 0)

	# 3. 状态同步
	move_and_slide()

func die():
	is_alive = false
	queue_free()
