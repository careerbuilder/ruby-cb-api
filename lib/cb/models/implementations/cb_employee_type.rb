module Cb
	class CbEmployeeType

		attr_accessor	:code, :name, :language

		def initialize(args={})
			@code			||= args['Code'] || ''
			@name			||= args['Name']["#text"] || ''
			@language	||= args['Name']["@language"] || ''
		end
	end
end