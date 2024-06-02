extends RayCast2D

var casting = false

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2(0,0)
	$Line2D.width = 0

#func _unhandled_input(event):
	#if Input.is_action_just_pressed("LMB"):
		#_set_casting(true)
	#else:
		#_set_casting(false)

func _physics_process(delta):
	var cast_to := target_position 
		
	if is_colliding():
		cast_to = to_local(get_collision_point())
		
	$Line2D.points[1] = cast_to


func _set_casting(value):
	casting = value
	set_physics_process(value)


func _on_button_button_down():
	_set_casting(true)
	$FIRE.emitting = true
	_appear()

func _on_button_button_up():
	_set_casting(false)
	$FIRE.emitting = false
	_disappear()


func _appear():
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 6, 0.1)
	
func _disappear():
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 0, 0.1)
