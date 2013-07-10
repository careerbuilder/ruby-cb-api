module Cb
  module Branding

    class Style

      attr_accessor :page, :job_details, :company_info

      def initialize args = {}
        @page = Cb::Branding::Styles::Page.new args['Page']
        @job_details = Cb::Branding::Styles::JobDetails.new args['JobDetails']
        @company_info = Cb::Branding::Styles::CompanyInfo.new args['CompanyInfo']
      end

    end

  end
end