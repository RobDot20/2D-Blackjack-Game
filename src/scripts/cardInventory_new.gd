extends Node

class_name CardInv

@onready var h_box_container: HBoxContainer = $HBoxContainer

@export var inventory : Array[PlayingCard]
var value : int = 0
var ace_pos : int = -1
var nr_pos_carte : int = 0 
func _init() -> void:
	pass
	#inventory.resize(11) 

func calc_value():
	for i in range(inventory.size()):
		if inventory[i].number == 1 :
			ace_pos = i
		value += inventory[i].value
	if value > 21 and ace_pos != -1 :
		inventory[ace_pos].value = 1
	return value

func add_card(card):
	inventory.append(card)
	var texture_box = h_box_container.get_child(nr_pos_carte)
	print(texture_box)
