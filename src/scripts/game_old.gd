extends Node

@onready var card_slot = preload("res://src/scenes/card_slot.tscn")
@onready var card_stack: Node2D = $CardStack
@onready var dealer_stack: Node2D = $DealerStack
@onready var player_score_display: Label = $PlayerScore/PlayerScoreDisplay
@onready var dealer_score_display: Label = $DealerScore/DealerScoreDisplay
@onready var dealer: Node2D = $dealer
@onready var stand_button: TextureButton = $Buttons/Stand

@onready var player_hand: CardInv = $PlayerHand
@onready var dealer_hand: CardInv = $DealerHand
var card_pos_deck : int = 0

@export var test_deck := Deck.new(2, false)
@export var player_inventory := CardInventory.new(test_deck, 1)

var node_array : Array[Slot]
var nodes_added_p : int
var nodes_added : Array[int]  #unde punem ca argument de owner e nodul

signal dealer_turn
signal end_round

var x_offset = 0.0
var xd_offset = 0.0
var x_step = 150

var hand_score := 0
var dealer_score := 0
var bust := false

func _ready() -> void:
	nodes_added.resize(10)
	nodes_added.fill(0)
	add_slot(2,1)
	add_slot(2,3)
	player_score_display.text = str(hand_score)
	dealer_score_display.text = str(dealer_score)

func add_slot(nr_rep:int,target:int):
	match target :
		1:
			for i in nr_rep:
				var new_slot = card_slot.instantiate()
				card_stack.add_child(new_slot)
				nodes_added[1] += 1
				nodes_added_p += 1
				var card_pos = test_deck.randOwnership(1,target)
				player_inventory.addInventory(card_pos)
				update_card_slots_pos(new_slot,card_pos)
				new_slot.position.x += x_offset
				x_offset += x_step
				hand_score = player_inventory.calculateTotalValue()
				node_array.append(new_slot)
				#if(test_deck.deck[card_pos].number == 1 && hand_score+test_deck.deck[card_pos].value > 21):
					#hand_score += test_deck.deck[card_pos].value - 10
				#else:
					#hand_score += test_deck.deck[card_pos].value
		3:
			for i in nr_rep:
				var new_slot = card_slot.instantiate()
				dealer_stack.add_child(new_slot)
				var card_pos = test_deck.randOwnership(1,target)
				update_card_slots_pos(new_slot,card_pos)
				new_slot.position.x += xd_offset
				xd_offset += x_step
				dealer_score += test_deck.deck[card_pos].value
	#test_deck.printCards(1)

func add_card(target:String):
	#func for new cardinventory
	if target == "player" :
		player_hand.add_card(test_deck.getCard(card_pos_deck))
	elif target == "dealer" :
		dealer_hand.add_card(test_deck.getCard(card_pos_deck))
	card_pos_deck += 1

func update_card_slots_pos(slot:Slot,pos:int):
			slot.card = test_deck.deck[pos]
			#slot.change_card()

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
		add_card("player")
		player_score_display.text = str(hand_score)
		#test_deck.printCards(1)

func _on_hit_pressed() -> void:
	hit()
	if hand_score > 21 :
		bust = true
		emit_signal("end_round")

func _on_dealer_turn() -> void:
	while dealer_score < 17 :
		await get_tree().create_timer(0.75).timeout
		add_slot(1,3)
		dealer_score_display.text = str(dealer_score)
	emit_signal("end_round")

func _on_stand_pressed() -> void:
	emit_signal("dealer_turn")
	stand_button.disabled = true

func swap_spell():
	player_inventory.changeCard(player_inventory.getLastItem(),test_deck.randOwnership(1,1))
	player_inventory.printInventory()
	update_card_slots_pos(node_array[nodes_added_p-1],player_inventory.getLastItem())#poate fi creata o functie in inventar sa dea ultima val adaugata sau alta var 
	hand_score = player_inventory.calculateTotalValue()
	player_score_display.text = str(hand_score)
	player_inventory.printTotalValue()
	test_deck.printCards(1)

func _on_end_round() -> void:
	if bust == true :
		print("Lose :(")
		dealer.player_lose()
	elif dealer_score > 21 :
		print("Win!")
		dealer.player_win()
	elif 21 - dealer_score > 21 - hand_score :
		print("Win!")
		dealer.player_win()
	elif dealer_score == hand_score : 
		print("Draw :|")
	else : 
		print("Lose :(")
		dealer.player_lose()

func _on_button_button_down() -> void:
	if !test_deck : print("nope")
	pass
	#else : print("worked")
	 #Mai jos se afla noua modalitate de a seta N carti din deck cu ownership 1 si simultan acele carti sa fie adaugate catre inventar, fara ca acesta sa necesite reconstruirea
	#player_inventory.addRandom(3)
	#player_inventory.printInventory() # Afisare celor 3 carti adaugate in posesia player
	#player_inventory.resetInventory() # Resetare inventar si al ownershipului cartilor respective
	## La addCard se introduce indexul cartii din deck, ceea ce poate fi dificil de calculat de noi, asa ca introducem functia getIndex(number, face) pentru a ne usura viata
	#player_inventory.addCard(test_deck.getIndex(2,3, 2))
	#player_inventory.printInventory()
	## Aici e un exemplu de a schimba valoarea cartii in altceva, se poate introduce si direct indexul, sau intre parantezele getIndex(player_inventory[0]) pentru a schimba prima carte a player-ului, etc
	#player_inventory.changeCard(test_deck.getIndex(2, 3, 2), test_deck.getIndex(1,1, 2))
	#player_inventory.printInventory() # Afisare schimbari dupa changeCard
