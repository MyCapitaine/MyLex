#produce by lex

class Student
end

class SingleAction
end

class FlexAction
end

class Unknown
end

def control
	strings = nil
	File.open("./inStream", "r") { |file| 
		strings = file.read
	}
	strings << "
"

	tokens = []
	unrecognizing = 0
	recognizing = 1
	recognizeFail = 2
	pointStatus = unrecognizing
	beginNum = 3
	nextStatus = beginNum
	strings.each_char { |char|
		case pointStatus
		when unrecognizing
			if char != " " && char != "\n"
				pointStatus = recognizing
				nextStatus = send("status_" + nextStatus.to_s, char)
				if nextStatus == nil
					nextStatus = beginNum
					pointStatus = recognizeFail
				end
			end
		when recognizing
			nextStatus = send("status_" + nextStatus.to_s, char)
			if nextStatus == nil #fail
				nextStatus = beginNum
				if char == " " || char == "\n"
					pointStatus = unrecognizing
				else
					pointStatus = recognizeFail
				end
			elsif nextStatus.is_a? Fixnum
				#do nothing
			else
				tokens << nextStatus
				pointStatus = unrecognizing
				nextStatus = beginNum
			end

		when recognizeFail	
			if char == " " || char == "\n"
				pointStatus = unrecognizing
				tokens << Unknown.new
			end
		else
		end

	}

	tokens.each { |token|
		print token.class, "\n"
	}
end

#finalStatus
def status_0(char)
	case char
	when ' ', "\n"
		Student.new

	else
		nil
	end	
end

#finalStatus
def status_1(char)
	case char
	when ' ', "\n"
		SingleAction.new

	else
		nil
	end	
end

#finalStatus
def status_2(char)
	case char
	when ' ', "\n"
		FlexAction.new

	else
		nil
	end	
end

#begin
def status_3(char)
	case char
	when '<'
		4
	when 'K'
		5
	when 'k'
		5
	when 'S'
		6
	when 's'
		6
	when 'W'
		7
	when 'w'
		7
	when 'R'
		8
	when 'r'
		8
	else
		nil
	end	
end

def status_4(char)
	case char
	when 's'
		9
	else
		nil
	end	
end

def status_5(char)
	case char
	when 'I'
		10
	when 'i'
		10
	else
		nil
	end	
end

def status_6(char)
	case char
	when 'M'
		11
	when 'm'
		11
	when 'L'
		12
	when 'l'
		12
	else
		nil
	end	
end

def status_7(char)
	case char
	when 'A'
		13
	when 'a'
		13
	else
		nil
	end	
end

def status_8(char)
	case char
	when 'U'
		14
	when 'u'
		14
	else
		nil
	end	
end

def status_9(char)
	case char
	when 't'
		15
	else
		nil
	end	
end

def status_10(char)
	case char
	when 'S'
		16
	when 's'
		16
	when 'C'
		17
	when 'c'
		17
	else
		nil
	end	
end

def status_11(char)
	case char
	when 'I'
		18
	when 'i'
		18
	else
		nil
	end	
end

def status_12(char)
	case char
	when 'A'
		19
	when 'a'
		19
	else
		nil
	end	
end

def status_13(char)
	case char
	when 'L'
		20
	when 'l'
		20
	else
		nil
	end	
end

def status_14(char)
	case char
	when 'N'
		21
	when 'n'
		21
	else
		nil
	end	
end

def status_15(char)
	case char
	when 'u'
		22
	else
		nil
	end	
end

def status_16(char)
	case char
	when 'S'
		23
	when 's'
		23
	else
		nil
	end	
end

def status_17(char)
	case char
	when 'K'
		24
	when 'k'
		24
	else
		nil
	end	
end

def status_18(char)
	case char
	when 'L'
		25
	when 'l'
		25
	else
		nil
	end	
end

def status_19(char)
	case char
	when 'P'
		26
	when 'p'
		26
	else
		nil
	end	
end

def status_20(char)
	case char
	when 'K'
		27
	when 'k'
		27
	else
		nil
	end	
end

def status_21(char)
	case char
	when 'S'
		1
	when 's'
		1
	else
		nil
	end	
end

def status_22(char)
	case char
	when 'd'
		28
	else
		nil
	end	
end

def status_23(char)
	case char
	when 'E'
		29
	when 'e'
		29
	else
		nil
	end	
end

def status_24(char)
	case char
	when 'S'
		2
	when 's'
		2
	else
		nil
	end	
end

def status_25(char)
	case char
	when 'E'
		30
	when 'e'
		30
	else
		nil
	end	
end

def status_26(char)
	case char
	when 'S'
		2
	when 's'
		2
	else
		nil
	end	
end

def status_27(char)
	case char
	when 'S'
		1
	when 's'
		1
	else
		nil
	end	
end

def status_28(char)
	case char
	when 'e'
		31
	else
		nil
	end	
end

def status_29(char)
	case char
	when 'S'
		2
	when 's'
		2
	else
		nil
	end	
end

def status_30(char)
	case char
	when 'S'
		1
	when 's'
		1
	else
		nil
	end	
end

def status_31(char)
	case char
	when 'n'
		32
	else
		nil
	end	
end

def status_32(char)
	case char
	when 't'
		33
	else
		nil
	end	
end

def status_33(char)
	case char
	when ' '
		34
	else
		nil
	end	
end

def status_34(char)
	case char
	when 'n'
		35
	else
		nil
	end	
end

def status_35(char)
	case char
	when 'a'
		36
	else
		nil
	end	
end

def status_36(char)
	case char
	when 'm'
		37
	else
		nil
	end	
end

def status_37(char)
	case char
	when 'e'
		38
	else
		nil
	end	
end

def status_38(char)
	case char
	when '='
		39
	else
		nil
	end	
end

def status_39(char)
	case char
	when 'Z'
		40
	when 'Y'
		40
	when 'X'
		40
	when 'W'
		40
	when 'V'
		40
	when 'U'
		40
	when 'T'
		40
	when 'S'
		40
	when 'R'
		40
	when 'Q'
		40
	when 'P'
		40
	when 'O'
		40
	when 'N'
		40
	when 'M'
		40
	when 'L'
		40
	when 'K'
		40
	when 'J'
		40
	when 'I'
		40
	when 'H'
		40
	when 'F'
		40
	when 'E'
		40
	when 'D'
		40
	when 'C'
		40
	when 'B'
		40
	when 'A'
		40
	else
		nil
	end	
end

def status_40(char)
	case char
	when 'z'
		41
	when 'y'
		41
	when 'x'
		41
	when 'w'
		41
	when 'v'
		41
	when 'u'
		41
	when 't'
		41
	when 's'
		41
	when 'r'
		41
	when 'q'
		41
	when 'p'
		41
	when 'o'
		41
	when 'n'
		41
	when 'm'
		41
	when 'l'
		41
	when 'k'
		41
	when 'j'
		41
	when 'i'
		41
	when 'h'
		41
	when 'g'
		41
	when 'f'
		41
	when 'e'
		41
	when 'd'
		41
	when 'c'
		41
	when 'b'
		41
	when 'a'
		41
	else
		nil
	end	
end

def status_41(char)
	case char
	when 'z'
		41
	when 'y'
		41
	when ' '
		42
	when 'x'
		41
	when 'w'
		41
	when 'v'
		41
	when 'u'
		41
	when 't'
		41
	when 's'
		41
	when 'r'
		41
	when 'q'
		41
	when 'p'
		41
	when 'o'
		41
	when 'n'
		41
	when 'm'
		41
	when 'l'
		41
	when 'k'
		41
	when 'j'
		41
	when 'i'
		41
	when 'h'
		41
	when 'g'
		41
	when 'f'
		41
	when 'e'
		41
	when 'd'
		41
	when 'c'
		41
	when 'b'
		41
	when 'a'
		41
	else
		nil
	end	
end

def status_42(char)
	case char
	when 'i'
		43
	when 'Z'
		44
	when 'Y'
		44
	when 'X'
		44
	when 'W'
		44
	when 'V'
		44
	when 'U'
		44
	when 'T'
		44
	when 'S'
		44
	when 'R'
		44
	when 'Q'
		44
	when 'P'
		44
	when 'O'
		44
	when 'N'
		44
	when 'M'
		44
	when 'L'
		44
	when 'K'
		44
	when 'J'
		44
	when 'I'
		44
	when 'H'
		44
	when 'F'
		44
	when 'E'
		44
	when 'D'
		44
	when 'C'
		44
	when 'B'
		44
	when 'A'
		44
	else
		nil
	end	
end

def status_43(char)
	case char
	when 'd'
		45
	else
		nil
	end	
end

def status_44(char)
	case char
	when 'z'
		46
	when 'y'
		46
	when 'x'
		46
	when 'w'
		46
	when 'v'
		46
	when 'u'
		46
	when 't'
		46
	when 's'
		46
	when 'r'
		46
	when 'q'
		46
	when 'p'
		46
	when 'o'
		46
	when 'n'
		46
	when 'm'
		46
	when 'l'
		46
	when 'k'
		46
	when 'j'
		46
	when 'i'
		46
	when 'h'
		46
	when 'g'
		46
	when 'f'
		46
	when 'e'
		46
	when 'd'
		46
	when 'c'
		46
	when 'b'
		46
	when 'a'
		46
	else
		nil
	end	
end

def status_45(char)
	case char
	when '='
		47
	else
		nil
	end	
end

def status_46(char)
	case char
	when 'z'
		46
	when ' '
		42
	when 'y'
		46
	when 'x'
		46
	when 'w'
		46
	when 'v'
		46
	when 'u'
		46
	when 't'
		46
	when 's'
		46
	when 'r'
		46
	when 'q'
		46
	when 'p'
		46
	when 'o'
		46
	when 'n'
		46
	when 'm'
		46
	when 'l'
		46
	when 'k'
		46
	when 'j'
		46
	when 'i'
		46
	when 'h'
		46
	when 'g'
		46
	when 'f'
		46
	when 'e'
		46
	when 'd'
		46
	when 'c'
		46
	when 'b'
		46
	when 'a'
		46
	else
		nil
	end	
end

def status_47(char)
	case char
	when '9'
		48
	when '8'
		48
	when '7'
		48
	when '6'
		48
	when '5'
		48
	when '4'
		48
	when '3'
		48
	when '2'
		48
	when '1'
		48
	when '0'
		48
	else
		nil
	end	
end

def status_48(char)
	case char
	when '9'
		49
	when '8'
		49
	when '7'
		49
	when '6'
		49
	when '5'
		49
	when '4'
		49
	when '3'
		49
	when '2'
		49
	when '1'
		49
	when '0'
		49
	else
		nil
	end	
end

def status_49(char)
	case char
	when '9'
		50
	when '8'
		50
	when '7'
		50
	when '6'
		50
	when '5'
		50
	when '4'
		50
	when '3'
		50
	when '2'
		50
	when '1'
		50
	when '0'
		50
	else
		nil
	end	
end

def status_50(char)
	case char
	when '9'
		51
	when '8'
		51
	when '7'
		51
	when '6'
		51
	when '5'
		51
	when '4'
		51
	when '3'
		51
	when '2'
		51
	when '1'
		51
	when '0'
		51
	else
		nil
	end	
end

def status_51(char)
	case char
	when '9'
		52
	when '8'
		52
	when '7'
		52
	when '6'
		52
	when '5'
		52
	when '4'
		52
	when '3'
		52
	when '2'
		52
	when '1'
		52
	when '0'
		52
	else
		nil
	end	
end

def status_52(char)
	case char
	when '9'
		53
	when '8'
		53
	when '7'
		53
	when '6'
		53
	when '5'
		53
	when '4'
		53
	when '3'
		53
	when '2'
		53
	when '1'
		53
	when '0'
		53
	else
		nil
	end	
end

def status_53(char)
	case char
	when '9'
		54
	when '8'
		54
	when '7'
		54
	when '6'
		54
	when '5'
		54
	when '4'
		54
	when '3'
		54
	when '2'
		54
	when '1'
		54
	when '0'
		54
	else
		nil
	end	
end

def status_54(char)
	case char
	when '9'
		55
	when '8'
		55
	when '7'
		55
	when '6'
		55
	when '5'
		55
	when '4'
		55
	when '3'
		55
	when '2'
		55
	when '1'
		55
	when '0'
		55
	else
		nil
	end	
end

def status_55(char)
	case char
	when '9'
		56
	when '8'
		56
	when '7'
		56
	when '6'
		56
	when '5'
		56
	when '4'
		56
	when '3'
		56
	when '2'
		56
	when '1'
		56
	when '0'
		56
	else
		nil
	end	
end

def status_56(char)
	case char
	when '/'
		57
	else
		nil
	end	
end

def status_57(char)
	case char
	when '>'
		0
	else
		nil
	end	
end

control
