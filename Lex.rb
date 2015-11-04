#
#
#
#
require "./RE.rb"

class Lex


	#road
	LoadRoad = "profile.l"

	#words
	Declaration = "declaration"
	TranslationRules = "translation rules"
	AuxiliaryProcedures = "auxiliary procedures"

	def initialize
		load


	end

	private
	def load
		File.open(LoadRoad, "r") { |file|  
			instance_eval file.read
		}

		RE.new(@student).toNFA.toDFA
	end

end


