module Cb::Branding

	class Widget
		attr_accessor :type, :url

		def initialize type, url
			@type = type
			@url = url
		end

	end

end