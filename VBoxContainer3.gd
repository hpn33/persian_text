extends VBoxContainer

func _ready():
	var sample_text := ")متن 1: این متن »نمونه‌ای« است برای بررسی \"صحت حروف‌چینی\" _*+گودوت‌انجین+*_ ("
	var tx := "سلام. hello to you بهترین الله nice جیگر"
	
#	set_text(tx)
	set_text(tx)



func set_text(text : String):
	$Label.text = persian.fix_text(text)
	$Label2.text = text