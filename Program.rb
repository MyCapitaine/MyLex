#produce by lex

control

class A
end

class B
end

class Unknown
end

def control
	strings = nil
	File.open("./inStream", "r") { |file| 
		strings = file.read
	}

	tokens = []

	unrecognizing = 0
	recognizing = 1
	recognizeFail = 2
	pointStatus = unrecognizing
	strings.each { |char|
		case pointStatus
		when unrecognizing

		when recognizing

		when recognizeFail	

		else
		end

	}

	tokens.each { |token|
		print token.class, "\n"
	}
end



def status_0(char)
	case char
	when 'a'
		0
	when 'b'
		1
	else
		nil
	end
end

def status_1(char)
	case char
	when 
	when 
	end
		
end


