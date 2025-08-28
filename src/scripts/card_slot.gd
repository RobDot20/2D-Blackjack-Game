extends Node2D
class_name Slot

@onready var card_frames: AnimatedSprite2D = $CardFrames

func duplicate_slot():
	var packed_scene = PackedScene.new()
	packed_scene.pack(self)
	var duplicated_node = packed_scene.instantiate()
	add_sibling(duplicated_node)
	return duplicated_node

func change_card(frame:int):
	print("function change card called")
	card_frames.frame = frame
