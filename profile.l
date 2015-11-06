

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

	run = "(r|Ru|Un|Ns|S)"
	walk = "(w|Wa|Al|Lk|Ks|S)"
	smile = "(s|Sm|Mi|Il|Le|Es|S)"
	@singleAction = "#{run}|#{walk}|#{smile}"

	kick = "(k|Ki|Ic|Ck|Ks|S)"
	slap = "(s|Sl|La|Ap|Ps|S)"
	kiss = "(k|Si|Is|Ss|Se|Es|S)"
	@flexAction = "#{kick}|#{slap}|#{kiss}"



#translation rules
	def student=
		Student.new
	end

	def singleAction=
		SingleAction.new
	end

	def flexAction=
		FlexAction.new
	end
	


