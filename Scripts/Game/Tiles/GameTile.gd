extends Node3D

class_name Tile

var Vacancies = []

signal Resolved

func _ready():

	for child in $Positions.get_children():
		Vacancies.append(child)
		
func Resolve(player: Player):
	await get_tree().create_timer(.1).timeout
	Resolved.emit()

func GetTileVacancy():
	if $Positions.get_child(0).IsUsed() == false:
		return $Positions.get_child(0)
	for child in Vacancies:
		if child.IsUsed() == false:
			return child
