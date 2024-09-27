extends Node2D


@onready var parent = get_parent()
@onready var laser = $Laser
@onready var line = $Line2D

var collision
var direction

var normal
var bounces = 0

var reflection
var bounce

func _physics_process(delta):
	laser.force_raycast_update()
	
	rotation = parent.get_local_mouse_position().angle()
	
	if !laser.is_colliding():
		_Delete_bounce()
	
	else:
		collision = laser.get_collision_point()
		
		if !laser.get_collider().is_in_group("Mirror"):
			
			# Reszta kodu
			
			_Delete_bounce()
			
		else:
			normal = laser.get_collider()._Hit()
			direction = collision - laser.global_position
			
			reflection =  direction.bounce(normal)
			
			if bounces < 1:
				_Bounce(collision, reflection)
			elif bounces == 1:
				_Bouncing(collision, reflection)
				



func _Bounce(collision, reflection):
	bounces += 1
	bounce = RayCast2D.new()
	parent.add_child(bounce)
	_Bouncing(collision, reflection)
	
func _Bouncing(collision, reflection):
	bounce.global_position = collision
	bounce.target_position = reflection

func _Delete_bounce():
	if is_instance_valid(bounce):
		bounce.queue_free()
		bounces = 0
