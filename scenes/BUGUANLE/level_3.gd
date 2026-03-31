extends Node2D

const WIN_CONDITION3 : int = 8
const MAX_REEF_HEALTH : int = 100
const BASE_WAVE_STRENGTH : int = 18

const SEED_STATION_RECT : Rect2 = Rect2(382, 18, 388, 86)
const WATER_RECT : Rect2 = Rect2(0, 120, 1152, 528)
const STREAM_RECT : Rect2 = Rect2(96, 196, 760, 330)
const SHORE_RECT : Rect2 = Rect2(840, 176, 70, 360)
const REEF_RECT : Rect2 = Rect2(910, 120, 242, 528)
const PLANT_ZONE_RECT : Rect2 = Rect2(730, 360, 140, 150)

@onready var shark : Node2D = $SHARK
@onready var wave_spawn_timer : Timer = $WaveSpawnTimer
@onready var difficulty_timer : Timer = $DifficultyTimer
@onready var seed_respawn_timer : Timer = $SeedRespawnTimer

@onready var status_label : Label = $HUD/StatusLabel
@onready var reef_label : Label = $HUD/ReefHealthLabel
@onready var mangrove_label : Label = $HUD/MangroveCountLabel
@onready var danger_label : Label = $HUD/DangerLabel

var carrying_seed : bool = false
var seed_available : bool = true
var reef_health : int = MAX_REEF_HEALTH
var planted_mangroves : int = 0
var game_over : bool = false

var wave_speed : float = 175.0
var wave_scale : float = 1.0
var wave_interval : float = 2.25
var danger_level : int = 1

var planted_positions : Array[Vector2] = []
var waves : Array[Dictionary] = []
var status_message : String = ""


func _ready() -> void:
	randomize()
	wave_spawn_timer.wait_time = wave_interval
	wave_spawn_timer.start()
	difficulty_timer.start()
	update_hud()
	set_status("Swim to the seed bank at the top to collect a mangrove seed.")
	queue_redraw()


func _process(delta : float) -> void:
	if game_over:
		queue_redraw()
		return

	process_seed_station()
	process_plant_zone()
	process_waves(delta)
	queue_redraw()


func process_seed_station() -> void:
	if not seed_available:
		return

	if carrying_seed:
		return

	if SEED_STATION_RECT.has_point(shark.global_position):
		carrying_seed = true
		seed_available = false
		seed_respawn_timer.start()
		set_status("You picked up a mangrove seed. Carry it down to the stream bank!")
		update_hud()


func process_plant_zone() -> void:
	if not carrying_seed:
		return

	if not PLANT_ZONE_RECT.has_point(shark.global_position):
		return

	carrying_seed = false
	planted_mangroves += 1
	planted_positions.append(get_next_plant_position())

	if planted_mangroves >= WIN_CONDITION3:
		win_level()
		return

	set_status("Mangrove planted! Build a thicker barrier before the reef takes damage.")
	update_hud()


func process_waves(delta : float) -> void:
	for i in range(waves.size() - 1, -1, -1):
		var wave : Dictionary = waves[i]
		wave["position"] += Vector2(wave["speed"] * delta, 0)

		var shark_hitbox : Rect2 = Rect2(shark.global_position - Vector2(20, 20), Vector2(40, 40))
		if wave_rect(wave).intersects(shark_hitbox):
			shark.global_position.y = clampf(shark.global_position.y + (45.0 * delta), 80.0, 610.0)
			shark.global_position.x = clampf(shark.global_position.x + (30.0 * delta), 40.0, 1110.0)

		if not wave.get("checked_mangroves", false) and wave["position"].x >= SHORE_RECT.position.x:
			wave["checked_mangroves"] = true
			var absorbed_strength : int = planted_mangroves * 4
			wave["strength"] = max(0, int(wave["strength"]) - absorbed_strength)
			wave["size"] = Vector2(max(16.0, float(wave["size"].x) - absorbed_strength * 1.6), max(12.0, float(wave["size"].y) - absorbed_strength * 1.2))

		if wave["position"].x >= REEF_RECT.position.x + 28:
			if int(wave["strength"]) > 0:
				reef_health = max(0, reef_health - int(wave["strength"]))
				set_status("The reef was hit! Plant more mangroves to weaken the incoming waves.")
				if reef_health <= 0:
					lose_level()
			waves.remove_at(i)
			update_hud()
			continue

		if wave["position"].x > 1220:
			waves.remove_at(i)
			continue

		waves[i] = wave


func spawn_wave() -> void:
	var wave_height : float = randf_range(34.0, 60.0) * wave_scale
	var wave_width : float = randf_range(52.0, 88.0) * wave_scale
	var spawn_y : float = randf_range(STREAM_RECT.position.y + 18.0, STREAM_RECT.end.y - 18.0)
	var strength : int = BASE_WAVE_STRENGTH + int((danger_level - 1) * 3) + randi_range(0, 4)

	waves.append({
		"position": Vector2(42, spawn_y),
		"size": Vector2(wave_width, wave_height),
		"speed": wave_speed + randf_range(-18.0, 22.0),
		"strength": strength,
		"checked_mangroves": false
	})


func get_next_plant_position() -> Vector2:
	var usable_width : float = PLANT_ZONE_RECT.size.x - 32.0
	var spacing : float = usable_width / float(max(1, WIN_CONDITION3 - 1))
	var x_pos : float = PLANT_ZONE_RECT.position.x + 16.0 + spacing * float(planted_mangroves - 1)
	var y_pos : float = PLANT_ZONE_RECT.end.y - randf_range(18.0, 34.0)
	return Vector2(x_pos, y_pos)


func wave_rect(wave : Dictionary) -> Rect2:
	var size : Vector2 = wave["size"]
	return Rect2(Vector2(wave["position"].x - size.x * 0.5, wave["position"].y - size.y * 0.5), size)


func update_hud() -> void:
	reef_label.text = "Reef Health: %d / %d" % [reef_health, MAX_REEF_HEALTH]
	mangrove_label.text = "Mangroves Planted: %d / %d" % [planted_mangroves, WIN_CONDITION3]
	danger_label.text = "Wave Level: %d" % danger_level


func set_status(new_status : String) -> void:
	status_message = new_status
	status_label.text = status_message


func win_level() -> void:
	game_over = true
	wave_spawn_timer.stop()
	difficulty_timer.stop()
	seed_respawn_timer.stop()
	set_status("Level complete! Your mangrove wall is strong enough to shield the reef.")
	update_hud()


func lose_level() -> void:
	game_over = true
	wave_spawn_timer.stop()
	difficulty_timer.stop()
	seed_respawn_timer.stop()
	set_status("Level failed. The reef flooded before the mangroves could hold the line.")
	update_hud()


func _on_wave_spawn_timer_timeout() -> void:
	if game_over:
		return
	spawn_wave()


func _on_difficulty_timer_timeout() -> void:
	if game_over:
		return

	danger_level += 1
	wave_speed += 22.0
	wave_scale += 0.14
	wave_interval = max(0.75, wave_interval - 0.18)
	wave_spawn_timer.wait_time = wave_interval
	set_status("The storm is getting worse. Hurry more seeds into the stream bank!")
	update_hud()


func _on_seed_respawn_timer_timeout() -> void:
	if game_over:
		return
	seed_available = true
	if not carrying_seed:
		set_status("A fresh seed is ready at the top bank.")
	update_hud()


func _draw() -> void:
	# sky and water
	draw_rect(Rect2(Vector2.ZERO, Vector2(1152, 648)), Color(0.62, 0.89, 0.98, 1.0), true)
	draw_rect(WATER_RECT, Color(0.1, 0.49, 0.77, 1.0), true)

	# incoming ocean, stream, shore, and reef zones
	draw_rect(Rect2(0, 120, 110, 528), Color(0.05, 0.33, 0.62, 1.0), true)
	draw_rect(STREAM_RECT, Color(0.14, 0.63, 0.85, 0.85), true)
	draw_rect(SHORE_RECT, Color(0.82, 0.74, 0.52, 1.0), true)
	draw_rect(REEF_RECT, Color(0.97, 0.73, 0.53, 1.0), true)

	# seed bank and planting zone guides
	draw_rect(SEED_STATION_RECT, Color(0.49, 0.33, 0.18, 0.95), true)
	draw_rect(PLANT_ZONE_RECT, Color(0.36, 0.56, 0.24, 0.35), true)
	draw_rect(PLANT_ZONE_RECT, Color(0.2, 0.4, 0.15, 0.8), false, 3.0)

	# seed pile visuals
	for i in range(6):
		var seed_pos := Vector2(SEED_STATION_RECT.position.x + 40.0 + i * 48.0, SEED_STATION_RECT.position.y + 46.0 + sin(float(i)) * 8.0)
		draw_circle(seed_pos, 8.0, Color(0.36, 0.22, 0.12, 1.0))
		draw_line(seed_pos, seed_pos + Vector2(0, -14), Color(0.15, 0.5, 0.2, 1.0), 2.0)

	# planted mangroves
	for plant_pos : Vector2 in planted_positions:
		draw_line(plant_pos, plant_pos + Vector2(0, -32), Color(0.35, 0.21, 0.08, 1.0), 5.0)
		draw_line(plant_pos + Vector2(0, -18), plant_pos + Vector2(-12, -34), Color(0.35, 0.21, 0.08, 1.0), 3.0)
		draw_line(plant_pos + Vector2(0, -18), plant_pos + Vector2(12, -34), Color(0.35, 0.21, 0.08, 1.0), 3.0)
		draw_circle(plant_pos + Vector2(-10, -40), 10.0, Color(0.11, 0.53, 0.2, 1.0))
		draw_circle(plant_pos + Vector2(10, -42), 10.0, Color(0.14, 0.61, 0.25, 1.0))
		draw_circle(plant_pos + Vector2(0, -52), 12.0, Color(0.18, 0.69, 0.28, 1.0))

	# incoming waves
	for wave : Dictionary in waves:
		var wave_box : Rect2 = wave_rect(wave)
		draw_rect(wave_box, Color(0.82, 0.96, 1.0, 0.9), true)
		draw_arc(Vector2(wave_box.position.x + wave_box.size.x * 0.2, wave_box.position.y + wave_box.size.y * 0.45), wave_box.size.y * 0.38, PI * 1.05, PI * 1.92, 8, Color.WHITE, 3.0)
		draw_arc(Vector2(wave_box.position.x + wave_box.size.x * 0.55, wave_box.position.y + wave_box.size.y * 0.48), wave_box.size.y * 0.35, PI * 1.05, PI * 1.95, 8, Color.WHITE, 3.0)
		draw_arc(Vector2(wave_box.position.x + wave_box.size.x * 0.84, wave_box.position.y + wave_box.size.y * 0.52), wave_box.size.y * 0.31, PI * 1.05, PI * 1.98, 8, Color.WHITE, 3.0)

	# carried seed icon above the shark
	if carrying_seed and is_instance_valid(shark):
		var icon_pos : Vector2 = shark.global_position + Vector2(0, -38)
		draw_circle(icon_pos, 9.0, Color(0.36, 0.22, 0.12, 1.0))
		draw_line(icon_pos, icon_pos + Vector2(0, -14), Color(0.15, 0.5, 0.2, 1.0), 2.0)
