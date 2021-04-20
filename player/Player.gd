extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 100
var is_charging = false
var charge_time = 1
var current_charge_time = 0

onready var animation = $AnimationPlayer
onready var shoot_position = $ShootPosition
var packed_arrow = load("res://arrow/Arrow.tscn")

#func _ready():
#	pass # Replace with function body.


func _process(_delta):
	
	
	var move_x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var move_y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if (!is_charging):
		if (move_x != 0 || move_y != 0):
			if (move_x != 0):
				direction = Vector2(move_x,0)
				if (move_x == 1):
					animation.play("right")
				else:
					animation.play("left")
			else: 
				direction = Vector2(0, move_y)
				if (move_y == -1):
					animation.play("up")
				else: 
					animation.play("down")
				
			move_and_slide(direction * speed)
	
	else:
		current_charge_time += _delta
		if (current_charge_time > charge_time):
			animation.play("charged")
		
	if (Input.is_action_just_pressed("shoot")):
		is_charging = true
		current_charge_time = 0
		
	
	if (Input.is_action_just_released("shoot")):
		var arrow = packed_arrow.instance()
		arrow.rotation = direction.angle()
		arrow.position = shoot_position.global_position
		if (current_charge_time > charge_time):
			arrow.is_powershot = true
		get_parent().add_child(arrow)
		animation.play("stop_charging")
		is_charging = false
		
	
