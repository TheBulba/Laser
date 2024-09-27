extends Node2D

func _Hit():
	
	var normal = to_local($CollisionShape2D/RayCast2D.get_collision_point()).normalized()

	#print(normal)
	
	return normal

