extends Node2D





















@export var time_left : int = 100
var logos : String

func _onready():
	_update_label()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
func _process(_par : float):
	_update_label()
	if Game.oil_val+Game.general_val+Game.plastic_val >= 12:
		$Logos/ALERT.text = "YOU WON"
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
	
	
	
func _update_label():
	if(time_left > 30):
		$Logos/ALERT.text = "Time left : " + str(time_left)
		$Logos/ALERT.modulate = Color.GREEN
	else:
		$Logos/ALERT.text = "TIME ALMOST UP : " + str(time_left)
		$Logos/ALERT.modulate = Color.RED
	$Logos/OilProgress.text = str(Game.oil_val) + "/4"
	$Logos/GeneralProgress.text = str(Game.general_val) + "/4"
	$Logos/PlasticProgress.text = str(Game.plastic_val) + "/4"
	$Logos/TYPE.text = $SHARK.is_holding
	
