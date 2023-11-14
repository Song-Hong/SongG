extends IMoudle
class_name EvenState
static var init:EvenState
func _init():init = self

var even_states:Array[IEvenState]
var width = 80
var area

func create(evenState:IEvenState):
	if !area:
		area = SongG.get_view("EvenState")
	even_states.append(evenState)
	var scene  = evenState.start()
	evenState.connect("destory",Callable(self,"on_destory"))
	var w = scene.size.x
	var h = scene.size.y
	area.add_child(scene)
	scene.position = Vector2(width+10,8)
	width += w +10
	evenState.showAnimation(get_tree().create_tween())

func _process(delta):
	for even_state in even_states:
		even_state.process.emit(delta)
	
func on_destory(evenState:IEvenState):
	await evenState.destoryAnimation(get_tree().create_tween()).finished
	area.remove_child(evenState.scene)
	even_states.erase(evenState)
	sort_even_states()

func sort_even_states():
	width = 80
	var i = 0
	for even_state in even_states:
		var tween = get_tree().create_tween()
		tween.set_trans(tween.TRANS_BACK)
		tween.tween_property(even_state.scene,"position",Vector2(width+12,8) ,0.3+i)
		width += even_state.scene.size.x +10
		i+=0.04
