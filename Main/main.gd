class_name Main
extends Node2D
## Main game handler

@export var scene_center : Marker2D
@onready var Brass : Array[AudioStreamPlayer]  = [$Audio/Soundbytes/Brass1, $Audio/Soundbytes/Brass2, $Audio/Soundbytes/Brass3, $Audio/Soundbytes/Brass4, $Audio/Soundbytes/Brass5]
@export var passive_satisfaction_increase = 0.01
@onready var approval_rating : TextureProgressBar = %ApprovalRating

signal satisfaction_changed(new : float)

var difficulty: float = 0.5
var satisfaction : float = 1.0:
	set(x):
		satisfaction = clamp(x, 0, 1)
		if approval_rating:
			approval_rating.target = satisfaction
		satisfaction_changed.emit(satisfaction)

func _process(delta : float) -> void:
	satisfaction += delta * passive_satisfaction_increase * difficulty

func _on_joke_system_joke_failed() -> void:
	satisfaction += 0.05 * difficulty
func _on_joke_system_joke_success() -> void:
	satisfaction -= 0.1
	Brass[randi_range(0,3)].play()
func _on_player_got_hit(satisfaction_change: float) -> void:
	satisfaction += satisfaction_change

func _on_v_slider_value_changed(value: float) -> void:
	satisfaction = value
