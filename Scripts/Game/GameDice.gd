extends RigidBody3D

var LastValue = -1

signal Resolved(amount)
signal MovedToPosition

func _ready():
	$Timer.stop()
	rotation = Vector3(randf_range(0, 2 * PI), randf_range(0, 2 * PI), randf_range(0, 2 * PI))
		
func ThrowDice():
	freeze = true
	$Timer.stop()
	linear_velocity = Vector3.ZERO
	freeze = false
	apply_force(Vector3.UP * 500 * randf_range(2, 3))
	apply_torque(Vector3(randf_range(0, 2 * PI), randf_range(0, 2 * PI), randf_range(0, 2 * PI)) * randf_range(30, 80)) 
	LastValue = -1
	$Timer.start()
	
func MoveToPosition(newPosition):
	freeze = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", newPosition, .1).set_trans(Tween.TRANS_CUBIC)
	await tween.finished

	
	MovedToPosition.emit()
	freeze = false
	
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
			
			$Timer.stop()
			await get_tree().create_timer(.5).timeout
			Resolved.emit(LastValue)
