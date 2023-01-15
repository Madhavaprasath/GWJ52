extends KinematicBody2D

export (int) var speed=100

enum States{
	Idle,
	Move,
	Attack
}
var velocity=Vector2()
var input_vector=Vector2()

var current_state=States.Idle
var previous_state=null

func _ready():
	pass

func _physics_process(delta):
	input_vector=get_input_vector()
	
	var state=transition(delta)
	if state!=null:
		previous_state=current_state
		current_state=state
		enter_state(previous_state,current_state,delta)
		exit_state(previous_state,current_state)
	velocity=lerp(velocity,input_vector*speed,pow(0.03,delta))
	velocity=move_and_slide(velocity,Vector2.UP)

func transition(delta):
	match current_state:
		States.Idle:
			if input_vector!=Vector2():
				return States.Move
		States.Move:
			if input_vector==Vector2():
				return States.Idle
	return null


func get_input_vector():
	return Vector2(int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left")),
	int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up")))

func enter_state(prev_state,new_state,delta):
	pass
func exit_state(current_state,new_state):
	pass
