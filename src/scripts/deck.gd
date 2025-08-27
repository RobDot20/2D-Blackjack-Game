extends Resource
class_name Deck

@export var deck: Array[PlayingCard]

# Functie care initializeaza deck-ul de carti, se apeleaza cu Deck.new()
func _init(_add_joker : bool) :
	# Creeam cate un set de carti pentru fiecare culoare
	for i in PlayingCard.Suit.values():
		match i:
			# Nu creeam carduri cu Suit NULL
			PlayingCard.Suit.NULL:
				pass
			_:
				# m reprezinta fiecare carte de la as la k, unde 11 12 13 reprezinta J Q K
				for m in range(1,14):
					var new_card := PlayingCard.new()
					new_card.number = m
					if(m < 10): # In blackjack, fiecare carte cu numar mai mare de 10 are tot valoare 10, asa ca avem number si value separate
						new_card.value = m
					else:
						new_card.value = 10
					new_card.suit = i
					new_card.ownership = 0 # by default cardul nu este detinut de nimeni
					deck.append(new_card)
# Jokerii nu au culoar sau valoare deoarece ne gandim ce (si daca) rol vor avea
	#if add_joker == true:
		#for n in 2:
			#var new_card := PlayingCard.new()
			#new_card.number = 14
			#new_card.ownership = 0
			#deck.append(new_card)
			#print("joker function called")
			
# DE URMAT: FUNCTIE CARE IA 2 POZITII DE CARTI RANDOM DIN ARRAY SI LE DA OWNERSHIP = 1 SI DUPA LA FEL NUMAI CA OWNERSHIP = 3

func randOwnership(n : int, owner : int):
	var deck_size := deck.size()-1
	var pos := randi_range(0, deck_size)
	for i in n:
		# Cartea trebuie sa nu fie detinuta de nimeni ca sa poata primi ownership
		while(deck[pos].ownership != 0):
			pos = randi_range(0, deck_size)
		deck[pos].ownership = owner

func dealCards():
	randOwnership(2, 1)
	randOwnership(2, 3)

func resetOwnership():
	for i in range(0, deck.size()):
		match deck[i].ownership:
			0:
				pass
			_:
				deck[i].ownership = 0

func printCards(owner : int):
	match owner:
		0:
			print("Table cards:")
		1:
			print("Player Cards:")
		2:
			print("Player Split Cards:")
		3:
			print("Dealer Cards:")
	print("--------")
	for i in deck.size():
		if deck[i].ownership == owner:
			print("Card number: ", deck[i].number, "(value = ", deck[i].value,")\nDeck Suit: ", PlayingCard.Suit.keys()[deck[i].suit], "\n")	

# FUNCTIE CARE SA PARCURGA ARRAYUL SI SA DEA PRINT LA CARTILE CU OWNERSHIP = 1, OWNERSHIP = 2 (daca nu este null), OWNERSHIP = 3
# FUNCTIE CARE SA PARCURGA ARRAYUL, DACA DOUA CARTI CU OWNERSHIP = 1 AU ACCEASI VALUE, DA PROMPT LA OPTIUNEA SPLIT
# FUNCTIE CARE MODIFICA VALOAREA DE OWNERSHIP A CELEI DA DOUA CARTI A PLAYERULUI LA VALOAREA OWNERSHIP = 2
# ----
# dupa ce toate cerintele de mai sus au fost indeplinite, trecem la sistemul de hit (unde va trebui sa includem si split daca e cazul)
