#
#
#
#
require "./RE.rb"
require "./DFAO.rb"

class Lex


	#road
	LoadRoad = "profile.l"
	ProgramRoad = "Program.rb"

	def initialize
		@@trans = {}
		@@mc = []
		File.open(LoadRoad, "r") { |file|  
			instance_eval file.read
		}

		@res = self.instance_variables
		aboveRE = ""
		@res.each { |re|
			aboveRE += ("(" + self.instance_variable_get(re) + ");")
		}
		aboveRE[aboveRE.size - 1] = ""

		dfao = RE.new(aboveRE).toNFA.toDFA.toDFAO
		toProgram dfao
	end

	def toProgram(dfao)
		programInner = "#produce by lex\n\n"
		#def classes
		@@mc << "Unknown"
		@@mc.each { |tokenName|
			programInner += ("class " + tokenName + "\n")
			programInner += ("end\n\n")
		}




		#def control method
		controlMethod = <<EOF
def control
	strings = nil
	File.open("./inStream", "r") { |file| 
		strings = file.read
	}
	strings << "\n"

	tokens = []
	unrecognizing = 0
	recognizing = 1
	recognizeFail = 2
	pointStatus = unrecognizing
	beginNum = #{dfao.begin}
	nextStatus = beginNum
	strings.each_char { |char|
		case pointStatus
		when unrecognizing
			if char != " " && char != "\\n"
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
				if char == " " || char == "\\n"
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
			if char == " " || char == "\\n"
				pointStatus = unrecognizing
				tokens << Unknown.new
			end
		else
		end

	}

	tokens.each { |token|
		print token.class, "\\n"
	}
end

EOF
	programInner += controlMethod


	#def status methods
	finalCount = 0
	dfao.finalOstatusNumList.each { |finalNum|
		head = <<EOF
#finalStatus
def status_#{finalNum}(char)
	case char
EOF
		programInner += head
		dfao.ostatusList[finalNum].hashList.each { |key, value|
			#protected conflict situation
			next if key == ' ' || key == "\n"
			programInner += "	when '#{key}'\n"
			programInner += "		#{value}\n"
		}
		programInner += ("	when ' ', " + '"' + "\\n" + '"' + "\n")
		programInner += (@@trans[@res[finalCount]] + "\n")
		tail = <<EOF
	else
		nil
	end	
end

EOF
		programInner += tail
		finalCount += 1
	}


	count = 0
	dfao.ostatusList.each { |ostatus|
		if ostatus.isEndStatus
			count += 1
			next
		end
		programInner += "#begin\n" if count == dfao.begin
		head = <<EOF
def status_#{count}(char)
	case char
EOF
		programInner += head
		ostatus.hashList.each { |key, value|
			programInner += "	when '#{key}'\n"
			programInner += "		#{value}\n"
		}
		tail = <<EOF
	else
		nil
	end	
end

EOF
		programInner += tail
		count += 1
	}

	#use control method
	programInner += "control\n"

	#write program
	File.open(ProgramRoad, "w") { |file|  
		file.write programInner
	}


	end
end
