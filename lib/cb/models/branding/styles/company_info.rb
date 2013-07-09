module Cb::Branding::Styles

	class CompanyInfo < Base
		attr_accessor :buttons, :container, :content, :headings

		def initialize args = {}
			super

			@buttons = Buttons.new args
			@container = Container.new args
			@content = Content.new args
			@headings = Headings.new args
		end
	end

end