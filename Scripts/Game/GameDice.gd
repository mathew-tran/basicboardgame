extends RigidBody3D

# test

func _ready():
	ThrowDice()
	
func ThrowDice():
	apply_force(Vector3.UP * 500)
	apply_torque(Vector3(randf_range(0, 2 * PI), randf_range(0, 2 * PI), randf_range(0, 2 * PI)) * randf_range(10, 20)) 
	
func GetValue():
	var value = 1
	for child in $Casts.get_children():
		if child.is_colliding():
			return value
		value += 1

func _on_timer_timeout():
	print(GetValue())
