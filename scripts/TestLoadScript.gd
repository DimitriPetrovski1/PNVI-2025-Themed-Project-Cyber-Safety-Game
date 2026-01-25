extends Node

func _ready():
	var path = "res://game_data/problems/email/phishing_coupon.tres"
	
	var problem = ResourceLoader.load(path)
	
	if problem == null:
		print("❌ Failed to load resource at ", path)
		return
	
	# Check the type
	if problem is EmailProblem:
		print("✅ Successfully loaded EmailProblem")
	else:
		print("⚠ Loaded resource, but not EmailProblem. Type:", problem.get_class())

	# Print its data
	print("Category:", problem.category)
	print("Prompt:", problem.prompt)
	print("Correct actions:", problem.correct_actions)
