#RE struct
#
#
require "./NFA.rb"

class RE 

	def initialize(value)
		@value = value
	end

	def toNFA
		afterDot = addDots(@value)
		post = toPostExpres(afterDot)


	end

	private 
	def addDots(beforeDot)
		afterDot = ""
		approachLast = false

		beforeDot.each_char { |ch|
			if approachLast
				case ch
				when '|' 
					approachLast = false
				when '*', '+', ')' 
				when '(' 
					afterDot << '#'
					approachLast = false
				else 
					afterDot << '#'
				end

			else
				case ch
				when '(', '+', '*', '|'
				else
					approachLast = true
				end
			end

			afterDot << ch
		}
		afterDot
	end


	def toPostExpres(pre)
		stack = []
		count = 0
		pre.each_char { |ch|
			if ch == ')'
				buffer = ''
				c = ''
				while (c = stack.pop) != '('
					buffer << c
				end
				stack << combine(buffer)
			else
				stack << ch
			end

		}
		# print stack.methods
		stack.to_s
	end

	def combine(express)
		stack = []
		express.each_char { |ch|
			case ch
			when '+', '*'
				stack.last << ch
			when '|', '#'
				stack << ch
			else 
				if stack.size < 2
					stack << ch 
				else

					while!!!!!!!!!!!!!!!!!!!!!!
					sign = stack.pop
					arg1 = stack.pop
					arg2 = ch
					stack << (arg1 + arg2 + sign)
				end
			end

		}
		print stack.to_s, "\n"
		stack[0]
	end

end