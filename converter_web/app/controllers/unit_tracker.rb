# keeps track of all units in an array
# Conversions are stored inside Unit objects
class UnitTracker

	def initialize()
		@units = []
		# init standard rates
		addStandardRates()
	end

	def addStandardRates()
		addUnitRate("kg", "lb", 2.20462262, "mass")
		addUnitRate("metres", "feet", 3.2808399, "length")
		addUnitRate("metres", "cm", 1000, "length")
		addUnitRate("cm", "inch", 0.393700787, "length")
		addUnitRate("cm", "feet", 0.032808399, "length")
	end

	# raises exception if there is no conversion possible, otherwise
	# returns converted amount
	# IMPROVEMENT: if conversion not availible, check via other route (eg metre->cm->inch)
	def convert(unitFrom, unitTo, amount)
		unitFound = @units.find{ |unit| unit.name == unitFrom}

		raise "#{unitFrom} not found" if unitFound.nil?
		raise "#{unitTo} not found" if @units.find{ |unit| unit.name == unitTo}.nil?
		raise "Types do not match" if @units.find{ |unit| unit.name == unitTo}.type != unitFound.type
		
		return unitFound.convert(unitTo, amount)

	end

	# adds a conversion rate to the base (adds both ways)
	# use: from, to, rate 
	def addUnitRate(unitOne, unitTwo, rate, type)
		addOneRate(unitOne, unitTwo, rate, type)
		addOneRate(unitTwo, unitOne, 1/rate, type)
	end

	def addOneRate(unitOne, unitTwo, rate, type)
		# check if there, otherwise add
		indexOne = @units.find_index{ |unit| unit.name == unitOne }
		if indexOne
			@units[indexOne].addConversion(unitTwo, rate) 
		else
			@units << Unit.new(unitOne, {unitTwo => rate }, type)
		end
	end

	# A Unit contains a name, type and hash of its conversion rates to other units
	class Unit

		def initialize(name, unitRate = {}, type)
			@unitName = name
			@unitType = type
			@unitRate = unitRate
		end

		def name
			@unitName
		end

		def type
			@unitType
		end

		def addConversion(unit, rate)
			@unitRate[:unit] = rate
		end

		# raises exception when conversion is unknown
		def convert(to, amount)
			raise "Conversion unknown" unless @unitRate[to]
			return @unitRate[to] * amount
		end

	end

end


#####################################

# Solution with TYPE attribute

# BENCH (avg over 4)
# 2 lb to metres	0.000145
# 2 kg to lb		0.00013

######################################
