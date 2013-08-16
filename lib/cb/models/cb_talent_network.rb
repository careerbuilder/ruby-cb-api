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


  class TalentNetwork::Questions
    attr_accessor :text, :form_value, :option_display_type, :order, :required, :options
                  
    def initialize(args={})
      @text                 = args['Text'] || ''
      @form_value           = args['Form'] || ''
      @option_display_type  = args['OptionDisplayType'] || ''
      @order                = args['Order'] || ''
      @required             = args['Required'] || ''
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
      @join_form_intercept_enabled      = args['JoinFormInterceptEnabled'] || ''
    end
  end
end