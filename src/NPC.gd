extends KinematicBody2D


# global vars
onready var sprite = $Sprite
onready var player = get_tree().get_root().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):        #should be players position
	if position.distance_to(Vector2(0,0)) < 100:
		shoot(player)

func shoot(target):
	pass

func explode():
	sprite.play('Explosion')
	queue_free()
