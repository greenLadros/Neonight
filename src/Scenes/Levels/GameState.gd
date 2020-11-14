extends CanvasLayer

#global vars

#ready
func _ready():
	
	var GUINode = get_tree().get_root().get_node("NeonField/GameState")
	GUINode.connect("hurt",self,"updateHealth")

func updateHealth(currentHP):
	$Count.text = str(currentHP)
