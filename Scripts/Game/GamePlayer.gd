extends RigidBody3D

class_name Player

var CurrentTile : Tile

func MoveToTargetTile(tile):
	global_position = tile.global_position
	CurrentTile = tile
	print(name + " moved to " + tile.name + " :"  + str(global_position))
