#
#
#
#
#
require "./Lex.rb"
require "./RE.rb"

# lex = Lex.new


print RE.new("((a|b)*(a|b))*(a|b)*(a|b)").toNFA, "\n"
print RE.new("((((a|b)*)(a|b))*)((a|b)*)(a|b)").toNFA, "\n"
