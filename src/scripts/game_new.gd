extends Node

@onready var player_hand: CardInv = $PlayerHand
@onready var dealer_hand: CardInv = $DealerHand
@onready var dealer: Node2D = $dealer

@onready var player_score_display: Label = $"Player UI/PlayerScore/PlayerScoreDisplay"
@onready var dealer_score_display: Label = $"Player UI/DealerScore/DealerScoreDisplay"
@onready var hit_button: TextureButton = $"Player UI/Buttons/Hit"
@onready var stand_button: TextureButton = $"Player UI/Buttons/Stand"

var card_pos_deck : int = 0

var player_score : int
var dealer_score : int
var bust : bool = false

signal dealer_turn
signal end_round

@export var play_deck := Deck.new(2, false)

func add_card(target:String):
	#func for new cardinventory
	if target == "player" :
		player_hand.add_card(play_deck.getCard(card_pos_deck))
	elif target == "dealer" :
		dealer_hand.add_card(play_deck.getCard(card_pos_deck))
	card_pos_deck += 1

func update_score(target):
	if target == "player" :
		player_score = player_hand.calc_value()
		player_score_display.text = str(player_score)
	elif target == "dealer" :
		dealer_score = dealer_hand.calc_value()
		dealer_score_display.text = str(dealer_score)

func hit():
	if player_score < 21 :
		add_card("player")
		update_score("player")

func _on_hit_pressed() -> void:
	hit()
	if player_score > 21 :
		bust = true
		emit_signal("end_round")

func _on_stand_pressed() -> void:
	emit_signal("dealer_turn")

func _on_dealer_turn() -> void:
	hit_button.disabled = true
	stand_button.disabled = true
	while dealer_score < 17 :
		await get_tree().create_timer(0.75).timeout
		add_card("dealer")
		update_score("dealer")
	emit_signal("end_round")

func _on_end_round() -> void:
	if bust == true :
		print("Lose :(")
		dealer.player_lose()
	elif dealer_score > 21 :
		print("Win!")
		dealer.player_win()
	elif 21 - dealer_score > 21 - player_score :
		print("Win!")
		dealer.player_win()
	elif dealer_score == player_score : 
		print("Draw :|")
	else : 
		print("Lose :(")
		dealer.player_lose()

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
