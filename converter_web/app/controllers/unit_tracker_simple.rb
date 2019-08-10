# keeps track of all conversions in a hash. 
# Conversions are stored only under the alphabetically first measure
class UnitTrackerSimple

	def initialize()
		@units = {}
		# init standard rates
		addStandardRates()
	end

	def addStandardRates()
		addUnitRate("kg", "lb", 2.20462262)
		addUnitRate("metres", "feet", 3.2808399)
		addUnitRate("metres", "cm", 1000)
		addUnitRate("cm", "inch", 0.393700787)
	end

	# raises exception if there is no conversion possible, otherwise
	# returns converted amount
	# IMPROVEMENT: if conversion not availible, check via other route (eg metre->cm->inch)
	def convert(unitFrom, unitTo, amount)
		# check alphabetical order
		if [unitFrom, unitTo].sort[0] == unitFrom
			raise "No conversion found" if @units[unitFrom].nil?
			rate = @units[unitFrom][unitTo]
		else
			raise "No conversion found" if @units[unitTo].nil? || @units[unitTo][unitFrom].nil?
			rate = 1.0/@units[unitTo][unitFrom]
		end
		raise "No conversion found" if rate.nil?
		return rate * amount
	end

	# adds a conversion rate to the base (adds only the one higher in alphabet)
	# use: from, to, rate 
	def addUnitRate(unitOne, unitTwo, rate)
		if [unitOne, unitTwo].sort[0] == unitOne
			addOneRate(unitOne, unitTwo, rate)
		else
			addOneRate(unitTwo, unitOne, 1.0/rate)
		end
	end

	def addOneRate(unitOne, unitTwo, rate)
		# check if key is present, otherwise add as new key + hash
		if @units.has_key?(unitOne)
			@units[unitOne][unitTwo] = rate
		else 
			@units[unitOne] = {unitTwo => rate}
		end
	end

end


#####################################

# Solution without TYPE attribute

# BENCH (avg over 4)
# 2 lb to metres	0.00011
# 2 kg to lb		0.00010

# A little quicker than the other solution. A more simple structure.
# But less possibilities for adding attributes or organising units

######################################