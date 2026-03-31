extends Node





















var coin_count : int = 0

#level 1
var starfish_killed : int = 0
var lionfish_killed : int = 0
const STARFISH_TARGET : int = 6
const LIONFISH_TARGET : int = 0

# comment signal coin_earned()
# comment signal coin_gained()
# gained means free money
# everything is better when they are free

#comment signal coin_lost()
#comment signal coin_spent()











var levels_won : Array[bool] = [true, false, false, false, false, false, false]


# checks each individual level to see if they are enterable (no reentry)



func add_coin(increment : int):
	coin_count += increment
	#emit signal
	
	
func spend_coin(decrement : int):
	coin_count -= decrement
	
								 





const nemo_target : int = 15
var nemo_killed : int = 0
var passed : int = 0














# below are our level 2 variables


# goals
const BIN_GOAL : int = 4
const TOTAL_BINS : int = 12

#amounts
var oil_val : int = 0
var general_val : int = 0
var plastic_val : int = 0
var total_val : int = 0




#ok good
var replayed : bool = false
