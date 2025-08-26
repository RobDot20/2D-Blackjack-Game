extends Resource
class_name PlayingCard

enum Faces {
	NULL,
	JACK,
	QUEEN,
	KING,
	JOKER
}

enum Suit {
	NULL,
	HEARTS,
	DIAMONDS,
	SPADES,
	CLUBS
}
#deck.shuffle!!!
@export var is_numbered_card: bool
@export var is_face_card : bool
@export_range(1,10) var number : int
@export var face : Faces
@export var suit : Suit
