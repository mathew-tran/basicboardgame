extends Node3D

class_name Tile

var Vacancies = []

func _ready():

	for child in $Positions.get_children():
		Vacancies.append(child)
		
func Resolve():
	pass

func GetTileVacancy():
	if $Positions.get_child(0).IsUsed() == false:
		return $Positions.get_child(0)
	Vacancies.shuffle()
	for child in Vacancies:
		if child.IsUsed() == false:
			return child
