#DFA struct
#
#
require "./NFA.rb"
require "./DFAO.rb"
require "set"
class DFA

    attr_reader :statusList, :finalNumSet
    attr_reader :nfa

    def initialize(nfa) 
        @nfa = nfa
    	# p nfa


    	@statusList = []
    	@finalNumSet = Set.new

        #origin status
    	statusList << Status.new(searchStatusSet(Set.new([nfa.begin])))

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

        statusNum = 0;
        statusList.each { |status|
            finalNumSet << statusNum if status.nodeSet.include? nfa.end
            statusNum += 1
        }

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
	def initialize(nodeSet)
		@nodeSet = nodeSet
        @hashList = {}
	end

end





