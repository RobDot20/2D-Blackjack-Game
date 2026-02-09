extends Node2D
class_name Slot

@onready var sprite: Sprite2D = $Sprite2D

@export var card : PlayingCard

func change_card(new_card:PlayingCard):
	card = new_card #nu este necesar deocamdata, dar poate ajuta pe viitor si la debugging
	sprite.texture = new_card.texture

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#print("clicked!")
			Globals.slot_clicked.emit(self)

func getCardFromSlot() :
	return card
