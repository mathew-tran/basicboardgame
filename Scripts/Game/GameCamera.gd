extends Camera3D

var FocusedObject = null

var FollowSpeed = 10
var LastPosition = Vector3.ZERO
var Progress = 0
var StartPosition = Vector3.ZERO
func SetFocus(object, moveSpeed = 10):
	FocusedObject = object
	FollowSpeed = moveSpeed
	print("[Camera] " + object.name + " focused")
	
	
func _process(delta):
	if FocusedObject:
		if LastPosition.distance_to(FocusedObject.global_position) > 10:
			var newPosition = FocusedObject.global_position
			newPosition.y = LastPosition.y
			StartPosition = $TargetPosition.global_position
			LastPosition = newPosition
			Progress = 0

		else:
			if Progress < 1:
				Progress += delta * FollowSpeed
			if Progress >= 1:
				Progress = 1
				return
		$TargetPosition.global_position = lerp(StartPosition, LastPosition, Progress)
		
		look_at($TargetPosition.global_position)
