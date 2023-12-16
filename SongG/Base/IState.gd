## 
# 逻辑层
# 状态机的状态
##
extends Node
class_name IState

var finite:Finite

func on_enter()            :pass
func on_stay(_delta)       :pass
func on_exit()             :pass

func get_own(): 
	return finite.own

func change_state(state_name:String):
	finite.change_state(state_name)

func changeState(state:IState):
	finite.changeState(state)
