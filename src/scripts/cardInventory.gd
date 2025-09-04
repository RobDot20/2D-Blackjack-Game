extends Resource
class_name CardInventory

@export var inventory : Array[int]
@export var owner : int
@export var total_value : int = 0
@export var deck : Deck # Deck nu va fi copiat, ci referenced

# note: daca se apeleaza randOwnership fara ca rezultatul aceluia sa fie trecut prin addInventory, intreg inventarul trebuie reconstruit
# De asemenea, buildInventory reconstruieste inventarul in ordinea deck-ului, NU in ordinea istoricului cartilor trase, asadar ar trebui folosit doar in caz de debugging
func buildInventory():
	inventory.clear() # Mai intai lucram cu un clean slate inainte de a il construi
	for i in range(0, deck.deck.size()):
		match deck.deck[i].ownership:
			owner:
				inventory.append(i)
			_:
				pass
	calculateTotalValue() # Consider ca inventarul este reconstruit odata ce toate variabilele, inclusiv Value, sunt actualizate

func resetInventory():
	inventory.clear()
	deck.resetOwnership(owner)
	total_value = 0

func printInventory():
	print("Card Inventory of ", owner, " is:\n")
	for i in inventory:
		deck.printCard(i)

# addInventory se apeleaza cu randOwnership(nr_carti, inventory.owner)
func addInventory(arr : Array): # Array deoarece randOwnership returneaza un array cu indexurile noi
	inventory.append_array(arr)

# Adauga un N numar de carti random
func addRandom(n : int):
	inventory.append_array(deck.randOwnership(n, owner))

func addCard(card : int):
	inventory.append(card)
	deck.setOwnership(card, owner)
	
func removeCard(card : int):
	inventory.erase(card)
	deck.removeOwnership(card)

# Change card nu verifica daca cartea cu care o schimba face parte din inventarul altcuiva pentru flexibilitate, verificarea ownershipului noii carti trebuie facuta de catre functia care apeleaza changeCard dinainte
func changeCard(original : int, new : int): # Prin original si new ne referim la pozitiile cartilor in array-ul deck, pozitii ce pot fi obtinute prin comanda deck.getIndex
	var index : int = inventory.find(original)
	if index == -1:
		printerr("CARD NOT PART OF INVENTORY")
	else:
		var tmp : int = deck.deck[new].ownership
		inventory[index] = new
		if deck.deck[new].ownership == 0:
			deck.removeOwnership(original)
			inventory[index] = new
			deck.setOwnership(new, owner)
		else: if deck.deck[original].ownership == owner: # Daca ownership-ul nu a fost deja schimbat de catre un apel changeCard de la celalalt inventar
			deck.setOwnership(new, owner)
			deck.setOwnership(original, tmp) # Seteaza ownershipul cartii originale = fostul ownership al noii carti
			return original # se returneaza indexul cartii originale pentru ca apoi sa se adauge cartea originala catre celalalt inventar, daca este cazul

func calculateTotalValue():
	total_value = 0 # reset la valoare inainte de a o calcula
	var ace_count : int = 0
	for i in inventory:
		total_value += deck.deck[i].value
		if deck.deck[i].number == 1:
			ace_count += 1
	calculateAceValue(ace_count)
	
func calculateAceValue(aces):
	for i in aces:
		if total_value > 21:
			total_value -= 10
		else:
			break
			
func getTotalValue():
	calculateTotalValue() # Astfel, pentru a da interface cu inventarul, nu trebuie sa specifici cand il recalculezi si cand nu. De asemena este sigur ca primesti cea mai actuala valoare.
	return total_value
	
func getInventory():
	return inventory
	
func printTotalValue():
	print("The current total value of owner ", owner, " is: ", total_value)

func _init(param_deck : Deck, param_owner : int):
	deck = param_deck # Cum am mentionat la inceput, self.deck da point catre deck
	owner = param_owner # Includem si owner pentru a avea un inventar de structura comuna intre player, split si dealer
	#buildInventory() # depinzand de momentul in care se initializeaza inventarul, aceasta functie poate irosi putere computationala (daca nu exista inca carti cu ownership=owner)
