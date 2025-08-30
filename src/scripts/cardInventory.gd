extends Resource
class_name CardInventory

@export var inventory : Array[int]
@export var owner : int
@export var total_value : int = 0
@export var deck : Deck # Deck nu va fi copiat, ci referenced

# note: daca se apeleaza randOwnership fara ca rezultatul aceluia sa fie trecut prin addInventory, intreg inventarul trebuie reconstruit
func buildInventory():
	resetInventory() # Mai intai lucram cu un clean slate inainte de a il construi
	for i in range(0, deck.deck.size()):
		match deck.deck[i].ownership:
			owner:
				inventory.append(i)
			_:
				pass

func resetInventory():
	inventory.clear()
	total_value = 0

func printInventory():
	print("Card Inventory of ", owner, " is:\n")
	for i in inventory:
		deck.printCard(i)

# addInventory se apeleaza cu rabdOwnership(nr_carti, inventory.owner)
func addInventory(arr): # are opt si de array si de int in functie de ce primeste
	if arr is Array :
		inventory.append_array(arr)
	elif arr is int :
		inventory.append(arr)

func calculateTotalValue():
	total_value = 0 # reset la valoare inainte de a o calcula
	for i in inventory:
		print("INDEX IS ON: ",i)
		total_value += deck.deck[i].value
	calculateAceValue()
	return total_value

func calculateAceValue():
	for i in inventory:
		if deck.deck[i].number == 1 && total_value > 21:
			total_value -= 10
			
func getTotalValue():
	return total_value
	
func getInventory():
	return inventory
	
func getLastItem():
	var nr : int = 0
	for i in inventory:
		nr += 1
	return nr
	
func printTotalValue():
	print("The current total value of owner ", owner, " is: ", total_value)

func _init(deck : Deck,owner : int):
	self.deck = deck # Cum am mentionat la inceput, self.deck da point catre deck
	self.owner = owner # Includem si owner pentru a avea un inventar de structura comuna intre player, split si dealer
	buildInventory() # depinzand de momentul in care se initializeaza inventarul, aceasta functie poate irosi putere computationala (daca nu exista inca carti cu ownership=owner)
	

	
