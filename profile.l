

#auxiliary procedures
	def createMC(mcs)
		mcs.each {|mcName|
			eval("class #{mcName} \nend")
		}
	end




#declaration
	createMC ["Student", "StudentID", "StudentName"]



	@digit = "(0|1|2|3|4|5|6|7|8|9)"
	@lowLetter = "(a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z)"
	@hightLetter = "(A|B|C|D|E|F|Z|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z)"
	@letter = "(#{@lowLetter}|#{@hightLetter})"
	@studentId = "(#{@digit}#{@digit}#{@digit}#{@digit}#{@digit}#{@digit}#{@digit}#{@digit}#{@digit})"
	@name = "(#{@hightLetter}#{@lowLetter}+(#{@hightLetter}#{@lowLetter}+)*)"
	@student = "((<student name=)#{@name}( id=)#{@studentId}(\/>))"



#translation rules




	


