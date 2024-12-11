extends Tile

func Resolve(player: Player):
	player.AddCoin(1)
	await get_tree().create_timer(.2).timeout
	player.AddCoin(1)
	await get_tree().create_timer(.2).timeout
	player.AddCoin(1)
	await get_tree().create_timer(.2).timeout
	Resolved.emit()
