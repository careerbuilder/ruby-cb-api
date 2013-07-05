module Cb::Branding::Styles

	class JobDetails < Base
		attr_accessor :container, :content, :headings

		def initialize args = {}
			super

			@container = Container.new args
			@content = Content.new args
			@headings = Headings.new args
		end

	end

end