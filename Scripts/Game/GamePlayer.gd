@tool

extends RigidBody3D

class_name Player

var CurrentTile : Tile
var CurrentTileVacancy : TileVacancy

signal MoveCompleted

@export var PlayerImage : Texture2D

var Offset = Vector3(0,  4, 0)
var VictoryPoints = 0
var Coins = 0

@export var bIsPlayer = true
@export var PlayerName = "PLAYER"

signal PlayerUpdate

signal PlayerActivated
signal PlayerDeactivated

func _enter_tree():
	name = "GAME_" + PlayerName

func Activate():
	PlayerActivated.emit()
	
func DeActivate():
	PlayerDeactivated.emit()
	
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
	PlayerUpdate.emit()
	
func GetVictoryPoints():
	return VictoryPoints

func GetCoins():
	return Coins
	
func GetName():
	return PlayerName
	
func ToString():
	return PlayerName + " VP: " + str(VictoryPoints)

func IsHuman():
	return bIsPlayer
