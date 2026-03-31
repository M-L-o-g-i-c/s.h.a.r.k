extends Area2D





















@export var trash_look : Texture2D
@export var trash_type : String

# oil general or plastic


func _ready():
	$Sprite2D.texture = trash_look
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Shark:
		if not body.is_holding:
			body.is_holding = true
			body.held_item = trash_type
			
			
			queue_free()
