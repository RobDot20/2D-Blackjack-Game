extends Node

@onready var card_slot = preload("res://src/scenes/card_slot.tscn")
@onready var card_stack: Node2D = $CardStack
@onready var dealer_stack: Node2D = $DealerStack
@onready var player_score_display: Label = $PlayerScore/PlayerScoreDisplay
@onready var dealer_score_display: Label = $DealerScore/DealerScoreDisplay
@export var test_deck := Deck.new(false)

signal dealer_turn
signal end_round

var x_offset = 0.0
var xd_offset = 0.0
var x_step = 150

var hand_score := 0
var dealer_score := 0
var bust := false

func _ready() -> void:
	add_slot(2,1)
	add_slot(2,3)
	player_score_display.text = str(hand_score)
	dealer_score_display.text = str(dealer_score)
	#for i in 2:
		#var new_slot = card_slot.instantiate()
		#card_stack.add_child(new_slot)
		#var card_pos = test_deck.randOwnership(1,1)
		#update_card_slots_pos(new_slot,card_pos)
		#x_offset += x_step

func add_slot(nr_rep:int,target:int):
	match target :
		1:
			for i in nr_rep:
				var new_slot = card_slot.instantiate()
				card_stack.add_child(new_slot)
				var card_pos = test_deck.randOwnership(1,target)
				update_card_slots_pos(new_slot,card_pos)
				new_slot.position.x += x_offset
				x_offset += x_step
				hand_score += test_deck.deck[card_pos].value
		3:
			for i in nr_rep:
				var new_slot = card_slot.instantiate()
				dealer_stack.add_child(new_slot)
				var card_pos = test_deck.randOwnership(1,target)
				update_card_slots_pos(new_slot,card_pos)
				new_slot.position.x += xd_offset
				xd_offset += x_step
				dealer_score += test_deck.deck[card_pos].value
	test_deck.printCards(1)
	#var duplicated_node = player_card_slot.duplicate_slot()
	#duplicated_node.position.x = player_card_slot.position.x + 150

func update_card_slots_pos(slot:Slot,pos:int):
			slot.card = test_deck.deck[pos]
			slot.change_card()

#func update_card_slots(target:int,slot:Slot):
	#for i in range (0,test_deck.deck.size()):
		#if test_deck.deck[i].ownership == target and test_deck.deck[i].showed == false: 
			#test_deck.deck[i].showed = true
			#slot.card = test_deck.deck[i]
			#slot.change_card()
			#break

func hit():
	if hand_score < 21 :
		add_slot(1,1)
		player_score_display.text = str(hand_score)
		test_deck.printCards(1)

func _on_hit_pressed() -> void:
	hit()
	if hand_score > 21 :
		emit_signal("end_round")
		bust = true

func _on_dealer_turn() -> void:
	while dealer_score < 17 :
		await get_tree().create_timer(0.75).timeout
		add_slot(1,3)
	emit_signal("end_round")

func _on_stand_pressed() -> void:
	emit_signal("dealer_turn")

func _on_end_round() -> void:
	if bust == true :
		print("Lose :(")
	if dealer_score > 21 :
		print("Win!")
	elif 21 - dealer_score > 21 - hand_score :
		print("Win!")
	elif dealer_score == hand_score : 
		print("Draw :|")
	else : print("Lose :(")
