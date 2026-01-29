extends Control

signal submitSelection(solutions:Array[String])

@onready var checkboxes:Array[CheckButton]=[]
@onready var currProblem:Problem = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	visible = false


func buildSelectionSection(problem:RealLifeProblem):
	checkboxes = []
	var RealLifeSelectionContainer =  $VBoxContainer/RealLifeLelectionPanel/RealLifeSelectionContainer
	for child in RealLifeSelectionContainer.get_children():
		child.queue_free()
	for option in problem.get_possible_choices():
		var cb := CheckButton.new()
		cb.text = option
		cb.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		RealLifeSelectionContainer.add_child(cb)
		checkboxes.append(cb)

func _on_gameplay_scene_1_new_problem(problem: Problem) -> void:
	currProblem = problem
	visible = false
	if problem is RealLifeProblem:
		$VBoxContainer/RealLifeDisplayPanel/RealLifeTextLabel.text=problem.description
		buildSelectionSection(problem)


func _on_real_life_submit_solution_button_pressed() -> void:
	var selections:Array[String] = []
	
	for cb in checkboxes:
		if cb.button_pressed:
			selections.append(cb.text)
			
	
	visible = false
	submitSelection.emit(selections)

func _on_load_problem_button_show_problem() -> void:
	if currProblem is RealLifeProblem:
		visible = true
