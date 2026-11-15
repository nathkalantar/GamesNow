extends Control

@export var progress_bar_1: TextureProgressBar
@export var progress_bar_2: TextureProgressBar
@export var rich_text_label_1: RichTextLabel
@export var rich_text_label_2: RichTextLabel
@export var dash_bar_1: TextureProgressBar
@export var dash_bar_2: TextureProgressBar
@export var dash_number_1: RichTextLabel
@export var dash_number_2: RichTextLabel

func _changeRpm1(rpmValue: int) -> void:
	progress_bar_1.value = rpmValue as float
	rich_text_label_1.text = str(rpmValue)

func _changeRpm2(rpmValue: int) -> void:
	progress_bar_2.value = rpmValue as float
	rich_text_label_2.text = str(rpmValue)
	
func _changeDash1(dashValue: int) -> void:
	dash_bar_1.value = dashValue as float
	if (dashValue < 25): dash_number_1.text = "0"
	elif (dashValue >= 25 && dashValue < 50): dash_number_1.text = "1"
	elif (dashValue >= 50 && dashValue < 75): dash_number_1.text = "3"
	elif (dashValue >= 75 && dashValue < 100): dash_number_1.text = "5"
	elif (dashValue >= 100): dash_number_1.text = "10"

func _changeDash2(dashValue: int) -> void:
	dash_bar_2.value = dashValue as float
	if (dashValue < 25): dash_number_2.text = "0"
	elif (dashValue >= 25 && dashValue < 50): dash_number_2.text = "1"
	elif (dashValue >= 50 && dashValue < 75): dash_number_2.text = "3"
	elif (dashValue >= 75 && dashValue < 100): dash_number_2.text = "5"
	elif (dashValue >= 100): dash_number_2.text = "10"
