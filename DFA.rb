#DFA struct
#
#
require "./NFA.rb"
require "./DFAO.rb"
require "set"
class DFA

    attr_reader :statusList, :finalNumList
    attr_reader :begin
    attr_reader :nfa

    #the first status in the list is the begin

    def initialize(nfa) 
        @nfa = nfa
    	# p nfa


    	@statusList = []
    	@finalNumList = []

        #origin status
    	statusList << Status.new(searchStatusSet(Set.new([nfa.begin])))
        @begin = statusList.size - 1

    	statusList.each { |status|
            signSet = Set.new
    		status.nodeSet.each { |node_num|
                signSet << nfa.nodeList[node_num].refKey if nfa.nodeList[node_num].refKey != nil
    		}	
            next if signSet.empty?
            signSet.each { |sign|
                newStatusSet = Set.new
                status.nodeSet.each { |n|
                    newStatusSet << nfa.nodeList[n].ref(sign) if nfa.nodeList[n].ref(sign) != nil

                }
                newStatusSet = searchStatusSet newStatusSet
                repeat = false
                statusCount = 0
                statusList.each { |s|
                    if s.nodeSet == newStatusSet
                        repeat = true
                        break
                    end
                    statusCount += 1
                }

                if !repeat
                    statusList << Status.new(newStatusSet)
                    status.hashList[sign] = statusList.size - 1
                else
                    status.hashList[sign] = statusCount
                end
            }



    	}
        statusNum = 0
        statusList.each { |status|
            endCount = 0
            nfa.end.each { |endNum|
                if status.nodeSet.include? endNum
                    status.isEndStatus = true
                    if finalNumList[endCount] == nil
                        finalNumList[endCount] = [statusNum]
                    else
                        finalNumList[endCount] << statusNum
                    end
                    break
                end    
                endCount += 1
            }
            statusNum += 1
        }
        # p finalNumList
        # p statusList
        # p statusList.size
    end

	def toDFAO
        DFAO.new(self)
	end


    private 
    def searchStatusSet(originSet)
        array = originSet.to_a
        array.each { |num|
            @nfa.nodeList[num].upsilonRefList.each { |upsi|
                array << upsi unless array.include? upsi
            }

        }

        array.to_set

    end

end


=begin
status of DFA
=end
class Status
	attr_reader :nodeSet, :hashList
    attr_accessor :isEndStatus
	def initialize(nodeSet)
		@nodeSet = nodeSet
        @hashList = {}
        @isEndStatus = false
	end

end





