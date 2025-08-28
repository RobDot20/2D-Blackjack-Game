extends Resource
class_name PlayingCard
#ordinea la suit trb sa coincida cu ordinea pozelor din nodul game
enum Suit {
	NULL,
	CLUBS,
	HEARTS,
	DIAMONDS,
	SPADES
}
# Card variables
# @export var is_numbered_card: bool
# @export var is_face_card : bool
@export_range(1,15) var number : int
@export_range(1,12) var value : int
# Ownership reprezinta detinatorul cartii, unde 0 este masa, 1 este player principal, 2 este player split (optional), 
# 3 este dealer hand
@export_range(0,4) var ownership : int
#@export var face : Faces
@export var suit : Suit
