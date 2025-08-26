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
@export var test_deck : Deck

#func _ready() -> void:
	#test_deck = generate_new_deck(false)
	#pass

func generate_new_deck(add_joker : bool) :
	var deck_of_cards := Deck.new()
	
	for i in PlayingCard.Suit.values():
		match i:
			PlayingCard.Suit.NULL:
				pass
			_:
				for m in range(1,11):
					var new_card := PlayingCard.new()
					new_card.is_numbered_card = true
					new_card.is_face_card = false
					new_card.number = m
					new_card.face = PlayingCard.Faces.NULL
					new_card.suit = i
					deck_of_cards.deck.append(new_card)
	
				for f in PlayingCard.Faces.values() :
					print(f)
					match f:
						PlayingCard.Faces.NULL:
							pass
						PlayingCard.Faces.JOKER:
							pass
						_:
							var new_card := PlayingCard.new()
							new_card.is_numbered_card = false
							new_card.is_face_card = true
							new_card.face = f
							new_card.suit = i
							deck_of_cards.deck.append(new_card)
	
	#if add_joker == true:
		#for n in 2:
			#var new_card := PlayingCard.new()
			#new_card.is_numbered_card = false
			#new_card.is_face_card = true
			#new_card.face = PlayingCard.Faces.JOKER
			#deck_of_cards.deck.append(new_card)
	print("function called")
	return deck_of_cards

func _on_button_button_down() -> void:
	test_deck = generate_new_deck(false)
	if !test_deck : print("nope")
	else : print("worked")
	print(test_deck)
