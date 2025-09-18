extends Control

@onready var power_1 : Button = $power1
@onready var power_2 : Button = $power2
@onready var power_3 : Button = $power3

@onready var buy : Button = $Buy

#var money = Globals.player_money  banii globali

var money = 100

var spell_1 := Spell.new(10)
var spell_2 := Spell.new(13)
var spell_3 := Spell.new(15)

var button_costs = {
	"power1": 10,
	"power2": 20,
	"power3": 30
}

#func _ready():
	#$Buy.connect("pressed", self, "_on_buy_pressed")

func _on_buy_pressed():
	var total_cost := 0

	if $power1.pressed:
		total_cost += button_costs["power1"]
	if $power2.pressed:
		total_cost += button_costs["power2"]
	if $power3.pressed:
		total_cost += button_costs["power3"]

	if money >= total_cost:
		money -= total_cost
		print("Purchase successful! Money left:", money)

		# reset toggles
		power_1.button_pressed = false
		power_2.button_pressed = false
		power_3.button_pressed = false
	else:
		print("Not enough money! Need: ", total_cost, " but only have:", money)


#func _ready():
	#power_1.connect("toggled", self, "buy_pressed()")
	#power_2.connect("toggled", self, "buy_pressed")
	#power_3.connect("toggled", self, "buy_pressed")

#func buy_pressed():
	#if power_1_pressed()
	#print (money)
#
#
#
#func power_1_pressed(toggled_on: bool) -> bool:
	#return toggled_on
#
#
#func power_2_pressed(toggled_on: bool) -> bool:
	#return toggled_on
#
#
#func power_3_pressed(toggled_on: bool) -> bool:
	#return toggled_on
