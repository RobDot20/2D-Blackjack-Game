extends Node

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var test_deck := Deck.new(false)

func _on_button_button_down() -> void:
	if !test_deck : print("nope")
	else : print("worked")
	
	test_deck.randOwnership(2, 1)
	test_deck.printPlayerCards()

func show_cards() :
	pass
