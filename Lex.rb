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
		load
		

	end

	private
	def load
		File.open(LoadRoad, "r") { |file|  
			instance_eval file.read
		}

		REs = self.instance_variables


		# RE.new(@student).toNFA.toDFA.toDFAO
		# print self.methods
		# print self.instance_variables[0]
		print self.singleton_methods
	end

	def toProgram(dfao)
		


		
	end
end


