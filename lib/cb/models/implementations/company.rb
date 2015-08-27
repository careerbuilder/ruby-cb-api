# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
module Cb
  module Models
    class Company
      attr_accessor :did, :name, :hh_name, :url,  :size, :type, :year_founded,
                    :news_feed, :overview, :total_jobs, :headquarters, :host_sites, :s_drive,
                    :industry,

                    :image_file, :header_image, :footer_image, :logo, :photos, :my_photos,
                    :bright_cove_video,

                    :twitter_url, :linked_in_url, :facebook_url, :facebook_widget,
                    :linked_in_widget, :twitter_widget,

                    :benefits, :benefits_label, :history, :contact, :contact_label, :links,
                    :vision, :vision_label, :products, :products_label, :career_opps, :career_opps_label,
                    :culture, :culture_label, :addresses, :bulletin_board, :testimonials,
                    :college, :college_label, :diversity, :diversity_label, :people, :people_label,

                    :extra_custom_tab, :tab_header_bg_color, :tab_header_text_color, :tab_header_hover_color,
                    :side_bar_header_color, :button_color, :button_text_color, :gutter_bg_color,
                    :my_content_tabs, :info_tabs, :is_enhance, :is_military, :is_premium

      def initialize(args = {})
        return if args.nil?

        # General
        ################################################################
        @did                         = args['CompanyDID'] || ''
        @name                        = args['CompanyName'] || ''
        @hh_name                     = args['HHName'] || ''
        @url                         = args['URL'] || ''
        @size                        = args['CompanySize'] || ''
        @type                        = args['CompanyType'] || ''
        @year_founded                = args['YearFounded'] || ''
        @news_feed                   = args['NewsFeed'] || ''
        @overview                    = args['Overview'] || ''
        @total_jobs                  = args['TotalNumberJobs'] || ''
        @headquarters                = args['Headquarter'] || ''
        @host_sites                  = args['HostSites'] || ''
        @s_drive                     = args['SDrive'] || ''
        @industry                    = args['IndustryType'] || ''

        # Images
        ################################################################
        @logo                        = args['CompanyLogo'] || ''
        @header_image                = args['HeaderImage'] || ''
        @footer_image                = args['FooterImage'] || ''
        @image_file                  = args['ImageFile'] || ''

        @photos                      = args['CompanyPhotos']['PhotoList'] || ''
        @my_photos                   = args['MyPhotos'] || ''

        # Videos
        ################################################################
        @bright_cove_video           = args['BrightcoveVideo'] || ''

        # Social sites
        ################################################################
        @facebook_url                = args['FBPageURL'] || args['FacebookURL'] || ''
        @facebook_widget             = args['FacebookWidget'] || ''
        @twitter_url                 = args['TwitterURL'] || ''
        @twitter_widget              = args['TwitterWidget'] || ''
        @linked_in_url               = args['LinkedURL'] || ''
        @linked_in_widget            = args['LinkedInWidget'] || ''

        # Detailed information (blobs)
        ################################################################
        @history                     = args['HistoryBody'] || ''
        @people                      = args['PeopleBody'] || ''
        @people_label                = args['PeopleLabel'] || ''
        @contact                     = args['ContactBody'] || ''
        @contact_label               = args['ContactLabel'] || ''
        @benefits                    = args['BenefitsBody'] || ''
        @benefits_label              = args['BenefitsLabel'] || ''
        @vision                      = args['VisionBody'] || ''
        @vision_label                = args['VisionLabel'] || ''
        @products                    = args['ProductsBody'] || ''
        @products_label              = args['ProductsLabel'] || ''
        @career_opps                 = args['CareerOpportunitiesBody'] || ''
        @career_opps_label           = args['CareerOpportunitiesLabel'] || ''
        @culture                     = args['CultureBody'] || ''
        @culture_label               = args['CultureLabel'] || ''
        @bulletin_board              = args['CompanyBulletinBoard']['bulletinboards'] || ''
        @testimonials                = args['Testimonials']['Testimonials'] || ''
        @addresses = []
        if args.key?('CompanyAddress')
          unless args['CompanyAddress'].empty? || args['CompanyAddress']['AddressList'].nil?
            args['CompanyAddress']['AddressList']['Address'].each do |cur_addr|
              @addresses << Company::Address.new(cur_addr)
            end
          end
        end
        @college                     = args['CollegeBody'] || ''
        @college_label               = args['CollegeLabel'] || ''
        @diversity                   = args['DiversityBody'] || ''
        @diversity_label             = args['DiversityLabel'] || ''
        @links                       = args['CompanyLinksCollection']['companylinks'] || ''

        # tabs, colors, buttons, headers, etc
        ################################################################
        @extra_custom_tab            = args['ExtraCustomTab'] || ''
        @tab_header_bg_color         = args['TabHeaderBGColor'] || ''
        @tab_header_text_color       = args['TabHeaderTextColor'] || ''
        @tab_header_hover_color      = args['TabHeaderHoverColor'] || ''
        @side_bar_header_color       = args['SidebarHeaderColor'] || ''
        @button_color                = args['ButtonColor'] || ''
        @button_text_color           = args['ButtonTextColor'] || ''
        @gutter_bg_color             = args['GutterBGColor'] || ''
        @my_content_tabs             = args['MyContent']['MyContentTabs'] || ''
        @info_tabs                   = args['InfoTabs']['InfoTabs'] || ''
        @is_enhance                  = args['isEnhance'] || ''
        @is_military                 = args['MilitaryIcon'] || ''
        @is_premium                  = args['PremiumProfile'] || ''
      end

      # CbAddress               # CbCompany has a collection of these
      ################################################################
      class Address
        attr_accessor :street, :city, :state, :country, :zip

        def initialize(args = {})
          @street                    = args['Street'] || ''
          @city                      = args['City'] || ''
          @state                     = args['State'] || ''
          @country                   = args['Country'] || ''
          @zip                       = args['ZIPCode'] || ''
        rescue
        end
      end
    end
  end
end
