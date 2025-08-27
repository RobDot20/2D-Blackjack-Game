extends AnimatedSprite2D
var frames=["front","left","right"]
var index=0
func _ready():
	play(frames[index])

func _on_timer_timeout():
	index = (index + 1) % frames.size()
	play(frames[index])
@onready var timer: Timer = $Timer
func _process(delta: float) -> void:
	timer.wait_time=randi_range(3,5)
