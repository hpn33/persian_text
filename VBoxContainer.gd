extends VBoxContainer

#var script := LangSet.new()
var per



func _ready():
	var sample_text := ")متن 1: این متن »نمونه‌ای« است برای بررسی \"صحت حروف‌چینی\" _*+گودوت‌انجین+*_ ("
	var tx := "سلام.hello"
	
#	print(per.lang_set(tx,[]))
	
	set_text(sample_text)

func set_text(text : String):
#	$Label.text = per.lang_set(text, [])
	$Label2.text = text