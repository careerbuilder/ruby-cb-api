require 'cb/models/branding/styles/css_adapter' # Path load errors in cb.rb - just doing this here for the time being.

module Cb
	class CbJobBranding

		attr_accessor :name, :media, :sections, :styles, :widgets, :id, :account_id, :type, :errors, :show_widgets

		def initialize args = {}
			@name = args['Name'] || ''
			@id = args['Id'] || ''
			@account_id = args['AccountId'] || ''
			@type = args['Type'] || ''
			@media = Cb::Branding::Media.new args['Media']
			@styles = Cb::Branding::Style.new args['Styles']
			@errors = args['Errors'] || ''

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