extends Node3D

class_name TileVacancy

var bIsUsed = false

func _ready():
	visible = false

func SetUsed(bUsed):
	bIsUsed = bUsed

func IsUsed():
	return bIsUsed	
	
