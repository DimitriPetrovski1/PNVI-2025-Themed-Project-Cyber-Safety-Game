extends Problem
class_name EmailProblem

@export var sender: String
@export var subject: String
@export var body_preview: String
@export var has_attachment: bool = false
@export var suspicious_flags: Array[String] = []
