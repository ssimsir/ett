
var browser = 'NS';

var code_field = "";
var candidates = "";
code_len = 12;
code_table = new Array();
pattern = /[a-z';]+[^a-z';]+/g;
pattern.compile("[a-z';]+[^a-z';]+", "g");
// "raw" is defined in *-table.js
while (pattern.exec(raw) != null) code_table.push(RegExp.lastMatch);

word_list = new Array();
left_yinhao1 = false;
left_yinhao2 = false;
ctrl_keydown = false;
right_arrow = false;
cancel_key_event = false;
start_mem = -1;
index_mem = 0;
start_stack = new Array();
index_stack = new Array();
key_en = "1234567890abcdefghijklmnopqrstuvwxyz";
key_EN = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
key_quan = "１２３４５６７８９０ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ";
key_QUAN = "！·＃＄％…＆＊（）ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ";
fuhao = new Array();
fuhao[1] = "。，、；：？！…—·ˉˇ¨‘’“”々～‖∶＂＇｀｜〃〔〕〈〉《》「」『』．〖〗【】（）［］｛｝︵︶︹︺︿﹀︽︾﹁﹂﹃﹄︻︼︷︸︱︳︴";
fuhao[2] = "≈≡≠＝≤≥＜＞≮≯∷±＋－×÷／∫∮∝∞∧∨∑∏∪∩∈∵∴⊥∥∠⌒⊙≌∽√≒≦≧⊿";
fuhao[3] = "ⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩⅪⅫ⒈⒉⒊⒋⒌⒍⒎⒏⒐⒑⒒⒓⒔⒕⒖⒗⒘⒙⒚⒛⑴⑵⑶⑷⑸⑹⑺⑻⑼⑽⑾⑿⒀⒁⒂⒃⒄⒅⒆⒇①②③④⑤⑥⑦⑧⑨⑩㈠㈡㈢㈣㈤㈥㈦㈧㈨㈩";
fuhao[4] = "￥￠￡℅℉㎡℃♂♀°′″¤‰§№☆★○●◎◇◆□■△▲▼▽◢◣◤◥※→←↑↓↖↗↘↙〓＿￣―☉⊕〒";
fuhao[5] = "─━│┃┄┅┆┇┈┉┊┋┌┍┎┏┐┑┒┓└┕┖┗┘┙┚┛├┝┞┟┠┡┢┣┤┥┦┧┨┩┪┫┬┭┮┯┰┱┲┳┴┵┶┷┸┹┺┻┼┽┾┿╀╁╂╃╄╅╆╇╈╉╊╋═║╒╓╔╕╖╗╘╙╚╛╜╝╞╟╠╡╢╣╤╥╦╧╨╩╪╫╬╭╮╯╰╱╲╳▁▂▃▄▅▆▇█▉▊▋▌▍▎▏▓▔▕";
fuhao[6] = "ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩαβγδεζηθικλμνξοπρστυφχψω";
fuhao[7] = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя";
fuhao[8] = "āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜü";
fuhao[9] = "ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦㄧㄨㄩ˙ˊˇˋ";
fuhao[10] = "ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをん";
fuhao[11] = "ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴヵヶ";

pattern.compile("[^a-z';]");

function key_press(e) {
	var key = e.which ? e.which : e.keyCode;
	var key_char = String.fromCharCode(key);
	if (browser == 'NS' || browser == 'OP') {
		if (cancel_key_event) {
			cancel_key_event = false;
			return false;
		}
	}
	
	if (e.ctrlKey) return true; 
	
	if (/[A-Z]/.test(key_char)) {
		if (document.form1.ch_en_switch[1].checked) {
			if (document.form1.full_shape.checked) {
				pos = key_EN.indexOf(key_char)
				insert_char(key_QUAN.substr(pos,1));
				return false;
			}
			return true;
		}
		else key_char = key_char.toLowerCase();
	}
	
	if (/[a-z';]/.test(key_char) && !right_arrow) {
		/*if (/[a-z]/.test(key_char) && getEl("iFrame").num != undefined) {
			if(key_en.indexOf(key_char) < getEl("iFrame").num) {
				insert_char(getEl("iFrame").words[key_en.indexOf(key_char)]);
				blank_page();
			}
			return false;
		}*/
		if (document.form1.ch_en_switch[1].checked) {
			if (document.form1.full_shape.checked) {
				pos = key_en.indexOf(key_char)
				insert_char(key_quan.substr(pos,1));
				return false;
			}
			return true;
		} else {
			if (code_field.length < code_len) {
				code_field += key_char;
				on_code_change(code_field);
			}
			return false;
		}
	}
	
	if (browser == 'NS' && (key == 47 || key == 63)) {
		if (document.form1.ch_en_switch[0].checked || document.form1.full_shape.checked) return false;
	}

	return true;
}


function key_down(e) {
	var key = e.which ? e.which : e.keyCode;
	if (key!=33 && key!=57383 && key!=34 && key!=57384) {
		//if (document.form1.select1.selectedIndex!=0 || document.form1.select2.selectedIndex!=0) {
		//	document.form1.select1.selectedIndex=0;
		//	document.form1.select2.selectedIndex=0;
		//}
	}
	var key_char = String.fromCharCode(key);
	ctrl_keydown = false;
	switch (key) {
		// Backspace
		case 8:
			if (code_field != "") {
				var str = code_field;
				code_field = str.substr(0, str.length-1);
				on_code_change(code_field);
				cancel_key_event = true;
				return false;
			}
			return true;
		// Tab
		case 9:
			insert_char('　');
			cancel_key_event = true;
			return false; 
		// Esc
		case 27:
			clear_all();
			cancel_key_event = true;
			return false;
		// PageUp
		case 33:
		case 57383:
			if (code_field != "") {
				if(start_stack.length > 1) {
					start_stack.pop();	index_stack.pop();
					create_word_list(start_stack[start_stack.length-1], index_stack[index_stack.length-1], code_field);
				}
				cancel_key_event = true;
				return false;
			}
/*			else if (getEl("iFrame").num != undefined) {
				if (getEl("iFrame").start > 0) {
					last_page();
					cancel_key_event = true;
					return false;
				}
			}*/
			return true;
		// PageDown
		case 34:
		case 57384:
			if (code_field != "") {
				if (start_mem != -1) {
					start_stack.push(start_mem);
					index_stack.push(index_mem);
					for(i=0; i<=9; i++) {
						word_list[i] = "";
					}
					create_word_list(start_mem, index_mem, code_field);
				}
				cancel_key_event = true;
				return false;
			}
			/*else if (getEl("iFrame").num != undefined) {
				if ((getEl("iFrame").shurufa=='bihua' && getEl("iFrame").num>100) || (getEl("iFrame").shurufa!='bihua' && getEl("iFrame").num>36)) {
					next_page();
					cancel_key_event = true;
					return false;
				}
			}*/
			return true;
		// Space
		case 32:
			if (code_field != "") {
				insert_char(word_list[0]);
				code_field = "";
				document.getElementById("code_field").innerHTML = "　";
				candidates = "";
				document.getElementById("list_area").innerHTML = "　";
				cancel_key_event = true;
				return false;
			} /*else if (getEl("iFrame").num != undefined) {
				insert_char(getEl("iFrame").words[0]);
				blank_page();
				cancel_key_event = true;
				return false;
			}*/
			return true;
		// Enter
		case 13:
			if (code_field!="") {
				//wait_message();
				//str = "getwords.php?shurufa="+shurufa+"&para2="+jianfan+"&para3="+code_field.toLowerCase()+"&start=0";
				//getEl("iFrame").location.replace(str);
				cancel_key_event = true;
				return false;
			}
			return true;
		// Ctrl
		case 17:
		case 57402:
			ctrl_keydown = true;
			break;
	}
	
	if (e.ctrlKey) return true;
	
	if (/\d/.test(key_char)) {
		if (e.shiftKey) {
			if (document.form1.full_shape.checked || document.form1.ch_en_switch[0].checked) {
				if (document.form1.ch_en_switch[0].checked && key_char=='4') insert_char('￥');
				else {
					pos = key_EN.indexOf(key_char);
					insert_char(key_QUAN.substr(pos,1));
				}
				cancel_key_event = true;
				return false;
			}
		} else {
			if (code_field == "") {
			/*	if (getEl("iFrame").num != undefined) {
					if(key_en.indexOf(key_char) < getEl("iFrame").num) {
						insert_char(getEl("iFrame").words[key_en.indexOf(key_char)]);
						blank_page();
					}
					cancel_key_event = true;
					return false;
				} else if (document.form1.full_shape.checked || document.form1.ch_en_switch[0].checked) {
					pos = key_EN.indexOf(key_char);
					insert_char(key_quan.substr(pos,1));
					cancel_key_event = true;
					return false;
				}*/
			} else {
				if (document.form1.ch_en_switch[0].checked) {
					insert_char(word_list[(9+parseInt(key_char))%10]);
					code_field = "";
					document.getElementById("code_field").innerHTML = "　";
					candidates = "";
					document.getElementById("list_area").innerHTML = "　";
					cancel_key_event = true;
					return false;
				}
			}
		}
		return true;
	}

	if (document.form1.full_shape.checked || document.form1.ch_en_switch[0].checked) {
//		if ((key>=186 && key<=192) || (key>=219 && key<=222) ) {
		if (key == 186 || (key>=188 && key<=192) || (key>=219 && key<=222) ) {
			if (key == 186) {
				if (document.form1.ch_en_switch[0].checked) {
					if (e.shiftKey) insert_char('：');
					else if (code_field == "") insert_char('；');
					else return true;
				} else {
					insert_char( e.shiftKey ? '：' : '；' );
				}
			}
//			else if (key == 187) insert_char( e.shiftKey ? '＋' : '＝' );
			else if (key == 188) insert_char( e.shiftKey ? ((document.form1.ch_en_switch[0].checked)? '《' :'＜') : '，' );
			else if (key == 189) insert_char( e.shiftKey ? '＿' : '－' );
			else if (key == 190) insert_char( e.shiftKey ? ((document.form1.ch_en_switch[0].checked)? '》' :'＞') : (document.form1.ch_en_switch[0].checked)? '。' :'．');
			else if (key == 191) insert_char( e.shiftKey ? '？' : '／' );
			else if (key == 192) insert_char( e.shiftKey ? '～' : '｀' );
			else if (key == 219) insert_char( e.shiftKey ? '｛' : '［' );
			else if (key == 220) insert_char( e.shiftKey ? '｜' : (document.form1.ch_en_switch[0].checked)? '、' :'＼');
			else if (key == 221) insert_char( e.shiftKey ? '｝' : '］' );
			else {
				if (document.form1.ch_en_switch[0].checked) {
					if (e.shiftKey) insert_char( (left_yinhao2 = !left_yinhao2) ? '“' : '”' );
					else if (code_field == "") insert_char( (left_yinhao1 = !left_yinhao1) ? '‘' : '’' );
					else return true;
				} else {
					insert_char( e.shiftKey ? '＂' : '＇' );
				}
			}
			cancel_key_event = true;
			return false;
		}
		if (document.form1.ch_en_switch[1].checked && key == 187) {
			insert_char( e.shiftKey ? '＋' : '＝' );
			cancel_key_event = true;
			return false;
		}
	}    
	
	if (browser == 'NS') {
		if (document.form1.full_shape.checked || document.form1.ch_en_switch[0].checked) {
			if (key == 59) {
				if (document.form1.ch_en_switch[0].checked) {
					if (e.shiftKey) insert_char('：');
					else if (code_field == "") insert_char('；');
					else return true;
				} else {
					insert_char( e.shiftKey ? '：' : '；' );
				}
				cancel_key_event = true;
				return false;
			}
			else if (key == 61) {
				if (document.form1.ch_en_switch[1].checked) {
					insert_char( e.shiftKey ? '＋' : '＝' );
					cancel_key_event = true;
					return false;
				}
			}
			else if (key == 109) {
				insert_char( e.shiftKey ? '＿' : '－' );
				cancel_key_event = true;
				return false;
			}
		}
	}

	right_arrow = (key == 39)? true : false;
	
	return(true);
}


function key_up(e) {
	var key = e.which ? e.which : e.keyCode;
	// Ctrl
	if (key == 17 || key == 57402) {
		if (ctrl_keydown == true) {
			if (document.form1.ch_en_switch[0].checked) {
				document.form1.ch_en_switch[1].checked = true;
				clear_all();
			}
			else document.form1.ch_en_switch[0].checked = true;
		}
	}
	return true;
}


function create_word_list(start, index, str) {
	var str_len = str.length;
	var cnt = 1;
	var same_code_words = code_table[start].replace(/[a-z';]+/, '').split(',');
	candidates = "";
	while (cnt <= 10) {
		candidates += (cnt % 10) + '.' + same_code_words[index] + ' ';
		word_list[cnt-1] = same_code_words[index];
		++index;
		if (index >= same_code_words.length) {
			index = 0;
			++start;
			if (start >= code_table.length || code_table[start].substr(0, str_len) != str) {
				start = -1;
				break;
			}
			same_code_words = code_table[start].replace(/[a-z';]+/, '').split(',');
		}
		++cnt;
	}
	if (start > 0) {
		if (start_stack.length > 1) {
			candidates += '<PgUp  PgDn>';
		} else {
			candidates += ' PgDn>';
		}
	} else if (start_stack.length > 1) {
		//for (i=cnt+1; i<=10; i++) document.form1.list_area.value += '\n';
		candidates += '<PgUp';
	} else {
		candidates += '';//FIXME';
	}
	start_mem = start;
	index_mem = index;
	document.getElementById("list_area").innerHTML = candidates + "　"; 
}


function insert_char(str) {
	if (str == "") return;
	if (document.form1.diji.checked) {
		if (/==/.test(document.form1.edit_area.value)) {
			document.form1.edit_area.value = document.form1.edit_area.value.replace(/==/, str+"==");	
		} else {
			document.form1.edit_area.value += str;
		}
	} else {
		switch (browser) {
			case 'IE':
				var r = document.selection.createRange();
				r.text=str;
				r.select();
				break;
			case 'NS':
				var obj = document.form1.edit_area;
				var selectionStart = obj.selectionStart;
				var selectionEnd = obj.selectionEnd;
				var oldScrollTop = obj.scrollTop;
				var oldScrollHeight = obj.scrollHeight;
				var oldLen = obj.value.length;
				
				obj.value = obj.value.substring(0, selectionStart) + str + obj.value.substring(selectionEnd);
				obj.selectionStart = obj.selectionEnd = selectionStart + str.length;
				if (obj.value.length == oldLen) {
					obj.scrollTop = obj.scrollHeight;
				} else if (obj.scrollHeight > oldScrollHeight) {
					obj.scrollTop = oldScrollTop + obj.scrollHeight - oldScrollHeight;
				} else {
					obj.scrollTop = oldScrollTop;
				}
				break;
			default:
				document.form1.edit_area.value += str;
		}
	}
}
