extends Area2D





















class_name TrashBin

#there are 3 types of trash which are oil plastic and general 4*3 basically






















@export var bintype : String
const MAXBIN : int = 4
var mybin : int = 0
# the type assigned to the bins, they shoudl be str

func _ready():
	if bintype == "OIL":
		self_modulate = Color.DARK_RED
	elif bintype == "GENERAL":
		self_modulate = Color.SADDLE_BROWN
	elif bintype == "PLASTIC":
		self_modulate = Color.DODGER_BLUE
	#don't question it these are real colors in real life

var display_text : String
var to_increment : bool = false

func _on_body_entered(body):
	if body is Shark:
		if body.is_holding:
			if body.held_trash == bintype: to_increment = true
			else: to_increment = false
			if bintype == "OIL":
				if to_increment: Game.oil_val += 1
				else: wrong_bin(body.held_trash, bintype)
			elif bintype == "GENERAL":
				if to_increment: Game.general_val += 1
				else: wrong_bin(body.held_trash, bintype)
			elif bintype == "PLASTIC":
				if to_increment: Game.plastic_val += 1
				else: wrong_bin(body.held_trash, bintype)
		








var stringb : String
# thats about it for the displays


func wrong_bin(your_trash : String, bintrash : String):
	stringb = "WRONG BIN : TRIED TO PUT " + your_trash + " in " + bintrash
	$Logos/ALERT.text = stringb
	await get_tree().create_timer(1.0).timeout
	$Logos/ALERT.text = ""
