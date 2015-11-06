

#auxiliary procedures
	def MC(mcs)
		mcs.each {|mcName|
			eval("class #{mcName} \nend")
		}
	end




#declaration
	MC ["Student", "SingleAction", "FlexAction"]

	digit = "(0|1|2|3|4|5|6|7|8|9)"
	lowLetter = "(a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z)"
	highLetter = "(A|B|C|D|E|F|Z|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z)"
	letter = "(#{lowLetter}|#{highLetter})"
	studentId = "(#{digit}#{digit}#{digit}#{digit}#{digit}#{digit}#{digit}#{digit}#{digit})"
	name = "(#{highLetter}#{lowLetter}#{lowLetter}*( #{highLetter}#{lowLetter}#{lowLetter}*)*)"
	@student = "((<student name=)#{name}( id=)#{studentId}(\/>))"

	run = "((r|R)(u|U)(n|N)(s|S))"
	walk = "((w|W)(a|A)(l|L)(k|K)(s|S))"
	smile = "((s|S)(m|M)(i|I)(l|L)(e|E)(s|S))"
	@singleAction = "#{run}|#{walk}|#{smile}"

	kick = "((k|K)(i|I)(c|C)(k|K)(s|S))"
	slap = "((s|S)(l|L)(a|A)(p|P)(s|S))"
	kiss = "((k|K)(i|I)(s|S)(s|S)(e|E)(s|S))"
	@flexAction = "#{kick}|#{slap}|#{kiss}"



#translation rules
	@@trans[:@student] = Proc.new{
		Student.new
	}
	@@trans[:@singleAction] = Proc.new{
		SingleAction.new
	}
	@@trans[:@flexAction] = Proc.new{
		FlexAction.new
	}


