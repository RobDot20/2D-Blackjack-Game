extends Label

func update_money(_delta: float) -> void:
	text = char(Globals.player_money)
