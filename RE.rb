#RE struct
#
#
require "./NFA.rb"

class RE 
	public
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
		#regard weather |'('| <> |')'|
		return nil if @invalid
		afterParentheses = addParentheses(@value)
		afterDot = addDots(afterParentheses)
		postfix = toPostfixExpression(afterDot)
		
		NFA.new(postfix)
	end

	private
=begin	 
	add outermost parentheses
	add parentheses for * and +
	(a|b)*a -> ((a|b)*a) -> (((a|b)*)a)
=end
	def addParentheses(str)
		indexes = []
		count = -2
		str.each_char { |ch|
			indexes << (count += 2) if ch == '+' || ch == '*'
			count += 1
		}

		indexes.each { |index|
			str[index] = str[index] + ')'

			if str[index - 1] == ')'
				parenthesesCount = 0

				(1..index).each_with_index { |i|
					i = index - i
					if str[i] == ')'
						parenthesesCount += 1
					elsif str[i] == '('
						parenthesesCount -= 1
						if parenthesesCount == 0
							str[i] = '(('
							break 
						end
					end

				}
			else 
				str[index - 1] = '(' + str[index - 1]
			end
		}


		str = "(" + str + ")"
		
	end

=begin
	add dots to connect the neighbor express
	ab(ab)c -> a#b#(ab)#c
=end
	def addDots(beforeDot)
		afterDot = ""
		approachLast = false

		beforeDot.each_char { |ch|
			if approachLast
				case ch
				when '|', ';'
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
				when '(', '+', '*', '|', ';'
				else
					approachLast = true
				end
			end

			afterDot << ch
		}
		# print afterDot
		afterDot
	end


=begin
	tranlate infix to postfix
	a|b -> ab|
=end
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

=begin
	combine infix sublist to a postfix element
	["a", "|", "cd|*"] -> "acd|*|"
=end	
	def combine(subStack)
		stack = []
		subStack.each { |ele|
			case ele
			when '+', '*'
				stack.last << ele
			when '|', '#', ';'
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