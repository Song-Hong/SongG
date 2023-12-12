extends Node2D
class_name SongG_PM_Command

#起始点
var x 
var y

func _init(po:Vector2):
    x = po.x
    y = po.y

func _draw():
    #绘制图像
    var points = [Vector2(x,y),
                  Vector2(x+20,y),    ##
                  Vector2(x+30,y+20), #
                  Vector2(x+60,y+20), # 凹槽
                  Vector2(x+70,y),    ##
                  Vector2(x+260,y),
                  Vector2(x+260,y+60),
                  Vector2(x+70 ,y+60), ##
                  Vector2(x+60 ,y+80), #
                  Vector2(x+30 ,y+80), # 凸槽
                  Vector2(x+20 ,y+60), ##
                  Vector2(x,y+60),
                ]
    draw_polygon(points, [Color("D063CF")])

    #绘制底部边框
    var lines  = [Vector2(x+260,y+60),
                  Vector2(x+70 ,y+60), ##
                  Vector2(x+60 ,y+80), #
                  Vector2(x+30 ,y+80), # 凸槽
                  Vector2(x+20 ,y+60), ##
                  Vector2(x,y+60),
                ]
    draw_polyline(lines, Color("874086"))
