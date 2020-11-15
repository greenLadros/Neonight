extends AudioStreamPlayer

func _ready():
	$Timer.start(228)

func _on_Timer_timeout():
	playing = true
	$Timer.start(228)
