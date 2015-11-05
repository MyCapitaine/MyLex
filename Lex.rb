#
#
#
#
require "./RE.rb"

class Lex


	#road
	LoadRoad = "profile.l"

	def initialize
		load


	end

	private
	def load
		File.open(LoadRoad, "r") { |file|  
			instance_eval file.read
		}

		RE.new(@student).toNFA.toDFA.toDFAO
	end

end


