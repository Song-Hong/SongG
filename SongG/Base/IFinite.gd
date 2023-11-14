extends Node
class_name IFinite

signal state_change_start
signal state_change_end

var own
var nowState:IState
var states:Dictionary

#初始化
func _init(_own): 
	own = _own

#添加状态
func add_state(state_name:String,state:IState):
	if states.has(state_name):return
	states[state_name] = state
	state.finite = self

#删除状态
func del_state(state_name:String):
	if !states.has(state_name):return
	states.erase(state_name)

#是否存在状态
func exist_state(state_name:String):
	return states.has(state_name)

#开始状态
func start(state_name):
	if !states.has(state_name):return
	nowState = states[state_name]
	nowState.on_enter()

#更新
func _stay(_delta):
	if nowState != null:
		nowState.on_stay(_delta)

#改变状态
func change_state(state_name:String):
	if !states.has(state_name):return
	if nowState!=null:nowState.on_exit()
	nowState = states[state_name]
	state_change_start.emit()
	nowState.on_enter()
	state_change_end.emit()

#改变状态
func changeState(state:IState):
	if nowState!=null:nowState.on_exit()
	if state.finite==null:state.finite = self
	nowState = state
	state_change_start.emit()
	nowState.on_enter()
	state_change_end.emit()
