extends Node2D
class_name SonG_PM_Process

#起始点
var x 
var y
var count
var command_start_po:Vector2 #命令开始位置

func _init(_x=0,_y=0,_count = 1):
    x     = _x
    y     = _y
    if _count <= 0: 
        _count = 1
    count = _count
    command_start_po = Vector2(x+40,y-20)

func get_command_po():
    command_start_po += Vector2(0,60)
    return command_start_po

func _draw():
    var space  = count * 60

    var points = [Vector2(x    ,y+6)   , ##
                  Vector2(x+6  ,y+6)   , # 倒角
                  Vector2(x+6  ,y)     , ##
                  Vector2(x+194,y)     , ##
                  Vector2(x+194,y+6)   , # 倒角
                  Vector2(x+200,y+6)   , ##
                  Vector2(x+200,y+34)  , ##
                  Vector2(x+194,y+34)  , # 倒角
                  Vector2(x+194,y+40)  , ## 
                  Vector2(x+110,y+40)  , ##
                  Vector2(x+100,y+60)  , #
                  Vector2(x+70 ,y+60)  , # 凸面
                  Vector2(x+60 ,y+40)  , ##
                  Vector2(x+40 ,y+40)  , 
                  Vector2(x+40 ,y+40+space),
                  Vector2(x+60 ,y+40+space) , ##
                  Vector2(x+70 ,y+60+space) , #
                  Vector2(x+100,y+60+space) , # 凹面
                  Vector2(x+110,y+40+space) , ##
                  Vector2(x+194,y+40+space) , ##
                  Vector2(x+194,y+44+space) , # 倒角
                  Vector2(x+200,y+44+space) , ##
                  Vector2(x+200,y+79+space) , ##
                  Vector2(x+194,y+79+space) , # 倒角
                  Vector2(x+194,y+85+space) , ##
                  Vector2(x+6  ,y+85+space) , ##
                  Vector2(x+6  ,y+79+space) , # 倒角
                  Vector2(x    ,y+79+space)   ## 
                ]
    draw_polygon(points, [Color("FFAB1A")])
    
    #绘制倒角
    draw_circle(Vector2(x+8  ,y+8)  , 8,Color("FFAB1A"))
    draw_circle(Vector2(x+192,y+8)  , 8,Color("FFAB1A"))
    draw_circle(Vector2(x+192,y+32) , 8,Color("FFAB1A"))
    draw_circle(Vector2(x+192,y+46+space), 8,Color("FFAB1A"))
    draw_circle(Vector2(x+192,y+77+space), 8,Color("FFAB1A"))
    draw_circle(Vector2(x+8  ,y+77+space), 8,Color("FFAB1A"))