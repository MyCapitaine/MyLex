#
#
#
#
require "./RE.rb"
require "./DFAO.rb"

class Lex


	#road
	LoadRoad = "profile.l"

	def initialize
		@@trans = {}
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

		programInner += ""



	end
end

class UnknowSign
end
