extends RayCast2D


func collision_point():
	return to_local(get_collision_point())
