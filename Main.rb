#
#
#
#
#
require "./Lex.rb"
require "./RE.rb"

# lex = Lex.new


print RE.new("(((ac(a)da)|b)*(a|b))*(a|b)*(a|b)").toNFA
print "\n"

