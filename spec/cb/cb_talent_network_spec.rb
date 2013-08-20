require 'spec_helper'

module Cb
  describe Cb::TalentNetwork do 
    context '.new' do 
      it 'should create a new talent network object' do 
        tn_obj = Cb::TalentNetwork.new
        expect(tn_obj.class).to be == Cb::TalentNetwork
      end

      it 'should return no join questions on create' do 
        tn_obj = Cb::TalentNetwork.new
        tn_obj.join_form_questions.size.should == 0
      end

      it 'should return at least one join question' do 
        args = Hash.new
        args['JoinQuestions'] = [
          {
            "Text" => "Blah",
            "OptionDisplayType" => "Blah"
          }, 
          {
            "Text" => "Blah2",
            "OptionDisplayType" => "Blah2"
          }
        ]

        tn_obj = Cb::TalentNetwork.new(args)
        tn_obj.join_form_questions.size.should > 0
      end
    end
  end

  describe TalentNetwork::Questions do 
    context '.new' do 
      it 'should create a new question object' do 
        q_obj = TalentNetwork::Questions.new
        expect(q_obj.class).to be == TalentNetwork::Questions
      end

      it 'should return empty tn questions when no args supplied' do 
        q_obj = TalentNetwork::Questions.new
        q_obj.text.should == ''
        q_obj.form_value.should == ''
        q_obj.option_display_type.should == ''
        q_obj.order.should == ''
        q_obj.required.should == ''
        q_obj.options.size.should == 0
      end

      it 'should return tn questions supplied into args' do 
        args = Hash.new
        args['Text'] = 'Hello'
        args['FormValue'] = 'MxDot_Whatever'
        args['OptionDisplayType'] = 'World'

        q_obj = TalentNetwork::Questions.new(args)
        
        q_obj.text.should == args['Text']
        q_obj.form_value.should == args['FormValue']
        q_obj.option_display_type.should == args['OptionDisplayType']
        q_obj.order.should == ''
        q_obj.required.should == ''
        q_obj.options.size.should == 0
      end

      it 'should return at least one tn option' do
        args = Hash.new
        args["Options"] = [
          {
            "Value" => 1,
            "Order" => "Ascending",
            "DisplayText" => "Blah"
          }
        ]

        q_obj = TalentNetwork::Questions.new(args)
        q_obj.options.size.should > 0
      end
    end
  end

  describe TalentNetwork::Options do 
    context '.new' do 
      it 'should create an options object' do 
        opt_obj = TalentNetwork::Options.new
        expect(opt_obj.class).to be == TalentNetwork::Options
      end

      it 'should return empty tn options when no args supplied' do
        opt_obj = TalentNetwork::Options.new
        opt_obj.value.should == ''
        opt_obj.order.should == ''
        opt_obj.display_text.should == ''
      end

      it 'should return tn options when args supplied' do 
        args = Hash.new
        args['Value'] = 1
        args['Order'] = 'Ascending'

        opt_obj = TalentNetwork::Options.new(args)
        opt_obj.value.should == args['Value']
        opt_obj.order.should == args['Order']
        opt_obj.display_text.should == ''
      end
    end
  end

  describe TalentNetwork::JobInfo do 
    context '.new' do 
      it 'should create a job info object' do 
        jinfo_obj = TalentNetwork::JobInfo.new
        expect(jinfo_obj.class).to be == TalentNetwork::JobInfo
      end

      it 'should return empty job info when no args supplied' do 
        jinfo_obj = TalentNetwork::JobInfo.new
        jinfo_obj.join_form_url.should == ''
        jinfo_obj.tn_did.should == ''
        jinfo_obj.join_form_intercept_enabled.should == ''
      end

      it 'should return job information when args supplied' do 
        args = Hash.new
        args['sTNDID'] = 'SomeJobDID'

        jinfo_obj = TalentNetwork::JobInfo.new(args)
        jinfo_obj.join_form_url.should == ''
        jinfo_obj.tn_did.should == args['sTNDID']
        jinfo_obj.join_form_intercept_enabled.should == ''
      end
    end
  end

  describe TalentNetwork::JoinFormGeo do 
    context '.new' do 
      it 'should create a join form geo object' do 
        jfgeo_obj = TalentNetwork::JoinFormGeo.new
        expect(jfgeo_obj.class).to be == TalentNetwork::JoinFormGeo
      end

      it 'should return empty countries and states when no args supplied' do
        jfgeo_obj = TalentNetwork::JoinFormGeo.new
        jfgeo_obj.countries.size.should == 0
        jfgeo_obj.states.size.should == 0
      end

      it 'should return countries and states as a hash when args supplied' do 
        args = Hash.new
        args['Countries'] = {
          "Value" => ['aa', 'bb', 'cc'],
          "Display" => ['aaaaa', 'bbbbb', 'ccccc']
        }
        args['States'] = {
          "Value" => ['aa', 'bb', 'cc'],
          "Display" => ['aaaaa', 'bbbbb', 'ccccc']
        }

        jfgeo_obj = TalentNetwork::JoinFormGeo.new(args)
        jfgeo_obj.countries.geo_hash.length.should > 0
        jfgeo_obj.states.geo_hash.length.should > 0
      end
    end
  end

  describe TalentNetwork::JoinFormGeoLocation do 
    context '.new' do 
      it 'should create a new join form geo location object' do 
        jfgl_obj = TalentNetwork::JoinFormGeoLocation.new
        expect(jfgl_obj.class).to be == TalentNetwork::JoinFormGeoLocation
      end

      it 'should return empty geo hash when no args supplied' do 
        jfgl_obj = TalentNetwork::JoinFormGeoLocation.new
        jfgl_obj.geo_hash.length.should == 0
      end

      it 'should return a filled hash when args are supplied' do 
        args = Hash.new
        args['Value'] = ['aa', 'bb', 'cc']
        args['Display'] = ['aaa', 'bbb', 'ccc']
        jfgl_obj = TalentNetwork::JoinFormGeoLocation.new(args)
        jfgl_obj.geo_hash.length.should > 0
      end
    end
  end

  describe TalentNetwork::JoinFormBranding do 
    context '.new' do 
      it 'should create a new join form branding object' do 
        jfb_obj = TalentNetwork::JoinFormBranding.new
        expect(jfb_obj.class).to be == TalentNetwork::JoinFormBranding
      end

      it 'should return no branding information when args are not supplied' do 
        jfb_obj = TalentNetwork::JoinFormBranding.new
        jfb_obj.stylesheet_url.should == ''
        jfb_obj.join_logo_image_url.should == ''
        jfb_obj.join_custom_msg_html.should == ''
        jfb_obj.button_color.should == ''
        jfb_obj.mobile_logo_image_url.should == ''
        jfb_obj.nav_color.should == ''
        jfb_obj.site_path.should == ''
      end

      it 'should return branding info when args supplied' do 
        args = Hash.new
        args['StylesheetURL'] = 'https://blah.com/my.css'
        args['JoinLogoImageURL'] = 'https://secure.com/my.png'

        jfb_obj = TalentNetwork::JoinFormBranding.new(args)
        jfb_obj.stylesheet_url.should == args['StylesheetURL']
        jfb_obj.join_logo_image_url.should == args['JoinLogoImageURL']
        jfb_obj.join_custom_msg_html.should == ''
        jfb_obj.button_color.should == ''
        jfb_obj.mobile_logo_image_url.should == ''
        jfb_obj.nav_color.should == ''
        jfb_obj.site_path.should == ''
      end
    end
  end
end