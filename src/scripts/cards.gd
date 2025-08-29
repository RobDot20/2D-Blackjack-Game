extends Resource
class_name PlayingCard

enum Suit {
	NULL,
	HEARTS,
	DIAMONDS,
	SPADES,
	CLUBS
}
# Card variables
@export_range(1,15) var number : int
@export_range(1,12) var value : int
# Ownership reprezinta detinatorul cartii, unde 0 este masa, 1 este player principal, 2 este player split (optional), 3 este dealer hand
@export_range(0,4) var ownership : int
@export var suit : Suit
