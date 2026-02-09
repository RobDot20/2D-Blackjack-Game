extends Node2D

class_name CardInv

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var card_scene = preload("res://src/scenes/card_slot.tscn")

@export var inventory : Array[PlayingCard]
@export var slot_inv : Array[Slot]

var value : int = 0
var ace_in_pos : int = -1
var nr_pos_carte : int = 0
var x_offset = 0.0
var x_step = 150


#func calc_value():
	#value = 0
	#for i in range(inventory.size()):
		#if inventory[i].number == 1 :
			#ace_in_pos = i
		#value += inventory[i].value
	#if value > 21 and ace_in_pos != -1 :
		#inventory[ace_in_pos].value = 1
	#return value

func calc_value():
	value = 0
	for i in range(slot_inv.size()):
		if slot_inv[i].card.number == 1 :
			ace_in_pos = i
		value += slot_inv[i].card.value
	if value > 21 and ace_in_pos != -1 :
		slot_inv[ace_in_pos].card.value = 1
	return value

func add_card(card:PlayingCard):
	inventory.append(card)
	var new_slot : Slot = card_scene.instantiate()
	slot_inv.append(new_slot)
	add_child(new_slot)
	new_slot.change_card(card)
	new_slot.position.x += x_offset
	x_offset += x_step

func remove_card():
	get_child(1).queue_free()
	x_offset -= x_step
