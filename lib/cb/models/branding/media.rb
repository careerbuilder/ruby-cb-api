module Cb
  module Branding

    class Media

      attr_accessor :header, :header_type, :tablet_banner, :mobile_logo, :footer, :is_multi_video

      def initialize args = {}
        @header = args['Header'] || ''
        @header_type = args['HeaderType'] || ''
        @tablet_banner = args['TabletBanner'] || ''
        @mobile_logo = args['MobileLogo'] || ''
        @footer = args['Footer'] || ''
        @is_multi_video = args['IsMultiVideo'] == 'true'
      end

    end
	end
end