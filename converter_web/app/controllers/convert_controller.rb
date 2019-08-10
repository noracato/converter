class ConvertController < ApplicationController
	

	def index
		# @keywords = ["in", "to"]
		@tracker = UnitTracker.new()
		# @tracker = UnitTrackerSimple.new()
		puts "created tracker"
	end

	# for some reason the tracker created in index is gone when posting to 'convert' ??
	def createTracker
		@tracker = UnitTracker.new() if @tracker.nil?
		# @tracker = UnitTrackerSimple.new() if @tracker.nil?
	end

  	# processes user input into measures and amount, calls the unittracker for conversion
	def convert

		splitWords = params[:convert][:query].split(" ")

		# search for keyword (use for-loop instead of each to remember indexTry)
		keywords = ["in", "to"]
		for word in keywords
			indexTry = splitWords.find_index(word)
			break if indexTry
		end
		
		if indexTry.nil?
			render plain: "Invalid input"
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
		createTracker
		begin
			answer = @tracker.convert(from, to, amount)
		rescue RuntimeError => err
			puts err
			render plain: "#{err.message}"
			return
		end

		render plain: "#{amount} #{from} is #{answer} #{to}"

	end

end
