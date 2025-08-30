extends Resource
class_name Deck

@export var deck: Array[PlayingCard]
@export var sets : int = 1
# Functie care initializeaza deck-ul de carti, se apeleaza cu Deck.new()
func _init(param_sets, add_joker : bool) :
	sets = param_sets
	for each in sets:
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
						if(m == 1):
							new_card.value = 11 # Dam la as valoarea 11 by default, iar apoi in functia addSlot (functie in care aparent calculam si valoarea totala a ownerului) scadem 10 daca valoarea totala este >21 (adica potential bust salvat de catre as)
						else: if(m < 10): # In blackjack, fiecare carte cu numar mai mare de 10 are tot valoare 10, asa ca avem number si value separate
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

func getIndex(card_number : int, card_face : int, card_set : int):
	# adica daca se afla in parametri
	if not (card_number < 1 and card_number > 13 and card_face < 1 and card_face > 4 and card_set <= sets):
		# In loc de a parcurge intreg array-ul si a verifica daca number dau match, am folosit o formula pentru a afla index-ul instant, deoarece stim cate carti se afla intro culoare, si cate culori sunt
		return 13*card_face - (13-card_number) - 1 + (card_set-1)*52
	else:
		printerr("card_number trebuie sa fie intre 1 si 13 (As-K) si card_face intre 1 si 4")
		return null

func randOwnership(n : int, owner : int):
	var deck_size := deck.size()-1
	var pos := randi_range(0, deck_size)
	var index_log : Array
	for i in n:
		# Cartea trebuie sa nu fie detinuta de nimeni ca sa poata primi ownership
		while(deck[pos].ownership != 0):
			pos = randi_range(0, deck_size)
		deck[pos].ownership = owner
		index_log.append(pos)
	if n == 1:
		return pos
	return index_log

func setOwnership(index : int, owner : int):
	deck[index].ownership = owner

func removeOwnership(index : int):
	deck[index].ownership = 0

# La reset ownership, daca param_owner este 0, se reseteaza intreg ownership-ul, altfel, doar al ownerului specificat
func resetOwnership(_param_owner : int): # este _param_owner deoarece nu il folosim in functie si astfel godot nu mai da un warning legat de asta
		match _param_owner:
			0:
				for i in range(0, deck.size()):
						match deck[i].ownership:
							0:
								pass # Trecem peste 0 pentru a nu ii reda aceeasi valoare degeaba
							_: # Intreg deck-ul primeste ownership 0
								deck[i].ownership = 0
			_: # Un owner specificat
				for i in range(0, deck.size()):
					match deck[i].ownership:
						_param_owner:
							deck[i].ownership = 0

func printCard(i):
	print("Card number: ", deck[i].number, "(value = ", deck[i].value,")\nDeck Suit: ", PlayingCard.Suit.keys()[deck[i].suit], "\n","Card ownership: ",deck[i].ownership,"\n")

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
			printCard(i)
			#print("Card number: ", deck[i].number, "(value = ", deck[i].value,")\nDeck Suit: ", PlayingCard.Suit.keys()[deck[i].suit], "\n","Card ownership: ",deck[i].ownership,"\n")

# FUNCTIE CARE SA PARCURGA ARRAYUL SI SA DEA PRINT LA CARTILE CU OWNERSHIP = 1, OWNERSHIP = 2 (daca nu este null), OWNERSHIP = 3
# FUNCTIE CARE SA PARCURGA ARRAYUL, DACA DOUA CARTI CU OWNERSHIP = 1 AU ACCEASI VALUE, DA PROMPT LA OPTIUNEA SPLIT
# FUNCTIE CARE MODIFICA VALOAREA DE OWNERSHIP A CELEI DA DOUA CARTI A PLAYERULUI LA VALOAREA OWNERSHIP = 2
# ----
# dupa ce toate cerintele de mai sus au fost indeplinite, trecem la sistemul de hit (unde va trebui sa includem si split daca e cazul)
