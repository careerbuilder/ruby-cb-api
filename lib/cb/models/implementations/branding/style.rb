module Cb
  module Models
    module Branding

      class Style
        attr_accessor :page, :job_details, :company_info

        def initialize(args = {})
          @page         = Styles::Page.new args['Page']
          @job_details  = Styles::JobDetails.new args['JobDetails']
          @company_info = Styles::CompanyInfo.new args['CompanyInfo']
        end
      end

    end
  end
end
