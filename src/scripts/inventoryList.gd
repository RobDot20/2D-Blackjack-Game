extends Resource

class_name InventoryList

@export var owner : Array[CardInventory]

func _init(param_deck : Deck) -> void:
	for i in range(1, 4):
		owner.append(CardInventory.new(param_deck, i))
