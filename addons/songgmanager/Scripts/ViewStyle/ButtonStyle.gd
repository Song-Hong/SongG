@tool
extends Button

func _ready():
    var wnd_size   = DisplayServer.screen_get_size(DisplayServer.MAIN_WINDOW_ID)
    var zoom       = Vector2(wnd_size.x/1920.0,wnd_size.y/1080.0)
    var font_size  = get_theme_font_size("font_size","SongGName")
    add_theme_font_size_override("font_size",font_size * zoom.x-2)
    custom_minimum_size *= zoom.x