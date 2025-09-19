extends Node2D
class_name Slot
@onready var sprite: Sprite2D = $Sprite2D

@export var card : PlayingCard

func change_card(new_card:PlayingCard):
	card = new_card #nu este necesar deocamdata, dar poate ajuta pe viitor si la debugging
	sprite.texture = new_card.texture
