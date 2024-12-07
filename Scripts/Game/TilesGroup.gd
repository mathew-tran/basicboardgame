extends Node3D


func GetNextTile(tile):
	var tilePosition = get_children().find(tile)
	tilePosition += 1
	if get_child_count() <= tilePosition:
		tilePosition = 0
	return get_child(tilePosition)
