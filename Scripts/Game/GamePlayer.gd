extends RigidBody3D

class_name Player

var CurrentTile : Tile
var CurrentTileVacancy : TileVacancy

signal MoveCompleted

var Offset = Vector3(0,  4, 0)
var VictoryPoints = 0

func Activate():
	pass
	
func MoveToTargetTile(tile : Tile):
	
	if is_instance_valid(CurrentTileVacancy):
		CurrentTileVacancy.SetUsed(false)
		
	
	var nextVacancy = tile.GetTileVacancy() as TileVacancy
	nextVacancy.SetUsed(true)
	CurrentTileVacancy = nextVacancy
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(self, "global_position", global_position + Offset, .03).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", nextVacancy.global_position + Offset, .2).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", nextVacancy.global_position, .04).set_trans(Tween.TRANS_QUAD)
	await tween.finished

	await get_tree().create_timer(.3).timeout

	linear_velocity = Vector3.ZERO
	rotation = Vector3.ZERO
	CurrentTile = tile

	MoveCompleted.emit()

func AddVictoryPoint(amount):
	VictoryPoints += amount
	print(name + "VP UPDATE (" + str(amount) + ")")
	print(ToString())
	
func GetVictoryPoints():
	return VictoryPoints

func ToString():
	return name + " VP: " + str(VictoryPoints)
