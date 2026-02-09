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
@export_range(1,15) var number : int
@export_range(1,12) var value : int
@export_range(0,4) var ownership : int
@export var suit : Suit
@export var texture : Texture2D

func getCardNumber():
	return number
