extends Camera3D

var FocusedObject = null

func SetFocus(object):
	FocusedObject = object
	
func _process(delta):
	if FocusedObject:
		look_at(FocusedObject.global_position)
