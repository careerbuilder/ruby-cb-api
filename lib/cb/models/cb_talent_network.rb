module Cb
  class TalentNetwork
    attr_accessor :join_form_questions
    def initialize(args={})
      @join_form_questions = Array.new
      if args.has_key?('JoinQuestions')
        args['JoinQuestions'].each do |question|
          @join_form_questions << TalentNetwork::Questions.new(question)
        end
      end
    end
  end

  class TalentNetwork::Member
    attr_accessor :dev_key, :tn_did, :preferred_language, :accept_privacy, :accept_terms, :resume_word_doc,
                  :join_values

    def initialize(args={})
      @dev_key                = args['DeveloperKey'] || Cb.configuration.dev_key
      @tn_did                 = args['TNDID'] || ''
      @preferred_language     = args['PreferredLanguage'] || 'USEnglish'
      @accept_privacy         = args['AcceptPrivacy'] || ''
      @accept_terms           = args['AcceptTerms'] || ''
      @resume_word_doc        = args['ResumeWordDoc'] || ''
      @join_values            = Hash.new
      if args.has_key?('JoinValues') 
        @join_values = Hash[args['JoinValues'].each_slice(2).to_a]
      end
    end

    def to_xml
      ret =  "<Request>"
      ret += "<DeveloperKey>#{@dev_key}</DeveloperKey>"
      ret += "<TalentNetworkDID>#{@tn_did}</TalentNetworkDID>"
      ret += "<PreferredLanguage>#{@preferred_language}</PreferredLanguage>"
      ret += "<AcceptPrivacy>#{@accept_privacy}</AcceptPrivacy>"
      ret += "<ResumeWordDoc>#{@resume_word_doc}</ResumeWordDoc>"

    end
  end


  class TalentNetwork::Questions
    attr_accessor :text, :form_value, :option_display_type, :order, :required, :options
                  
    def initialize(args={})
      @text                 = args['Text'] || ''
      @form_value           = args['FormValue'] || ''
      @option_display_type  = args['OptionDisplayType'] || ''
      @order                = args['Order'] || ''
      @required             = args['Required'].to_s || ''
      @options              = Array.new
      if args.has_key?('Options')
        args['Options'].each do |option_values|
          @options << TalentNetwork::Options.new(option_values)
        end
      end
    end
  end

  class TalentNetwork::Options
    attr_accessor :value, :order, :display_text

    def initialize(args={})
      @value          = args['Value'] || ''
      @order          = args['Order'] || ''
      @display_text   = args['DisplayText'] || ''
    end
  end

  class TalentNetwork::JobInfo
    attr_accessor :join_form_url, :tn_did, :join_form_intercept_enabled

    def initialize(args={})
      @join_form_url                    = args['JoinFormUrl'] || ''
      @tn_did                           = args['sTNDID'] || ''
      @join_form_intercept_enabled      = args['JoinFormInterceptEnabled'].to_s || ''
    end
  end

  class TalentNetwork::JoinFormGeo
    attr_accessor :countries, :states

    def initialize(args={})
      @countries = Hash.new
      @states = Hash.new

      if args.has_key?('Countries')
        @countries = TalentNetwork::JoinFormGeoLocation.new(args['Countries'])
      end

      if args.has_key?('States')
        @states = TalentNetwork::JoinFormGeoLocation.new(args['States'])
      end

    end
  end

  class TalentNetwork::JoinFormGeoLocation
    attr_accessor :geo_hash

    def initialize(args={})
      value = Array.new
      display_val = Array.new
      @geo_hash = Hash.new

      if args.has_key?('Value')
        args['Value'].each do |val|
          value << val
        end
      end

      if args.has_key?('Display')
        args['Display'].each do |display|
          display_val << display
        end
      end

      unless value.nil? || display_val.nil?
        @geo_hash = convert_to_hash(display_val,value)
      end
    end

    private
    def convert_to_hash(keys, values)
      geo_hash = Hash.new
      geo_hash = Hash[keys.zip(values)]

      return geo_hash
    end
  end

  class TalentNetwork::JoinFormBranding
    attr_accessor :stylesheet_url, :join_logo_image_url, :join_custom_msg_html, :button_color, 
                  :mobile_logo_image_url, :nav_color, :site_path

    def initialize(args={})
      @stylesheet_url                   = args['StylesheetURL'] || ''
      @join_logo_image_url              = args['JoinLogoImageURL'] || ''
      @join_custom_msg_html             = args['JoinCustomMsgHTML'] || ''
      @button_color                     = args['ButtonColor'] || ''
      @mobile_logo_image_url            = args['MobileLogoImageURL'] || ''
      @nav_color                        = args['NavColor'] || ''
      @site_path                        = args['SitePath'] || ''
    end
  end


end