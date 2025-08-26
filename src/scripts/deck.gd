extends Resource
class_name Deck

@export var deck: Array[PlayingCard]

#static func generate_new_deck(add_joker : bool) :
	#var deck_of_cards := Deck.new()
	#
	#for i in PlayingCard.Suit.values():
		#match i:
			#PlayingCard.Suit.NULL:
				#pass
			#_:
				#for m in range(1,11):
					#var new_card := PlayingCard.new()
					#new_card.is_numbered_card = true
					#new_card.is_face_card = false
					#new_card.number = m
					#new_card.face = PlayingCard.Faces.NULL
					#new_card.suit = i
					#deck_of_cards.deck.append(new_card)
	#
				#for f in PlayingCard.Faces.values() :
					#print(f)
					#match f:
						#PlayingCard.Faces.NULL:
							#pass
						#PlayingCard.Faces.JOKER:
							#pass
						#_:
							#var new_card := PlayingCard.new()
							#new_card.is_numbered_card = false
							#new_card.is_face_card = true
							#new_card.face = f
							#new_card.suit = i
							#deck_of_cards.deck.append(new_card)
#
	#if add_joker == true:
		#for n in 2:
			#var new_card := PlayingCard.new()
			#new_card.is_numbered_card = false
			#new_card.is_face_card = true
			#new_card.face = PlayingCard.Faces.JOKER
			#deck_of_cards.deck.append(new_card)
			#print("joker function called")
	#return deck_of_cards

func _init(add_joker : bool) :
	
	for i in PlayingCard.Suit.values():
		match i:
			PlayingCard.Suit.NULL:
				pass
			_:
				for m in range(1,14):
					var new_card := PlayingCard.new()
					new_card.number = m
					if(m < 10):
						new_card.value = m
					else:
						new_card.value = 10
					new_card.suit = i
					new_card.ownership = 0 # by default cardul nu este detinut de nimeni
					deck.append(new_card)

	if add_joker == true:
		for n in 2:
			var new_card := PlayingCard.new()
			new_card.number = 14
			new_card.ownership = 0
			deck.append(new_card)
			print("joker function called")
