extends KinematicBody2D

signal explosion
# global vars
onready var sprite = $Sprite
onready var player = get_tree().get_root().get_child(0).get_child(12)
func _ready():
	connect("explosion",player,"hurt",[1])
	
func explode():
	sprite.play('Explosion')
	$Timer.start(0.5)
	emit_signal("explosion")
	get_tree().get_root().get_child(0).get_child(11).playing = true


func _on_Area2D_body_entered(body):
	explode()


func _on_Timer_timeout():
	queue_free()
