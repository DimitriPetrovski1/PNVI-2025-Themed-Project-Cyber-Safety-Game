extends Resource
class_name Problem

@export var category: String
@export var prompt: String               # customer speech description
@export var correct_actions: Array[String] = []   # multiple valid answers
@export var tags: Array[String] = []     # optional metadata
