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
require 'spec_helper'

module Cb::Models
  describe TalentNetwork do
    context '.new' do
      it 'should create a new talent network object' do
        tn_obj = TalentNetwork.new
        expect(tn_obj.class).to be == TalentNetwork
      end

      it 'should return no join questions on create' do
        tn_obj = TalentNetwork.new
        expect(tn_obj.join_form_questions.size).to eq(0)
      end

      it 'should return at least one join question' do
        args = {}
        args['JoinQuestions'] = [
          {
            'Text' => 'Blah',
            'OptionDisplayType' => 'Blah'
          },
          {
            'Text' => 'Blah2',
            'OptionDisplayType' => 'Blah2'
          }
        ]

        tn_obj = TalentNetwork.new(args)
        expect(tn_obj.join_form_questions.size).to be > 0
      end
    end
  end

  describe TalentNetwork::Member do
    context '.new' do
      it 'should create a member object' do
        m_obj = TalentNetwork::Member.new
        expect(m_obj.class).to be == TalentNetwork::Member
      end

      it 'should be able to give back join values' do
        args = {}
        args['JoinValues'] = %w(blah bla1 hello world)

        m_obj = TalentNetwork::Member.new(args)
        expect(m_obj.join_values.class).to be == Array
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
        expect(q_obj.text).to eq('')
        expect(q_obj.form_value).to eq('')
        expect(q_obj.option_display_type).to eq('')
        expect(q_obj.order).to eq('')
        expect(q_obj.required).to eq('')
        expect(q_obj.options.size).to eq(0)
      end

      it 'should return tn questions supplied into args' do
        args = {}
        args['Text'] = 'Hello'
        args['FormValue'] = 'MxDot_Whatever'
        args['OptionDisplayType'] = 'World'

        q_obj = TalentNetwork::Questions.new(args)

        expect(q_obj.text).to eq(args['Text'])
        expect(q_obj.form_value).to eq(args['FormValue'])
        expect(q_obj.option_display_type).to eq(args['OptionDisplayType'])
        expect(q_obj.order).to eq('')
        expect(q_obj.required).to eq('')
        expect(q_obj.options.size).to eq(0)
      end

      it 'should return at least one tn option' do
        args = {}
        args['Options'] = [
          {
            'Value' => 1,
            'Order' => 'Ascending',
            'DisplayText' => 'Blah'
          }
        ]

        q_obj = TalentNetwork::Questions.new(args)
        expect(q_obj.options.size).to be > 0
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
        expect(opt_obj.value).to eq('')
        expect(opt_obj.order).to eq('')
        expect(opt_obj.display_text).to eq('')
      end

      it 'should return tn options when args supplied' do
        args = {}
        args['Value'] = 1
        args['Order'] = 'Ascending'

        opt_obj = TalentNetwork::Options.new(args)
        expect(opt_obj.value).to eq(args['Value'])
        expect(opt_obj.order).to eq(args['Order'])
        expect(opt_obj.display_text).to eq('')
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
        expect(jinfo_obj.join_form_url).to eq('')
        expect(jinfo_obj.tn_did).to eq('')
        expect(jinfo_obj.join_form_intercept_enabled).to eq('')
      end

      it 'should return job information when args supplied' do
        args = {}
        args['sTNDID'] = 'SomeJobDID'

        jinfo_obj = TalentNetwork::JobInfo.new(args)
        expect(jinfo_obj.join_form_url).to eq('')
        expect(jinfo_obj.tn_did).to eq(args['sTNDID'])
        expect(jinfo_obj.join_form_intercept_enabled).to eq('')
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
        expect(jfgeo_obj.countries.size).to eq(0)
        expect(jfgeo_obj.states.size).to eq(0)
      end

      it 'should return countries and states as a hash when args supplied' do
        args = {}
        args['Countries'] = {
          'Value' => %w(aa bb cc),
          'Display' => %w(aaaaa bbbbb ccccc)
        }
        args['States'] = {
          'Value' => %w(aa bb cc),
          'Display' => %w(aaaaa bbbbb ccccc)
        }

        jfgeo_obj = TalentNetwork::JoinFormGeo.new(args)
        expect(jfgeo_obj.countries.geo_hash.length).to be > 0
        expect(jfgeo_obj.states.geo_hash.length).to be > 0
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
        expect(jfgl_obj.geo_hash.length).to eq(0)
      end

      it 'should return a filled hash when args are supplied' do
        args = {}
        args['Value'] = %w(aa bb cc)
        args['Display'] = %w(aaa bbb ccc)
        jfgl_obj = TalentNetwork::JoinFormGeoLocation.new(args)
        expect(jfgl_obj.geo_hash.length).to be > 0
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
        expect(jfb_obj.stylesheet_url).to eq('')
        expect(jfb_obj.join_logo_image_url).to eq('')
        expect(jfb_obj.join_custom_msg_html).to eq('')
        expect(jfb_obj.button_color).to eq('')
        expect(jfb_obj.mobile_logo_image_url).to eq('')
        expect(jfb_obj.nav_color).to eq('')
        expect(jfb_obj.site_path).to eq('')
      end

      it 'should return branding info when args supplied' do
        args = {}
        args['StylesheetURL'] = 'https://blah.com/my.css'
        args['JoinLogoImageURL'] = 'https://secure.com/my.png'

        jfb_obj = TalentNetwork::JoinFormBranding.new(args)
        expect(jfb_obj.stylesheet_url).to eq(args['StylesheetURL'])
        expect(jfb_obj.join_logo_image_url).to eq(args['JoinLogoImageURL'])
        expect(jfb_obj.join_custom_msg_html).to eq('')
        expect(jfb_obj.button_color).to eq('')
        expect(jfb_obj.mobile_logo_image_url).to eq('')
        expect(jfb_obj.nav_color).to eq('')
        expect(jfb_obj.site_path).to eq('')
      end
    end
  end
end
