extends AnimatedSprite2D
var directions=["front,left,right"]
var index=0
func _ready():
	play(directions[index])

func _on_timer_timeout():
	index = (index + 1) % directions.size()
	play(directions[index])
