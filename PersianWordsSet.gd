tool
extends VBoxContainer

var persiaWords = [
"آ","ﺎ","آ","ﺎ",
"ا","ﺎ","ا","ﺎ",
"ب","ﺐ","ﺑ","ﺒ",
"پ","ﭗ","ﭘ","ﭙ",
"ت","ﺖ","ﺗ","ﺘ",
"ث","ﺚ","ﺛ","ﺜ",
"ج","ﺞ","ﺟ","ﺠ",
"چ","ﭻ","ﭼ","ﭽ",
"ح","ﺢ","ﺣ","ﺤ",
"خ","ﺦ","ﺧ","ﺨ",
"د","ﺪ","د","ﺪ",
"ذ","ﺬ","ذ","ﺬ",
"ر","ﺮ","ر","ﺮ",
"ز","ﺰ","ز","ﺰ",
"ژ","ﮋ","ژ","ﮋ",
"س","ﺲ","ﺳ","ﺴ",
"ش","ﺶ","ﺷ","ﺸ",
"ص","ﺺ","ﺻ","ﺼ",
"ض","ﺾ","ﺿ","ﻀ",
"ط","ﻂ","ﻃ","ﻄ",
"ظ","ﻆ","ﻇ","ﻈ",
"ع","ﻊ","ﻋ","ﻌ",
"غ","ﻎ","ﻏ","ﻐ",
"ف","ﻒ","ﻓ","ﻔ",
"ق","ﻖ","ﻗ","ﻘ",
"ک","ﮏ","ﮐ","ﮑ",
"گ","ﮓ","ﮔ","ﮕ",
"ل","ﻞ","ﻟ","ﻠ",
"م","ﻢ","ﻣ","ﻤ",
"ن","ﻦ","ﻧ","ﻨ",
"و","ﻮ","و","ﻮ",
"ه","ﻪ","ﻫ","ﻬ",
"ی","ﯽ","ﯾ","ﯿ",
"ﻻ","ﻼ","ﻻ","ﻼ"]

var persia=["آ","ا","ب","پ","ت","ث","ج","چ","ح","خ","د","ذ","ر","ز","ژ","س","ش","ص","ض","ط","ظ","ع","غ","ف","ق","ک","گ","ل","م","ن","و","ه","ی"]

var special = ["آ","ا","د","ذ","ر","ز","ژ","و",
" ","‌",".","+","-",")","(","*","&","^","%","$",
"#","@","!","~","`","\"","\\","|","}","{","0","9",
"8","7","6","5","4","3","2","1","0","?","/",">",
"<","ء",":","،","ٍ","ٌ","ً","ّ","ِ","َ","؛",",","=","_","[","]","«","»","ـ"]

func specialno(text):
	for i in range(special.size()):
		if(text==special[i]):
			return true
	return false

func specialChar( letter ):
	for i in range( 8, special.size() ):
		if( special[ i ] == letter ):
			if ( i == 0 ):
				return -2
			else:
				return  (-i)-2
	return -1

func persiaSet(array):
	var text = ""
	var no
	var pos
	var end = array.length()
	
	for i in range( end ):
		pos = specialChar( array[ i ] ) 
#		print(array[i] + "	" + str(pos))
		for j in range(persia.size()):
			if(persia[ j ]==array[ i ]):
				pos=j
				break
		if ( i == 0 ):
			if( i == end - 1 ):
				no = 0
			else:
				no = 2
		elif( specialno(array[ i - 1 ]) ):
			if( i  != end - 1):
				if(  specialChar( array[ i + 1 ] ) < -1):
					no = 0 
				else:
					no = 2
			else:
				no = 0
		else:
			if(i != end-1):
				if(  specialChar( array[ i + 1 ] ) < -1):
					no = 1 
				else:
					no = 3 
			else:
				no = 1
		if (pos >= 0):
			text = persiaWords[(pos*4)+no]+text
		else:
			text = special[abs(pos+2)]+text
		
#		print(array[i] + "	" + str(pos))

	return text
	pass

func _ready():
	var SampleText = "&rlm;)متن 1: این متن »نمونه‌ای« است برای بررسی \"صحت حروف‌چینی\" _*+گودوت‌انجین+*_ ( سلام. hello."
	get_node("Label").set_text(persiaSet(SampleText))
	get_node("Label2").set_text(SampleText)
	pass


