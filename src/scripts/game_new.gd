extends Node


@onready var dealer: Node2D = $dealer

@onready var player_score_display: Label = $"Player UI/PlayerScore/PlayerScoreDisplay"
@onready var dealer_score_display: Label = $"Player UI/DealerScore/DealerScoreDisplay"
@onready var hit_button: TextureButton = $"Player UI/Buttons/Hit"
@onready var stand_button: TextureButton = $"Player UI/Buttons/Stand"
@onready var card_handler: Control = $CardHandler
@onready var player_hand: CardInv = $CardHandler/PlayerHand
@onready var dealer_hand: CardInv = $CardHandler/DealerHand

@onready var win_screen: CanvasLayer = $"End Screens/Win Screen"
@onready var lose_screen: CanvasLayer = $"End Screens/Lose Screen"

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

func _ready() -> void:
	for each in 4 :
		await get_tree().create_timer(0.75).timeout
		if each % 2 == 0:
			hit()
		else:
			add_card("dealer")
			update_score("dealer")


func update_score(_target):
	if _target == "player" :
		player_score = player_hand.calc_value()
		player_score_display.text = str(player_score)
		if player_score > 21 :
			bust = true
			emit_signal("end_round")
	elif _target == "dealer" :
		dealer_score = dealer_hand.calc_value()
		dealer_score_display.text = str(dealer_score)

func hit():
	if player_score < 21 :
		add_card("player")
		update_score("player")

func win():
	print("Win!")
	dealer.player_win()
	await get_tree().create_timer(3.5).timeout
	win_screen.visible = true
	win_screen.layer = 2

func lose():
	print("Lose :(")
	dealer.player_lose()
	await get_tree().create_timer(2).timeout
	lose_screen.visible = true
	lose_screen.layer = 2

func busted():
	print("Busted")
	#dealer.player_lose()
	await get_tree().create_timer(2).timeout
	lose_screen.visible = true
	lose_screen.layer = 2

func _on_hit_pressed() -> void:
	hit()

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
		lose()
	elif dealer_score > 21 :
		win()
	elif 21 - dealer_score > 21 - player_score :
		win()
	elif dealer_score == player_score : 
		print("Draw :|")
	else : 
		lose()

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_spell_1_pressed() -> void:
	card_handler.use_spell(spell_1.spell_name)

func _on_spell_2_pressed() -> void:
	card_handler.use_spell(spell_2.spell_name)

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_dealer_player_prins() -> void:
	busted()

func _on_card_handler_value_changed() -> void:
	update_score("player")
	update_score("dealer")
