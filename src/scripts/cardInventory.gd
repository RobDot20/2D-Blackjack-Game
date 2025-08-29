extends Resource
class_name CardInventory

@export var inventory : Array[int]
@export var owner : int
@export var total_value : int = 0
@export var deck : Deck

func buildInventory():
	for i in range(0, deck.deck.size()):
		match deck.deck[i].ownership:
			owner:
				inventory.append(i)
			_:
				pass

func printInventory():
	print("Card Inventory of ", owner, " is:\n")
	for i in inventory:
		deck.printCard(i)

func calculateTotalValue():
	total_value = 0 # reset la valoare inainte de a o calcula
	for i in inventory:
		total_value += deck.deck[i].value
	calculateAceValue()
	
func calculateAceValue():
	for i in inventory:
		if deck.deck[i].number == 1 && total_value > 21:
			total_value -= 10

func _init(deck : Deck,owner : int):
	self.deck = deck
	self.owner = owner
	buildInventory()
	calculateTotalValue()
	

	
