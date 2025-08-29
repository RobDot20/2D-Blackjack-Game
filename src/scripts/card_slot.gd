extends Node2D
class_name Slot

@onready var card_frames: AnimatedSprite2D = $CardFrames
@export var card : PlayingCard

#func duplicate_slot():
	#var packed_scene = PackedScene.new()
	#packed_scene.pack(self)
	#var duplicated_node = packed_scene.instantiate()
	#add_sibling(duplicated_node)
	#return duplicated_node

func change_card():
	#print("change_card called")
	match card.suit :
		PlayingCard.Suit.CLUBS :
			card_frames.frame = card.number
		PlayingCard.Suit.HEARTS :
			card_frames.frame = card.number + 13
		PlayingCard.Suit.DIAMONDS :
			card_frames.frame = card.number + 2 * 13
		PlayingCard.Suit.SPADES :
			card_frames.frame = card.number + 3 * 13
