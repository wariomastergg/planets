extends Node2D


var velocity = Vector2(.05,0.05)
var mov = Vector2(0.,0.)
var drag = .01
var moons
func _ready():
	moons = [$Circle, $Circle2, $Circle3, $Circle4, $Circle5]

func fl(x,r):
	if x == 0:
		return 1
	return abs(x-r)/(x-r)

func _process(delta):
	var grav = 0
	var d =  $BlackSquare.global_position.distance_to(moons[0].global_position)
	for i in range(len(moons)):
		if $BlackSquare.global_position.distance_to(moons[i].global_position) < d:
			grav = i
		
	var dis = $BlackSquare.global_position.distance_to(moons[grav].global_position)
	var dir = (moons[grav].global_position-$BlackSquare.global_position).normalized()
	mov = Vector2(0,0)
	if Input.is_action_pressed("up"):
		mov.y = -1
	if Input.is_action_pressed("down"):
		mov.y = 1
	if Input.is_action_pressed("left"):
		mov.x = -1
	if Input.is_action_pressed("right"):
		mov.x = 1
	$ColorRect.global_position = moons[grav].global_position
	velocity += mov*0.005
	velocity += (dir/100)*fl(dis,110)
	velocity += -velocity*drag
	
	$BlackSquare.look_at(moons[grav].global_position)
	$BlackSquare.rotation += -PI/2
	
	$BlackSquare.global_position += (velocity/delta)
