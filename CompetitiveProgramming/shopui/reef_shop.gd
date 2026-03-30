extends Control





















var previous : int = 0
var flash_color : Color = Color.GOLD
var cs : String
var CCoins : int = 0:
	set(new_value):
		if(new_value < previous): flash_color = Color.RED
		else: flash_color = Color.GREEN
		$CoralCoins.modulate = flash_color
		cs = "Coral Coins : " + str(new_value)
		$CoralCoins.text = cs
		
		$CC.start()
		previous = new_value

func _on_cc_timeout():
	flash_color = Color.GOLD
	$CoralCoins.modulate = flash_color
	
	
	
	
	
enum MODE {
	OFF,
	ON
}

# enum increments each constant so it is basically 0 and 1
	#revert color
# flashes different colors each time +


# CCoins stand for coral coins
