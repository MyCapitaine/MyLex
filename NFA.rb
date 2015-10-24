#NFA struct
#
#it only works when use right posfixExpression, obviously)
class NFA
    #each nodes will be sign up and save in this list
    attr_reader :nodeList
    #num of begin and end node
    attr_reader :begin, :end
	def initialize(postfix)
		#print postfix, "\n"
        
		@nodeList = []
        nodeSetStack = []
        posfix.each_char { |ch|
            case ch
            when '+'
                #not support now
            when '*'
                oldNodeSet = nodeSetStack.pop
                
                newTail = Node.new([], nil, nil)
                @nodeList << newTail
                newTailNum = @nodeList.size
                newHead = Node.new([oldNodeSet.headNum, newTailNum], nil. nil)
                @nodeList << newHead
                newHeadNum = @nodeList.size
                
                @nodeList[oldNodeSet.tailNum].upsilonRefList << oldNodeSet.headNum << newTailNum
                
                nodeSetStack << NodeSet.new(newHeadNum, newTailNum)
                
            when '|'
                nodeSet1 = nodeSetStack.pop
                nodeSet2 = nodeSetStack.pop
                
                newHead = Node.new([nodeSet1.headNum, nodeSet2.headNum], nil, nil)
                @nodeList << newHead
                newHeadNum = @nodeList.size
                newTail = Node.new([], nil, nil)
                @nodeList << newTail
                newTailNum = @nodeList.size
                
                @nodeList[nodeSet1.tailNum].upsilonRefList << newTailNum
                @nodeList[nodeSet2.tailNum].upsilonRefList << newTailNum
                newNodeSet = NodeSet.new(newHeadNum, newTailNum)
                nodeSetStack << newNodeSet
                
            when '#'
                nodeSetPost = nodeSetStack.pop
                nodeSetPre = nodeSetStack.pop
                @nodeList[nodeSetPre.tailNum].upsilonRefList << nodeSetPost.headNum
                
                newNodeSet = NodeSet.new(nodeSetPre.headNum, nodeSetPost.tailNum)
                nodeSetStack << newNodeSet
                
            else
                tail = Node.new([], nil, nil)
                @nodeList << tail
                tailNum = @nodeList.size
                head = Node.new([], ch, tailNum)
                @nodeList << head
                headNum = @nodeList.size
                nodeSetStack << NodeSet.new(headNum, tailNum)
                
            end
        }
        
        @begin = nodeSetStack[0].headNum
        @end = nodeSetStack[0].tailNum
        
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
    def initialize(upsilonRefList, refKey, refValue)
        @upsilonRefList = upsilonRefList == nil? [] : upsilonRefList
        @refKey = refKey
        @refValue = refValue
    end
    
    
end

=begin
struct of nodeSet
save num of head and tail node
=end
class NodeSet
    attr_reader :headNum, :tailNum
    def initialize(headNum, tailNum)
        @headNum = headNum
        @tailNum = tailNum
    end
end


