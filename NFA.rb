#NFA struct
#
#it only works when use right posfixExpression, obviously)
require "./DFA.rb"
class NFA
    #each nodes will be sign up and save in this list
    attr_reader :nodeList
    #num of begin node
    attr_reader :begin
    #num of end nodes
    #includes the function from ending to num
    attr_reader :end
	def initialize(postfix)
		#print postfix, "\n"
        @end = []
		@nodeList = []
        nodeSetStack = []
        postfix.each_char { |ch|
            case ch
            when '+'
                #not support now
            when '*'
                oldNodeSet = nodeSetStack.pop
                
                newTail = Node.new([], nil, nil)
                @nodeList << newTail
                newTailNum = @nodeList.size - 1
                newHead = Node.new([oldNodeSet.headNum, newTailNum], nil, nil)
                @nodeList << newHead
                newHeadNum = @nodeList.size - 1
                
                @nodeList[oldNodeSet.tailNum].upsilonRefList << oldNodeSet.headNum << newTailNum
                
                nodeSetStack << NodeSet.new(newHeadNum, newTailNum)
                
            when '|'
                nodeSet1 = nodeSetStack.pop
                nodeSet2 = nodeSetStack.pop
                
                newHead = Node.new([nodeSet1.headNum, nodeSet2.headNum], nil, nil)
                @nodeList << newHead
                newHeadNum = @nodeList.size - 1
                newTail = Node.new([], nil, nil)
                @nodeList << newTail
                newTailNum = @nodeList.size - 1
                
                @nodeList[nodeSet1.tailNum].upsilonRefList << newTailNum
                @nodeList[nodeSet2.tailNum].upsilonRefList << newTailNum
                newNodeSet = NodeSet.new(newHeadNum, newTailNum)
                nodeSetStack << newNodeSet
                
            when ';'
                nodeSet2 = nodeSetStack.pop
                nodeSet1 = nodeSetStack.pop

                newHead = Node.new([nodeSet1.headNum, nodeSet2.headNum], nil, nil)
                @nodeList << newHead
                newHeadNum = @nodeList.size - 1

                @end << nodeSet1.tailNum if nodeSet1.tailNum != nil
                @end << nodeSet2.tailNum if nodeSet2.tailNum != nil

                newNodeSet = NodeSet.new(newHeadNum, nil)
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
                tailNum = @nodeList.size - 1
                head = Node.new([], ch, tailNum)
                @nodeList << head
                headNum = @nodeList.size - 1
                nodeSetStack << NodeSet.new(headNum, tailNum)
                
            end
        }
        @end << nodeSetStack[0].tailNum if @end.empty?
        @begin = nodeSetStack[0].headNum
        
	end


	def toDFA
        DFA.new(self)
	end
    
    
    
end


=begin
strcut of NFA nodes
save references of nodes
=end
class Node
    #save the number of *one step* upsilon references 
    attr_accessor :upsilonRefList
    #save the key ref and value/number of ref 
    #have no refKey&refValue when refKey = nil
    attr_reader :refKey, :refValue
    def initialize(upsilonRefList, refKey, refValue)
        @upsilonRefList = upsilonRefList
        @refKey = refKey
        @refValue = refValue
    end
    
    def ref(key) 
        return @refValue if key == @refKey
        return nil
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


