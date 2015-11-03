#
#
#
#
#
require "./Lex.rb"
require "./RE.rb"

# lex = Lex.new


RE.new("((a|b)*(a|b))*(a|b)*(a|b)").toNFA.toDFA

