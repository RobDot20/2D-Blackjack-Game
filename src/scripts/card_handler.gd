extends Control

@onready var player_hand: CardInv = $PlayerHand
@onready var dealer_hand: CardInv = $DealerHand

@export var play_deck := Deck.new(2, false)

var card_pos_deck : int = 0

func add_card(target:String):
	if target == "player" :
		player_hand.add_card(play_deck.getCard(card_pos_deck))
	elif target == "dealer" :
		dealer_hand.add_card(play_deck.getCard(card_pos_deck))
	card_pos_deck += 1

func use_spell(spell:String,_target):
	print("use spell called")
	match spell:
		"swap":
			pass
		"clarvoyance":
			var next = next_card()
			print(next)

func next_card():
	return(play_deck.getCard(card_pos_deck).number)
