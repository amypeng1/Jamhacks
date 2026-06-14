extends CanvasLayer

@onready var quiz_box: CanvasLayer = $"../Quiz Pop Up"
@onready var question_label: Label = $Question/VBoxContainer/Label
@onready var btn_a: Button = $Question/VBoxContainer/OptionA
@onready var btn_b: Button = $Question/VBoxContainer/OptionB
@onready var btn_c: Button = $Question/VBoxContainer/OptionC
@onready var btn_d: Button = $Question/VBoxContainer/OptionD
@onready var btn_again: Button = $WrongAnswer/TryAgain
@onready var btn_again2: Button = $WrongAnswer2/TryAgain2
@onready var btn_again3: Button = $WrongAnswer3/TryAgain3

var current_correct_answer: String = ""

func _ready() -> void:
	print("🚨 THE QUIZ POPUP SCRIPT HAS SUCCESSFULLY AWOKEN!")
	
	# 1. FORCE THE WHOLE SCENE SYSTEM TO STAY AWAKE DURING PAUSE
	process_mode = PROCESS_MODE_ALWAYS
	
	# 2. FORCE EVERY SINGLE BUTTON TO IGNORE THE PAUSE STATE VIA CODE
	if btn_a: btn_a.process_mode = PROCESS_MODE_ALWAYS
	if btn_b: btn_b.process_mode = PROCESS_MODE_ALWAYS
	if btn_c: btn_c.process_mode = PROCESS_MODE_ALWAYS
	if btn_d: btn_d.process_mode = PROCESS_MODE_ALWAYS
	if btn_again: btn_again.process_mode = PROCESS_MODE_ALWAYS
	if btn_again2: btn_again2.process_mode = PROCESS_MODE_ALWAYS
	if btn_again3: btn_again3.process_mode = PROCESS_MODE_ALWAYS
	
	# 3. CONNECT THE BUTTON CLICK LISTENERS
	if btn_a: btn_a.pressed.connect(func(): _on_answer_selected(btn_a.text))
	if btn_b: btn_b.pressed.connect(func(): _on_answer_selected(btn_b.text))
	if btn_c: btn_c.pressed.connect(func(): _on_answer_selected(btn_c.text))
	if btn_d: btn_d.pressed.connect(func(): _on_answer_selected(btn_d.text))
	if btn_again: btn_again.pressed.connect(_on_try_again_pressed)
	if btn_again2: btn_again2.pressed.connect(_on_try_again_pressed2)
	if btn_again3: btn_again3.pressed.connect(_on_try_again_pressed3)
	
	# 4. HIDE IT UNTIL NEEDED
	visible = false

func open_quiz(level: String, question: String, choice_a: String, choice_b: String, choice_c: String, choice_d: String, correct_answer: String) -> void:
	question_label.text = question
	$Question/VBoxContainer/Label.text = level
	$Question/VBoxContainer/Label2.text = question
	$Question/VBoxContainer/OptionA.text = choice_a
	$Question/VBoxContainer/OptionB.text = choice_d
	$Question/VBoxContainer/OptionC.text = choice_c
	$Question/VBoxContainer/OptionD.text = choice_d
	$Question.visible = true
	$RightAnswer.visible = false
	$WrongAnswer.visible = false
	$RightAnswer2.visible = false
	$WrongAnswer2.visible = false
	$RightAnswer3.visible = false
	$WrongAnswer3.visible = false
	
	btn_a.text = choice_a
	btn_b.text = choice_b
	btn_c.text = choice_c
	btn_d.text = choice_d
	current_correct_answer = correct_answer
	
	visible = true
	get_tree().paused = true # This freezes the cat safely

func _on_answer_selected(selected_text: String) -> void:
	# This print is at the absolute top. If your mouse click lands, it WILL show up!
	print("🎯 CRITICAL TEST: A CLICK WAS SUCCESSFULLY REGISTERED!")
	print("Player clicked: ", selected_text)
	print("Target answer: ", current_correct_answer)
	
	if selected_text == current_correct_answer:
		question_label.text = "Correct!"
		if Global.ramen_made == true and Global.compdone == true:
			$Question.visible = false
			$RightAnswer3.visible = true
			$WrongAnswer3.visible = false
			Global.touchgrass = true
		elif Global.ramen_made == true:
			$Question.visible = false
			$RightAnswer2.visible = true
			$WrongAnswer2.visible = false
			Global.compdone = true
		else:
			$Question.visible = false
			$RightAnswer.visible = true
			$WrongAnswer.visible = false
			Global.ramen_made = true
		
		await get_tree().create_timer(1).timeout
		get_tree().paused = false
		visible = false
	else:
		question_label.text = "Wrong answer! Try again."
		if Global.ramen_made == true and Global.compdone == true:
			$Question.visible = false
			$RightAnswer3.visible = false
			$WrongAnswer3.visible = true
		elif Global.ramen_made == true:
			$Question.visible = false
			$RightAnswer2.visible = false
			$WrongAnswer2.visible = true
		else:
			$Question.visible = false
			$RightAnswer.visible = false
			$WrongAnswer.visible = true

		visible = true
		get_tree().paused = true
		
func _on_try_again_pressed() -> void:
	print ("sigma rizz")
	if Global.ramen_made == false:
		quiz_box.open_quiz("Ramen Noodle Challenge", "What colour is Jam Jam?", "Purple", "Vomit Green", "Skid Mark Brown", "Pink Eye Rose", "Purple")
#chud ahh lazy way to get the function to work
func _on_try_again_pressed2() -> void:
	if Global.compdone == false:
		quiz_box.open_quiz("Clash Royal Battle","Best Hackathon Drink", "Monster", "Redbull", "Toilet Water", "Boba", "Boba")

func _on_try_again_pressed3() -> void:
	quiz_box.open_quiz("Karoake","Best Karoake Song", "I Want It That Way", "Baby", "Golden", "Love Story", "Baby")
