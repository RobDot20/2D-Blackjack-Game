extends Node
class_name CardInventory

@export var inventory : Array[int]
@export var card_owner : int
@export var total_value : int = 0
@export var deck : Deck # Deck nu va fi copiat, ci referenced

# note: daca se apeleaza randOwnership fara ca rezultatul aceluia sa fie trecut prin addInventory, intreg inventarul trebuie reconstruit
# De asemenea, buildInventory reconstruieste inventarul in ordinea deck-ului, NU in ordinea istoricului cartilor trase, asadar ar trebui folosit doar in caz de debugging
func buildInventory():
	inventory.clear() # Mai intai lucram cu un clean slate inainte de a il construi
	for i in range(0, deck.deck.size()):
		match deck.deck[i].ownership:
			card_owner:
				inventory.append(i)
			_:
				pass
	calculateTotalValue() # Consider ca inventarul este reconstruit odata ce toate variabilele, inclusiv Value, sunt actualizate

func resetInventory():
	inventory.clear()
	deck.resetOwnership(card_owner)
	total_value = 0

func printInventory():
	print("Card Inventory of ", card_owner, " is:\n")
	for i in inventory:
		deck.printCard(i)

# addInventory se apeleaza cu rabdOwnership(nr_carti, inventory.owner)
func addInventory(arr): # are opt si de array si de int in functie de ce primeste
	if arr is Array :
		inventory.append_array(arr)
	elif arr is int :
		inventory.append(arr)

# Adauga un N numar de carti random
func addRandom(n : int):
	inventory.append_array(deck.randOwnership(n, card_owner))

func addCard(card : int):
	inventory.append(card)
	deck.setOwnership(card, card_owner)
	
func removeCard(card : int):
	inventory.erase(card)
	deck.removeOwnership(card)

func changeCard(original : int, new : int): # Prin original si new ne referim la pozitiile cartilor in array-ul deck, pozitii ce pot fi obtinute prin comanda deck.getIndex
	var index : int = inventory.find(original)
	if index == -1:
		printerr("CARD NOT PART OF INVENTORY")
	else:
		deck.removeOwnership(original)
		inventory[index] = new
		deck.setOwnership(new, card_owner)

func calculateTotalValue():
	total_value = 0 # reset la valoare inainte de a o calcula
	for i in inventory:
		#print("INDEX IS ON: ",i)
		total_value += deck.deck[i].value
	calculateAceValue()
	return total_value

func calculateAceValue():
	for i in inventory:
		if deck.deck[i].number == 1 && total_value > 21:
			total_value -= 10
			
func getTotalValue():
	calculateTotalValue() # Astfel, pentru a da interface cu inventarul, nu trebuie sa specifici cand il recalculezi si cand nu. De asemena este sigur ca primesti cea mai actuala valoare.
	return total_value
	
func getInventory():
	return inventory
	
func getLastItem():
	var nr : int = 0
	for i in inventory:
		nr += 1
	return nr
	
func printTotalValue():
	print("The current total value of owner ", card_owner, " is: ", total_value)

func _init(param_deck : Deck, param_owner : int):
	deck = param_deck # Cum am mentionat la inceput, self.deck da point catre deck
	card_owner = param_owner # Includem si owner pentru a avea un inventar de structura comuna intre player, split si dealer
	#buildInventory() # depinzand de momentul in care se initializeaza inventarul, aceasta functie poate irosi putere computationala (daca nu exista inca carti cu ownership=owner)
