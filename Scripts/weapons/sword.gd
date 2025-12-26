extends Area2D

func attack():
	var targets = self.get_overlapping_areas()
	if !targets.is_empty():
		for target in targets:
			if target.get_parent().is_in_group("Enemy"):
				target.get_parent().damaged(get_parent().get_parent().weapon_damage + GM.player_stats["damage"])
