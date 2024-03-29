extends Control

var ScreenXY = Vector2(0,0) #update with ``ScreenXY = get_tree().get_root().size``
var ScreenX = null
#var ScreenY = null

var GapAmt = 0
var PointNum = 8
var time = 0

#Instances
var PointInst = preload("res://Scenes/Point.tscn")
#var Points = get_tree().get_nodes_in_group("Point") #lets us control them all at once

func _ready():
	#<source_node>.connect(<signal_name>, <target_node>, <target_function_name>)
	get_tree().connect("screen_resized", self, "_on_SceneTree_screen_resized")
	#initializing in case screen is not resized at all on launch
	SpaceCalcX()
	#ScreenY = OS.window_size.y

func _on_SceneTree_screen_resized():
	ScreenX = OS.window_size.x
	SpaceCalcX()

func _unhandled_input(event):
	if Input.is_action_pressed("ui_left"):
		if PointNum > 2:
			PointNum -= 1
			SpaceCalcX()
	if Input.is_action_pressed("ui_right"):
		if PointNum < 20:
			PointNum += 1
			SpaceCalcX()

func SpaceCalcX():
	ScreenX = OS.window_size.x
	GapAmt = (ScreenX / PointNum)
	PlacePoints(PointNum, GapAmt)
	$NumPanel/Label.text = ("# of Points: " + PointNum as String)
	$GapPanel/Label.text = ("Gap Between Points: " + GapAmt as String)
	

func _process(delta: float):
	time += delta
	if time > 1:
		time = 0
		print("1 second")
		

func PlacePoints(num: int, gap: float):
	print("Num: " + num as String + " Gap: " + gap as String)
	#for i in num:
	#	print(i)
		#PointInst = load("res://Scenes/Point.tscn")
		#PointInst.move_local_x(num * i)
		#PointInst.name = ("Point_" + i as String)
		#	add_child(s)