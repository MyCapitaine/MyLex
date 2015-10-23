#RE struct
#
#
require "./NFA.rb"

class RE 

	def initialize(value)
		@value = value
		count = 0
		@invalid = false
		value.each_char { |ch|
			if ch == '('
				count += 1
			elsif ch == ')'
				if (count -= 1) < 0
					@invalid = true
					break
				end
			end

		}
		@invalid = true if count != 0

	end

	def toNFA
		return nil if @invalid
		afterDot = addDots(@value)
		postfix = toPostfixExpression(afterDot)


	end

	private 
	#add outermost parentheses
	#add parentheses for * and +
	# (a|b)*a -> ((a|b)*a) -> (((a|b)*)a)
	def addParentheses(str)
		str = "(" + str + ")"




	end

	#add dots to connect the neighbor express
	#ab(ab)c -> a#b#(ab)#c
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

	#tranlate infix to postfix
	#a|b -> ab|
	def toPostfixExpression(infix)
		stack = []
		count = 0
		infix.each_char { |ch|
			if ch == ')'
				buffer = []
				c = ''
				while (c = stack.pop) != '('
					buffer << c
				end
				stack << combine(buffer.reverse)
			else
				stack << ch
			end

		}
		stack[0]

	end

	#combine infix sublist to a postfix element
	#["a", "|", "cd|*"] -> "acd|*|"
	def combine(subStack)
		# print subStack.to_s, "\n"
		stack = []
		subStack.each { |ele|
			case ele
			when '+', '*'
				stack.last << ele
			when '|', '#'
				stack << ele
			else 
				if stack.size < 2
					stack << ele 
				else
					sign = stack.pop
					arg1 = stack.pop
					arg2 = ele
					stack << (arg1 + arg2 + sign)
				end
			end

		}
		stack[0]
	end

end