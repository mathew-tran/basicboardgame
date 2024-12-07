extends Node3D

func _ready():
	$AnimationPlayer.play("Twist")

func SetPosition(newPosition):
	global_position = newPosition
	global_position.y = 5
	print(global_position)
	visible = true
	
func Hide():
	visible = false
