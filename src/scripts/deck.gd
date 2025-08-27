extends Resource
class_name Deck

@export var deck: Array[PlayingCard]

# Functie care initializeaza deck-ul de carti, se apeleaza cu Deck.new()
func _init(add_joker : bool) :
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
	if add_joker == true:
		for n in 2:
			var new_card := PlayingCard.new()
			new_card.number = 14
			new_card.ownership = 0
			deck.append(new_card)
			print("joker function called")
			
# DE URMAT: FUNCTIE CARE IA 2 POZITII DE CARTI RANDOM DIN ARRAY SI LE DA OWNERSHIP = 1 SI DUPA LA FEL NUMAI CA OWNERSHIP = 3

func randOwnership(n : int, owner : int):
	for i in n:
		deck[randi_range(1,deck.size())].ownership = owner

#func resetOwnership():
	#for i in range(1, deck.size()):

func printPlayerCards():
	for i in range(1, deck.size()):
		if deck[i].ownership == 1:
			print("Card value: ", deck[i].value," Deck Suit: ", PlayingCard.Suit.keys()[deck[i].suit])

# FUNCTIE CARE SA PARCURGA ARRAYUL SI SA DEA PRINT LA CARTILE CU OWNERSHIP = 1, OWNERSHIP = 2 (daca nu este null), OWNERSHIP = 3
# FUNCTIE CARE SA PARCURGA ARRAYUL, DACA DOUA CARTI CU OWNERSHIP = 1 AU ACCEASI VALUE, DA PROMPT LA OPTIUNEA SPLIT
# FUNCTIE CARE MODIFICA VALOAREA DE OWNERSHIP A CELEI DA DOUA CARTI A PLAYERULUI LA VALOAREA OWNERSHIP = 2
# ----
# dupa ce toate cerintele de mai sus au fost indeplinite, trecem la sistemul de hit (unde va trebui sa includem si split daca e cazul)
