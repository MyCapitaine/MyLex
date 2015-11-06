#DFAO struct

require "./DFA.rb"
class DFAO

	attr_reader :dfa, :ostatusList
	
	def initialize(dfa)
		@dfa = dfa
		@ostatusList = []

		#a hash from status num to ostatus num
		statusToOstatusHash = {}

		statusCount = 0
		dfa.statusList.each { |status|

			repeat = false
			ostatusCount = 0
			ostatusList.each { |ostatus|
				if ostatus.hashList == status.hashList
					repeat = true
					break
				end
				ostatusCount += 1
			}

			if repeat
				ostatusList[ostatusCount].statusSet << statusCount
			else
				ostatusList << OStatus.new(status.hashList, statusCount)
			end

			statusToOstatusHash[statusCount] = ostatusCount

			statusCount += 1
		}

		# p statusToOstatusHash

		@ostatusList.each { |ostatus|
			ostatus.hashList.each { |key, value|
				ostatus.hashList[key] = statusToOstatusHash[value]
			}

			p ostatus.hashList
		}

	end

end


class OStatus
	attr_reader :hashList, :statusSet
	def initialize(hashList, originStatusNum)
		@hashList = hashList
		@statusSet = [originStatusNum]
	end
end	

