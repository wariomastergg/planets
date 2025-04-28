extends Node2D


var velocity = Vector2(.05,0.05)

var moons
func _ready():
	moons = $Node2D.get_children()

func fl(x,r):
	if x == 0:
		return 0
	return (abs(x-r)/(x-r))




func closest(a, b):
	var d = a.distance_to(b[0].position)
	var p = b[0].global_position
	for i in b:
		if a.distance_to(i.position) < d:
			p = i.global_position
	return p


var mov = Vector2(0.,0.)
var drag = .000

var vec
var grav
var dis
func _process(delta):
	
			
	grav = Vector2(0,0)
	for i in range(len(moons)):
		vec = moons[i].global_position-$BlackSquare.global_position
		dis = vec.distance_to(Vector2(0,0))
		
		grav += (150/(dis**2)) * vec.normalized() * moons[i].scale.x
 #* fl(dis,100)
		
		
	
	mov = Vector2(0,0)
	if Input.is_action_pressed("up"):
		#mov.y = -1
		pass
	if Input.is_action_pressed("down"):
		#mov.y = 1
		pass
	if Input.is_action_pressed("left"):
		#mov.x = -1
		velocity = velocity.rotated(-.02)
		pass
	if Input.is_action_pressed("right"):
		#mov.x = 1
		velocity = velocity.rotated(.02)
		pass

	
	
	
	
	
	velocity += grav
	
	
	for i in moons:
		dis = $BlackSquare.position.distance_to(i.position)
		
		var siz = i.scale.y
		var scl = 70*siz+40
		if dis < scl:
			#print(dis)
			vec = i.global_position-$BlackSquare.global_position
			var norm = vec.normalized()
			#print(vec.angle())
			$BlackSquare.position = $BlackSquare.position - ((scl)-dis) * norm
			velocity = norm*.001
			
			if Input.is_action_pressed("left"):
				velocity += norm.rotated(PI/2)*.1
			if Input.is_action_pressed("right"):
				velocity -= norm.rotated(PI/2)*.1
			
			if Input.is_action_pressed("jump"):
				velocity += vec.normalized()*-.2

	
	velocity += mov*0.05
	velocity += -velocity*drag
	
	$BlackSquare.rotation = lerp_angle($BlackSquare.rotation, velocity.angle() - PI/2, .3)
	
	
	$BlackSquare.global_position += (velocity/delta)
	
			
