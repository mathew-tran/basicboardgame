extends RigidBody3D

var LastValue = -1

signal Resolved(amount)

func _ready():
	$Timer.stop()
	rotation = Vector3(randf_range(0, 2 * PI), randf_range(0, 2 * PI), randf_range(0, 2 * PI))
		
func ThrowDice():
	freeze = true
	$Timer.stop()
	rotation = Vector3(randf_range(0, 2 * PI), randf_range(0, 2 * PI), randf_range(0, 2 * PI))
	linear_velocity = Vector3.ZERO
	freeze = false
	apply_force(Vector3.UP * 500 * randf_range(1, 2.5))
	apply_torque(Vector3(randf_range(0, 2 * PI), randf_range(0, 2 * PI), randf_range(0, 2 * PI)) * randf_range(30, 80)) 
	LastValue = -1
	$Timer.start()
	
func GetValue():
	var value = 1
	for child in $Casts.get_children():
		if child.is_colliding():
			return value
		value += 1
	return -1

func _on_timer_timeout():
	if linear_velocity.length() <= 1:
		if LastValue != GetValue():
			LastValue = GetValue()			
			print("[GAME] Dice rolled: " + str(LastValue))
			Resolved.emit(LastValue)
