extends Node

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var test_deck := Deck.new(false)

func _on_button_button_down() -> void:
	if !test_deck : print("nope")
	else : print("worked")
	
	test_deck.randOwnership(2, 1)
	test_deck.printPlayerCards()
	show_cards()

func show_cards() :
	for i in range (0,test_deck.deck.size()) :
		print(test_deck.deck[i].number,PlayingCard.Suit.keys()[test_deck.deck[i].suit])
		if test_deck.deck[i].ownership == 1 :
			animated_sprite_2d.frame = i
