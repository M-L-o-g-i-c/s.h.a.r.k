extends Node





















var coin_count : int = 0

signal coin_earned()
signal coin_gained()
# gained means free money
# everything is better when they are free

signal coin_lost()
signal coin_spent()


















func add_coin(increment : int):
	coin_count += increment
	#emit signal
	coin_earned
	
	
func spend_coin(decrement : int):
	coin_count -= decrement
