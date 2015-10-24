#NFA struct
#
#it only works when use right posfixExpression, obviously)
class NFA
    #each nodes will be sign up and save in this list 
    attr_reader :nodeList
    #num of begin and end node
    attr_reader :begin, :end
	def initialize(postfix)
		print postfix, "\n"
		@nodeList = []
        
        nodeSetStack = []
        
        posfix.each_char { |ch|
            case ch
            when '+', '*'
                
            when '|', '#'
                
            else
                
            end
        }
        

	end





	def toDFA
	end
    
end


=begin
strcut of NFA nodes
save references of nodes
=end
class Node
    #save the number of upsilon references 
    attr_accessor :upsilonRefList
    #save the key ref and value/number of ref 
    #have no refKey&refValue when refKey = nil
    attr_reader :refKey, :refValue
    def initialize(upsilonRefList = [], refKey = nil, refValue = nil)
        @upsilonRefList = upsilonRefList
        @refKey = refKey
        @refValue = refValue
    end
    
    
end

=begin
struct of nodeSet
save num of head and tail node
=end
class NodeSet
    attr_reader :head, :tail
    def initialize(head, tail)
        @head = head
        @tail = tail
    end
end


