extends CanvasLayer

#global vars

#ready
func _ready():
	pass

func updateHealth(currentHP):
	$Count.text = str(currentHP)
