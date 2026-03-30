extends CharacterBody2D





















class_name Nemo

@export var speed: int = 100
@export var panic_speed: int = 200
@export var wander_range: int = 150

var target: Vector2
var is_alive = true

func _ready():
	add_to_group("Nemos")
	target = global_position

func _physics_process(_delta):
	if not is_alive: return

	# 1. Find Enemy (Simple check)
	var enemies = get_tree().get_nodes_in_group("lionfish")
	var nearest = null
	if enemies.size() > 0:
		# Just grabbing the first enemy found for simplicity
		nearest = enemies[0] 

	# 2. Move
	if nearest:
		# Flee
		velocity = (global_position - nearest.global_position).normalized() * panic_speed
	else:
		# Wander
		# FIX: Use direction_to instead of move_toward.direction
		velocity = global_position.direction_to(target) * speed
		look_at(target)
		
		# Pick new target if close enough
		if global_position.distance_to(target) < 5:
			# Pick random spot relative to current position
			var random_x = randi() % (wander_range * 2) - wander_range
			var random_y = randi() % (wander_range * 2) - wander_range
			target = global_position + Vector2(random_x, random_y)
	if velocity.x > 0: $ClownfishSprite.flip_h = false
	else: $ClownfishSprite.flip_h = true
	move_and_slide()

func die():
	is_alive = false
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
