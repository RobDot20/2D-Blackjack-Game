extends Control

@onready var player_hand: CardInv = $PlayerHand
@onready var dealer_hand: CardInv = $DealerHand
@onready var clarvoyance_slot: CardInv = $ClarvoyanceSlot
@onready var swap_text: Label = $SwapText

@export var play_deck := Deck.new(2, false)

var card_pos_deck : int = 0

#if clarvoyance spell is active
var clar_active = false
#variables for swap function
var swap_active = false
var counter = 1
var slot1 : Slot
var slot2 : Slot
var temp : PlayingCard

signal value_changed

func _ready() -> void:
	Globals.slot_clicked.connect(_on_slot_clicked)

func add_card(target:String):
	if target == "player" :
		player_hand.add_card(play_deck.getCard(card_pos_deck),false)
	elif target == "dealer" :
		dealer_hand.add_card(play_deck.getCard(card_pos_deck),false)
	card_pos_deck += 1


func use_spell(spell:String,_target = 0):
	print("use spell called")
	match spell:
		"swap":
			if !swap_active :
				swap_active = true
				swap_text.visible = true
		"clarvoyance":
			if !clar_active  :
				seeNextCard()


func _on_slot_clicked(which_slot) :
	#print ("signal working. slot: " + str(which_slot.card))
	print("pressed card: " + str(which_slot.getCardFromSlot().getCardNumber()))
	if swap_active :
		swap(which_slot)


func seeNextCard():
	#var next = next_card()
	#print(next)
	clar_active = true
	clarvoyance_slot.add_card(play_deck.getCard(card_pos_deck),true)
	await get_tree().create_timer(2).timeout
	clarvoyance_slot.remove_card()
	clar_active = false

func swap(last_pressed_slot:Slot) :
	if counter == 1 :
		slot1 = last_pressed_slot
		temp = slot1.getCardFromSlot()
		counter += 1
	else:
		print("entered else")
		slot2 = last_pressed_slot
		slot1.change_card(slot2.getCardFromSlot())
		slot2.change_card(temp)
		slot1 = null
		slot2 = null
		temp = null
		counter = 1
		swap_text.visible = false
		emit_signal("value_changed")
		swap_active = false


func next_card():
	return(play_deck.getCard(card_pos_deck).number)
