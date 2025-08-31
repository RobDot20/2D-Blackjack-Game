extends Node
#
##var deck : Cards = {"1":1D}
#@export var player_hand : Array[Cards]
#@export var dealer_hand : Array[Cards]
#@export var deck : Array[Cards]
#
##cate carti sunt puse in deck
#var card_in_deck = 0
#
#func _ready() -> void:
	##deck.shuffle()
	##vectori de frecventa pt fiecare suit
	#var h_suit : Array 
	#var c_suit : Array 
	#var d_suit : Array 
	#var s_suit : Array 
	#
	#h_suit.resize(14)
	#c_suit.resize(14)
	#d_suit.resize(14)
	#s_suit.resize(14)
	#
	#
	#while card_in_deck <= 51 :
		#var suit_num : int = randi_range(0,3)
		#var card_num : int = randi_range(1,13)
		#
		#print(suit_num)
		#print(card_num)
		#
		#
		#if suit_num == 0 and h_suit[card_num]!=0 :
			#var new_card := Cards.new()
			#new_card.suit = "h"
			#new_card.number = card_num
	#
		#elif suit_num == 1 and c_suit[card_num]!=0 :
			#var new_card := Cards.new()
			#new_card.suit = "c"
			#new_card.number = card_num
	#
		#elif suit_num == 2 and d_suit[card_num]!=0 :
			#var new_card := Cards.new()
			#new_card.suit = "d"
			#new_card.number = card_num
	#
		#elif suit_num == 3 and s_suit[card_num]!=0 :
			#var new_card := Cards.new()
			#new_card.suit = "s"
			#new_card.number = card_num
			#
		#card_in_deck +=1
#
#deck[card_in_deck] = Cards.new("s",card_num)
#
#func _process(_delta: float) -> void:
#
	#print(deck[1])
@export var test_deck := Deck.new(2, false)
@export var player_inventory := CardInventory.new(test_deck, 1)
@export var dealer_inventory := CardInventory.new(test_deck, 3)
func _on_button_button_down() -> void:
	if !test_deck : print("nope")
	#else : print("worked")
	# Mai jos se afla noua modalitate de a seta N carti din deck cu ownership 1 si simultan acele carti sa fie adaugate catre inventar, fara ca acesta sa necesite reconstruirea
	player_inventory.addCard(0)
	dealer_inventory.addCard(1)
	player_inventory.printInventory() # Afisare celor 3 carti adaugate in posesia player
	dealer_inventory.printInventory()
	#player_inventory.resetInventory() # Resetare inventar si al ownershipului cartilor respective
	# La addCard se introduce indexul cartii din deck, ceea ce poate fi dificil de calculat de noi, asa ca introducem functia getIndex(number, face) pentru a ne usura viata
	#player_inventory.addCard(test_deck.getIndex(2,3, 2))
	#player_inventory.printInventory()
	# Aici e un exemplu de a schimba valoarea cartii in altceva, se poate introduce si direct indexul, sau intre parantezele getIndex(player_inventory[0]) pentru a schimba prima carte a player-ului, etc
	var original_card : int = player_inventory.inventory[-1]
	var new_card : int = dealer_inventory.inventory[-1]
	player_inventory.changeCard(original_card, dealer_inventory.changeCard(new_card, original_card)) # In astfel, se pot schimba carti ale 2 inventare
	player_inventory.printInventory() # Afisare schimbari dupa changeCard
	dealer_inventory.printInventory()
