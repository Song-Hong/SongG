extends IModule
class_name Wnd
static var init:Wnd
func _init():init=self

#缩放比例
var zoom_value:float=1.0

func _ready():
    var wnd_size = DisplayServer.window_get_size(DisplayServer.MAIN_WINDOW_ID)
    zoom_value   = wnd_size.x/1920.0

#获取缩放比例
func zoom_beta(value)->float:
    return zoom_value*value 

func zoom_font(value)->float:
    return zoom_value*value-2

#设置窗口尺寸
func set_size(_size):
    get_window().size = _size

#获取窗口尺寸
func get_size()->Vector2:
    return get_window().size

#设置窗口位置
func set_positon(_position):
    get_window().position = _position

#获取窗口位置
func get_positon()->Vector2:
    return get_window().position

## 窗口动画
# extent 幅度 count 次数 time 每次时间间隔
func Jitter(extent = Vector2(6,0),count = 10,time = 0.02):
    var wnd = get_window()
    var tween = get_tree().create_tween()
    for i in range(count):
        tween.tween_property(wnd,"position",wnd.position+extent,time)
        tween.tween_property(wnd,"position",wnd.position-extent,time)