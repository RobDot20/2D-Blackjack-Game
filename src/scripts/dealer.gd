extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine = $Statemachine

signal player_prins

func _ready():
	state_machine.state_changed.connect(_on_state_changed)
	_on_state_changed(state_machine.current_state)
func _on_state_changed(new_state):
	match new_state:
		state_machine.State.front:
			sprite.play("front")
		state_machine.State.distras:
			sprite.play("distras")
		state_machine.State.suparat:
			sprite.play("castiga jucatorul")
		state_machine.State.nervos:
			sprite.play("te prinde")
		state_machine.State.fericit:
			sprite.play("pierde jucatorul")

func player_win():
	state_machine.set_state(state_machine.State.suparat)
func player_lose():
	state_machine.set_state(state_machine.State.fericit)
	
func player_draw():
	state_machine.set_state(state_machine.State.nervos)

func _on_spell_2_pressed():
	if state_machine.current_state==state_machine.State.front:
		state_machine.set_state(state_machine.State.nervos)
		emit_signal("player_prins")

func _on_spell_1_pressed():
	if state_machine.current_state==state_machine.State.front:
		state_machine.set_state(state_machine.State.nervos)
		emit_signal("player_prins")
