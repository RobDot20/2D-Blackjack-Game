extends Node


@onready var dealer: Node2D = $dealer

@onready var player_score_display: Label = $"Player UI/PlayerScore/PlayerScoreDisplay"
@onready var dealer_score_display: Label = $"Player UI/DealerScore/DealerScoreDisplay"
@onready var hit_button: TextureButton = $"Player UI/Buttons/Hit"
@onready var stand_button: TextureButton = $"Player UI/Buttons/Stand"
@onready var card_handler: Control = $CardHandler
@onready var player_hand: CardInv = $CardHandler/PlayerHand
@onready var dealer_hand: CardInv = $CardHandler/DealerHand

var card_pos_deck : int = 0

var player_score : int
var dealer_score : int
var bust : bool = false

@export var spell_1 : Spell
@export var spell_2 : Spell

signal dealer_turn
signal end_round

func add_card(target:String):
	card_handler.add_card(target)

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
	while dealer_score <= 16 :
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

func _on_spell_1_pressed() -> void:
	card_handler.use_spell(spell_1.spell_name)

func _on_spell_2_pressed() -> void:
	card_handler.use_spell(spell_2.spell_name)

func _on_exit_pressed() -> void:
	get_tree().quit()
