#DFAO struct

require "./DFA.rb"
class DFAO

	attr_reader :dfa, :ostatusList
	attr_reader :begin
	attr_reader :finalOstatusNumList
	def initialize(dfa)
		@dfa = dfa
		@ostatusList = []
		@finalOstatusNumList = []
		#a hash from status num to ostatus num
		statusToOstatusHash = {}

		finalNumCount = 0
		dfa.finalNumList.each { |finalStatusNumSet|

			ostatusListBuffer = []
			finalStatusNumSet.each { |finalStatusNum|
				repeat = false
				count = 0
				ostatusListBuffer.each { |ostatus|
					if ostatus.hashList == dfa.statusList[finalStatusNum].hashList
						repeat = true
						break
					end
					count += 1
				}
				if repeat
					ostatusListBuffer[count].statusSet << finalStatusNum
				else
					ostatusListBuffer[count] = OStatus.new(dfa.statusList[finalStatusNum].hashList, finalStatusNum)
					ostatusListBuffer[count].isEndStatus = true
				end

				statusToOstatusHash[finalStatusNum] = count + @ostatusList.size
				
			}
			@finalOstatusNumList << @ostatusList.size

			@ostatusList = @ostatusList + ostatusListBuffer
			finalNumCount += 1
		}


		statusCount = 0
		dfa.statusList.each { |status|
			if status.isEndStatus
				statusCount += 1
				next
			end
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

		# p @finalOstatusNumList
		# p statusToOstatusHash

		@ostatusList.each { |ostatus|
			ostatus.hashList.each { |key, value|
				ostatus.hashList[key] = statusToOstatusHash[value]
			}

			p ostatus.hashList
			# p ostatus.statusSet

		}

		count = 0
		@ostatusList.each { |ostatus|
			if ostatus.statusSet.include? dfa.begin
				@begin = count
				break
			end
			count += 1
		}

	end

end


class OStatus
	attr_reader :hashList, :statusSet
	attr_accessor :isEndStatus
	def initialize(hashList, originStatusNum)
		@hashList = hashList
		@statusSet = [originStatusNum]
		@isEndStatus = false
	end
end	

