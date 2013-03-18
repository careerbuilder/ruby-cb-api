require 'singleton'

	class CbCountryCode

		include Singleton

		attr_accessor :cc_code, :cc_output

		def initialize
			# @cc_code = ["UK","US","IN"]
			#all the country codes used in CB
			@cc_code = ["AH","BE","CA","CC","CE","CH","CN","CP","CS","CY","DE","DK","E1","ER","ES","EU","F1",
									"FR","GC","GR","I1","IE","IN","IT","J1","JC","JS","LJ","M1","MY","NL","NO","PD","PI",
									"PL","RM","RO","RX","S1","SE","SF","SG","T1","T2","UK","US","WH","WM","WR"]

		end

	def load_country(str)
	
		@cc_output = ''
		@cc_code.each do |a|
			if a == str[0..1]
				@cc_output = a
				break
			end		
		end
		# forcing default to US if no code exists
		if @cc_output.empty?
			 @cc_output = 'US'
		end

		return @cc_output
	
	end
		
end



