extends RayCast2D

var casting = false
var bounces = 1
var mouse_position

func _ready():
	set_physics_process(false)
	$Line2D.points[0] = Vector2(0,0)
	$Line2D.width = 0


func _unhandled_input(event):
	if Input.is_action_pressed("LMB"):
		_set_casting(true)
		$FIRE.emitting = true
		_appear()
	else:
		_set_casting(false)
		$FIRE.emitting = false
		_disappear()
		

func _physics_process(delta):
	mouse_position = get_local_mouse_position().normalized().angle()
	self.rotation = mouse_position
	print(mouse_position)
	var cast_to := target_position 
		
	if is_colliding():
		if get_collider().is_in_group("Mirror"): 
			cast_to = to_local(get_collision_point())
			$Line2D.points[1] = cast_to
			#$Line2D.add_point(cast_to, bounces)
		else:
			cast_to = to_local(get_collision_point())
			$Line2D.points[1] = cast_to


func _set_casting(value):
	casting = value
	set_physics_process(value)


func _appear():
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 2, 0.1)
	
	
func _disappear():
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 0, 0.1)
