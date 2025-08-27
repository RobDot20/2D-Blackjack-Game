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

func _ready():
	print(spell_1.price)
	

func buy_pressed():
	if power_1.pressed:
		money = money - spell_1.price
	if power_2.pressed:
		money = money - spell_2.price
	if power_3.pressed:
		money = money - spell_3.price
	print(money)
