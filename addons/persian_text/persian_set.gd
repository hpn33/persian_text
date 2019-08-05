extends Node


var debug = false

enum dir { rtl, ltr }
enum {FA, EN, UN}

var FULL_L = [EN, FA]

var current_lang



var fa_word = [
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

var fa_s_word = ["آ","ا","د","ذ","ر","ز","ژ","و",
" ","‌",".","+","-",")","(","*","&","^","%","$",
"#","@","!","~","`","\"","\\","|","}","{","0","9",
"8","7","6","5","4","3","2","1","0","?","/",">",
"<","ء",":","،","ٍ","ٌ","ً","ّ","ِ","َ","؛",",","=","_","[","]","«","»","ـ"]
 
var en_word = [
	"a", "b", "c", "d",
	"e", "f", "g", "h",
	"i", "j", "k", "l",
	"m", "n", "o", "p",
	"q", "r", "s", "t",
	"u", "v", "w", "x",
	"y", "z"
]

var en_s_word = ["آ","ا","د","ذ","ر","ز","ژ","و",
" ","‌",".","+","-",")","(","*","&","^","%","$",
"#","@","!","~","`","\"","\\","|","}","{","0","9",
"8","7","6","5","4","3","2","1","0","?","/",">",
"<","ء",":","،","ٍ","ٌ","ً","ّ","ِ","َ","؛",",","=","_","[","]","«","»","ـ"]




class Letter:
	# character
	var c := ""
	var type := UN
	var no := 0
	var position := -1
	var is_shift = false


class Part:
	var type = -1
	var tokens := []
	
	func add(value: Letter):
		tokens.append(value)
	
	func get_fa_word(fa_list, fa_s_list) -> String:
		
		var word := ""
		var size := tokens.size()
	
		for i in size:
		
			var token = tokens[i]
		
			match type:
				FA:
					if token.is_shift:
						word = fa_s_list[abs(token.position + 2)] + word
					else:
						word = fa_list[(token.position * 4) + token.no] + word
#				EN:
#					word += token.c
				UN:
					word = token.c + word
		
		return word
	
	func get_en_word() -> String:
		
		var word := ""
		var size := tokens.size()
	
		for i in size:
		
			var token = tokens[i]
		
			match type:
				EN:
					word += token.c
				UN:
					word = token.c + word
		
		return word


class PartHolder:
	var type = -1
	var parts := []
	
	func append(part: Part):
		parts.append(part)
	
	func init(part: Part):
		type = part.type
		print(type)
		append(part)
	
	func get_part(fa_word: Array, fa_s_word: Array) -> String:
		var string := ""
		
		match type:
			FA:
				for part in parts:
					string = part.get_fa_word(fa_word, fa_s_word) + string
			EN:
				for part in parts:
					string += part.get_en_word() 

		
		return string


class TextTree:
	var branchs := []
	
	func init(util, letters):
		
		split_to_parts(letters)
		set_persian_char_type(util)
		collect_en_part()
		pass
	
	func append(value):
		branchs.append(value)
	
	func split_to_parts(letters: Array):
		"""
		splite text by type language for accessablity
		"""
		
		var part := Part.new()
		var letter_size := letters.size()
		
		for i in letter_size:
			
			var letter = letters[i]
			
			
			if letter.type != part.type:
				append(part)
				
				part = Part.new()
				part.type = letter.type
				part.add(letter)
				
				if i + 1 == letter_size:
					append(part)
				
			else:
				part.add(letter)
				if i + 1 == letter_size:
					append(part)
		
		
		branchs.pop_front()
	
	func set_persian_char_type(util):
		"""
		set type of characters for persian
		"""
		for part in branchs:
			if part.type != FA:
				continue
			
			var tokens = part.tokens
			var token_size = tokens.size()
			
			
			for i in token_size:
				var token = tokens[i]
				
				
				# if i was first char
				if i == 0:
					# and was last char
					if i == token_size - 1:
						token.no = 0
					else:
						token.no = 2
				
				# if was a shift char
				elif util.check_s(tokens[ i - 1 ]) :
					# if not was last char
					if (i != token_size - 1):
						#	if (shift_char_position( tokens[ i + 1 ].c ) < -1):
						if util.check_s(tokens[ i + 1 ]):
							token.no = 0 
						else:
							token.no = 2
					else:
						token.no = 0
				
				# if was between or somthing
				else:
					# if not was last char
					if (i != token_size - 1):
						#
						if util.check_s(tokens[ i + 1 ], true):
							token.no = 1
						else:
							token.no = 3
					else:
						token.no = 1
					
				tokens[i] = token
			
			
			part.tokens = tokens
	
	func collect_en_part():
		var text_tr := []
		var new_part := PartHolder.new()
		var end = false
		var new = false
		var adi = true
		var next = false
		
		
		for i in branchs.size():
			
			
			if new_part.type == -1:
				new_part.init(branchs[i])
				if i + 1 < branchs.size():
					i += 1
			
			while not end:
				
				match new_part.type:
					FA:
						if branchs[i].type == FA:
							new_part.append(branchs[i])
						
						elif branchs[i].type == EN:
							next = true
						
						elif branchs[i].type == UN:
							new_part.append(branchs[i])
					
					EN:
						if branchs[i].type == FA:
							next = true
						
						elif branchs[i].type == EN:
							new_part.append(branchs[i])
						
						elif branchs[i].type == UN:
							if branchs[i +1].type == EN:
								new_part.append(branchs[i])
							else:
								next = true
					
					UN:
						if branchs[i].type == FA:
							new_part.append(branchs[i])
							new_part.type = FA
						
						elif branchs[i].type == EN:
							next = true
						
				
				
				if next:
					next = false
					text_tr.append(new_part)
					new = true
					adi = false
	
				if adi:
					if i + 1 < branchs.size():
						i += 1
					else:
						text_tr.append(new_part)
						end = true
				else:
					adi = true
				
				
				if new:
					new = false
					new_part = PartHolder.new()
					new_part.init(branchs[i])
					
					if i + 1 < branchs.size():
						i += 1
		
		branchs = text_tr





# get position in special Chars
func s_char_position( letter: Letter) -> Letter:
	
	match letter.type:
		FA:
			for i in range( 8, fa_s_word.size() ):
				if letter.c == fa_s_word[i]:
					letter.is_shift = true
					letter.position = (-i)-2
					debug("	fa_s:	" + letter.c + "	" + str(letter.position))
					break
		EN:
			for i in range( 8, en_s_word.size() ):
				if letter.c == en_s_word[i]:
					letter.is_shift = true
					letter.position = (-i)-2
					debug("	en_s:	" + letter.c + "	" + str(letter.position))
					break
	
	if letter.type == UN:
		debug("	un:	" + letter.c + "	" + str(letter.position))
	return letter

# check and get postion from persian char list
func fa_char_position( letter: Letter ) -> Letter:
	for i in persia.size():
		if letter.c == persia[i]:
			letter.position = i
			letter.type = FA
			debug("	fa:	" + letter.c + "	" + str(letter.position))
			break
	
	return letter

# check and get postion from persian char list
func en_char_position( letter: Letter ) -> Letter:
	for i in en_word.size():
		if letter.c == en_word[i]:
			letter.position = i
			letter.type = EN
			debug("	en:	" + letter.c + "	" + str(letter.position))
			break
	
	return letter






func check_s(letter: Letter, limit = false) -> bool:
	if limit:
		for i in range(8, fa_s_word.size()):
			if letter.c == fa_s_word[i]:
				return true
	else:
		for i in fa_s_word.size():
			if letter.c == fa_s_word[i]:
				return true
	return false





func make_text(text_tree: TextTree) -> String:
	
	debug("----making text")
	
	var text = ""
	
	for part_holder in text_tree.branchs:
		
		var string = part_holder.get_part(fa_word, fa_s_word)
		
		text = string + text
	
	debug(text)
	
	return text




func convert_to_array(text: String) -> Array:
	var letters = []
	var size = text.length()
	
	for i in size:
		var letter = Letter.new()
		
		letter.c = text[i]
		
		debug("============")
		
		
		letter = s_char_position(letter)
		
		letter = fa_char_position(letter)
		if letter.type == UN:
			letter = en_char_position(letter)
		
		
		
		letters.append(letter)
	
	return letters






func lexer(text) -> TextTree:
	
	debug("====lexer=====================")
	
	var letters = convert_to_array(text)
	
	var text_tree := TextTree.new()
	text_tree.init(self, letters)
	
	return text_tree

func parser(text_tree: TextTree) -> String:
	
	debug("====parser==================")
	
	return make_text(text_tree)


func fix_text(text: String) -> String:
	return parser(lexer(text))



func debug(text) -> void: 
	if debug:
		print(text)

