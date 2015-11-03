#DFA struct
#
#
require "./NFA.rb"
require "set"
class DFA

    attr_reader :statusList
    #a status will be added into this list when its a final status
    attr_reader :finalStatusList

    def initialize(nfa) 
    	p nfa


    	statusList = []
    	finalStatusList = []

    	statusList << Status.new(Set.new((nfa.nodeList[nfa.begin]).upsilonRefList) << nfa.begin)

    	statusList.each { |status|
    		status.each { |node_num|


    		}	


    	}



    end

	def toDFAO
	end


end


=begin
status of DFA
=end
class Status
	attr_reader :nodeSet
	def initialize(nodeSet)
		@nodeSet = nodeSet
	end

end





