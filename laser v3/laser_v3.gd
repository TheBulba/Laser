extends Node2D


@onready var parent = get_parent()
@onready var laser = $Laser
@onready var line = $Line2D
@onready var bounce = $Laser/Bounce

var cast_to
var cast_to_bounce
var hits
var previous_collider


func _physics_process(delta):
	laser.enabled = true
	laser.force_raycast_update()
	
	rotation = parent.get_local_mouse_position().angle()
	
	if !Input.is_action_pressed("LMB"):
		line.clear_points()
		line.add_point(Vector2.ZERO, 0) 
		
	else:
		
		if !laser.is_colliding():
			fail_safe(laser.target_position)
		else:
			hits = 1
			
			cast_to = laser.collision_point()
			# Bouncing
			if laser.get_collider().is_in_group("Mirror"):  
				previous_collider = laser.get_collider()
				fail_safe(laser.collision_point())
				bounces(cast_to)
			else:
				laser.enabled = false
				fail_safe(laser.collision_point())
	

func bounces(cast_to):
	laser.enabled = false
	bounce.enabled = true
	bounce.position = cast_to
	#bounce.target_position = laser.target_position * -1
	bounce.rotation_degrees = -rotation_degrees * 2
	
	if bounce.is_colliding():
		hits += 1
		collision(bounce)
	else:
		pass
		
		
func collision(bounce):
	cast_to_bounce = bounce.collision_point()
	
	# Bouncing
	if bounce.get_collider() != previous_collider:
		if bounce.get_collider().is_in_group("Mirror"):  
			print(bounce.get_collider())
			bounces(cast_to_bounce)
		else:
			bounce.enabled = false
			bounce_fail_safe(bounce.collision_point())
			print (bounce.collision_point())
		
		
func fail_safe(target):
	if line.get_point_count() < 2:
			line.add_point(target, 1)
	else: 
		line.points[1] = target

func bounce_fail_safe(target):
	if line.get_point_count() < hits + 1:
		line.add_point(target, 1)
	else: 
		line.points[hits] = target
