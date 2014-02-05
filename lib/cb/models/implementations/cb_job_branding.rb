module Cb
	class CbJobBranding

		attr_accessor :name, :media, :sections, :styles, :widgets, :id, :account_id, :type, :tracking, :errors, :show_widgets, :company_description

		def initialize args = {}
			@name = args['Name'] || ''
			@id = args['Id'] || ''
			@account_id = args['AccountId'] || ''
			@type = args['Type'] || ''
			@tracking = args['Tracking'] || ''
			@media = Cb::Branding::Media.new args['Media']
			@styles = Cb::Branding::Style.new args['Styles']
			@errors = args['Errors'] || ''
			@company_description = args['CompanyDescription'] || ''
			@sections, @widgets = [], []
			
			args['Sections'].each do |type, sections|
				@sections << Cb::Branding::Section.new(type, sections) unless sections.nil?
			end

			args['Widgets'].each do |type, url|
				if type == 'ShowWidgets'
					@show_widgets = url == 'true'
				else
					@widgets << Cb::Branding::Widget.new(type, url) unless url.nil?
				end
			end

		end

	end
end