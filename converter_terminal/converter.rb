require_relative "unit_tracker"
require_relative "unit_tracker_simple"

# initialises and handles the continuous user input
def applicationHandler()
	@keywords = ["in", "to"]
	# @tracker = UnitTracker.new()
	@tracker = UnitTrackerSimple.new()
	puts "Query:"
	while input = gets.chomp
		# t1 = Time.now
		getMeasures(input)
		# t2 = Time.now
		# puts t2-t1
		puts "Query:"
	end
end

# processes user input into measures and amount, calls the unittracker for conversion
def getMeasures(input)
	splitWords = input.split(" ")

	# search for keyword (use for-loop instead of each to remember indexTry)
	for word in @keywords
		indexTry = splitWords.find_index(word)
		break if indexTry
	end
	
	if indexTry.nil?
		puts "Invalid input"
		return
	end

	# use index of keyword to split sentence in "to" and "from"
	from = splitWords.take(indexTry)
	to = splitWords.last(splitWords.length - indexTry - 1).join('')
	
	# split off amount to convert
	amount = from[0].to_f
	if from.length > 1
		from = from[1]
	else
		from = from[0]
	end

	#filter out all numbers and periods
	from = from.gsub(/[^A-Za-z]/, "") 

	
	# exception handling for conversion
	begin
		answer = @tracker.convert(from, to, amount)
	rescue RuntimeError => err
		puts err
		return
	end

	puts "#{amount} #{from} is #{answer} #{to}"

end


applicationHandler()


# could do this by using keywords - or could do this by
# just getting the last and first (few) words. For better
# handling of wrong inputs I chose to create an array of keywords