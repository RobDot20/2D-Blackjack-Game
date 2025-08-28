extends Node

enum State { front,distras, suparat,nervos, fericit }

var current_state: State = State.front
var state_time: float = 0.0

signal state_changed(new_state)

func _process(delta):
	state_time += delta

	match current_state:
		State.front:
			if state_time > 3.0:
				set_state(State.distras)

		State.distras:
			if state_time > 3.0:
				set_state(State.front)

func set_state(new_state: State):
	if new_state == current_state:
		return
	current_state = new_state
	state_time = 0.0
	emit_signal("state_changed", new_state)
