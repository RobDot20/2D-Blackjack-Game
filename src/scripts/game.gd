extends Node

@onready var player: Node = $Player
@onready var player_card_slot: Slot = $CardSlot
@onready var player_card_slot_2: Slot = $CardSlot2

@export var test_deck := Deck.new(false)

var nr_slots_player = 2
#vector de frecventa ce tine minte daca cartea a fost afisata
var carti_afisate : Array[int]

func _ready() -> void:
	carti_afisate.resize(52)
	carti_afisate.fill(0)
	

func _on_button_button_down() -> void:
	if !test_deck : print("nope")
	#else : print("worked")
	test_deck.randOwnership(2,1)
	test_deck.randOwnership(2,3)
	test_deck.printCards(1)
	test_deck.printCards(3)
	#show_cards()
	#test_deck.resetOwnership()

#func show_cards() :
	#for i in range (1,test_deck.deck.size()) :
		##print(test_deck.deck[i].number,PlayingCard.Suit.keys()[test_deck.deck[i].suit])
		#if test_deck.deck[i].ownership == 1 :
			#base_card_sprite.frame = i + 1
			#print("frame shown ",i + 1)

func add_slot():
	var duplicated_node = player_card_slot.duplicate_slot()
	duplicated_node.position.x = player_card_slot.position.x + 150

func update_card_slots(target:int,slot:Slot):
	for i in range (1,test_deck.deck.size()):
		print(test_deck.deck[i].ownership)
		if test_deck.deck[i].ownership == target : #and carti_afisate[i+1] == 0 :
			slot.change_card(i+1)
			carti_afisate[i+1] += 1

func _on_play_pressed() -> void:
	update_card_slots(1,player_card_slot)
	update_card_slots(1,player_card_slot_2)
