module Cb
  module Models
    class JobBranding

      attr_accessor :name, :media, :sections, :styles, :widgets, :id, :account_id, :type, :errors, :show_widgets, :company_description

      def initialize args = {}
        @name = args['Name'] || ''
        @id = args['Id'] || ''
        @account_id = args['AccountId'] || ''
        @type = args['Type'] || ''
        @media = Branding::Media.new args['Media']
        @styles = Branding::Style.new args['Styles']
        @errors = args['Errors'] || ''
        @company_description = args['CompanyDescription'] || ''
        @sections, @widgets = [], []

        args['Sections'].each do |type, sections|
          @sections << Branding::Section.new(type, sections) unless sections.nil?
        end

        args['Widgets'].each do |type, url|
          if type == 'ShowWidgets'
            @show_widgets = url == 'true'
          else
            @widgets << Branding::Widget.new(type, url) unless url.nil?
          end
        end

      end

    end
  end
end
