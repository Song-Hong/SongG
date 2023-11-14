extends Node
class_name IEvenState

signal finshed #当组件任务结束时
signal destory #当组件结束删除时
signal process #组件订阅更新

var scene

#初始化
func start():pass

#显示出现动画
func showAnimation(tween:Tween):
	scene.scale = Vector2(0.1,0.1)
	scene.pivot_offset = scene.size/2
	tween.tween_property(scene, "scale", Vector2(1.1, 1.1), 0.2)
	tween.tween_property(scene, "scale", Vector2(0.9, 0.9), 0.2)
	tween.tween_property(scene, "scale", Vector2(1.03, 1.03), 0.1)
	tween.tween_property(scene, "scale", Vector2(0.97, 0.97), 0.1)
	tween.tween_property(scene, "scale", Vector2(1.01, 1.01), 0.05)
	tween.tween_property(scene, "scale", Vector2(0.99, 0.99), 0.05)
	tween.tween_property(scene, "scale", Vector2(1, 1), 0.02)

#显示移动动画
func showMoveAnimation(startpo,endpo,tween:Tween):pass

#显示删除动画
func destoryAnimation(tween:Tween)->Tween:
	tween.tween_property(scene,"scale",Vector2(0.1,0.1),0.5)
	return tween

#睡眠
func sleep(time):
	time *= 1000000
	OS.delay_usec(time)
