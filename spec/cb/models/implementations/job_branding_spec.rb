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
  describe JobBranding do
    context '.new' do
      it 'should create a job branding' do
        name = 'Jesse Branding'
        id = 'JBID'
        account_id = 'ADID'
        type = 'Basic'
        errors = { 'Message' => 'There is no job branding for this Id.' }
        company_description = 'Company name ...'

        media =
          {
            'Header' => 'header?',
            'HeaderType' => 'awesome',
            'TabletBanner' => 'wut?',
            'MobileLogo' => 'mobile, duh.',
            'Footer' => 'the bottom',
            'IsMultiVideo' => 'true'
          }

        sections =
          {
            'Page' =>
              {
                'Section1' => 'the one',
                'Section2' => 'the two',
                'Section3' => 'the three'
              },
            'JobDetails' =>
              {
                'Description' => 'the desc.',
                'Requirements' => 'reqsss',
                'Snapshot' => 'click click.'
              }
          }

        styles =
          {
            'Page' =>
              {
                'FontColor' => '#FFF',
                'FontSize' => '14px',
                'FontStyle' => 'Helvetica'
              },
            'JobDetails' =>
              {
                'Container' =>
                  {
                    'BorderColor' => '#FFA'
                  },
                'Content' =>
                  {
                    'BorderRadius' => '4px'
                  },
                'Headings' =>
                  {
                    'BoxShadow' => 'none'
                  }
              },
            'CompanyInfo' =>
              {
                'Buttons' =>
                  {
                    'BackgroundColor' => '#CCC'
                  },
                'Container' =>
                  {
                    'BackgroundImage' => 'http://image.is.here/23242.jpg'
                  },
                'Content' =>
                  {
                    'BackgroundGradient' =>
                      {
                        'Color1' => '#F2323A',
                        'Color2' => '#D245A2',
                        'Orientation' => 'Horizontal'
                      }
                  },
                'Headings' =>
                  {
                    'BorderSize' => '3px'
                  }
              }
          }

        widgets = {
          'ShowWidgets' => 'true',
          'Youtube' => 'http://www.youtube.com'
        }

        job_branding = Cb::Models::JobBranding.new(
          'Name' => name,
          'Id' => id,
          'AccountId' => account_id,
          'Type' => type,
          'Media' => media,
          'Styles' => styles,
          'Errors' => errors,
          'Sections' => sections,
          'Widgets' => widgets,
          'CompanyDescription' => company_description)

        expect(job_branding.name).to eq(name)
        expect(job_branding.id).to eq(id)
        expect(job_branding.account_id).to eq(account_id)
        expect(job_branding.type).to eq(type)
        expect(job_branding.errors).to eq(errors)
        job_branding.company_description = company_description
        expect(job_branding.show_widgets).to eq(widgets['ShowWidgets'] == 'true')

        expect(job_branding.media.header).to eq(media['Header'])
        expect(job_branding.media.header_type).to eq(media['HeaderType'])
        expect(job_branding.media.tablet_banner).to eq(media['TabletBanner'])
        expect(job_branding.media.mobile_logo).to eq(media['MobileLogo'])
        expect(job_branding.media.footer).to eq(media['Footer'])
        expect(job_branding.media.is_multi_video).to eq(media['IsMultiVideo'] == 'true')

        expect(job_branding.sections.count).to eq(2)
        expect(job_branding.sections[0].type).to eq(sections.keys[0])
        expect(job_branding.sections[0].section_1).to eq(sections['Page']['Section1'])
        expect(job_branding.sections[0].section_2).to eq(sections['Page']['Section2'])
        expect(job_branding.sections[0].section_3).to eq(sections['Page']['Section3'])
        expect(job_branding.sections[0].description).to eq('')
        expect(job_branding.sections[0].requirements).to eq('')
        expect(job_branding.sections[0].snapshot).to eq('')
        expect(job_branding.sections[1].type).to eq(sections.keys[1])
        expect(job_branding.sections[1].section_1).to eq('')
        expect(job_branding.sections[1].section_2).to eq('')
        expect(job_branding.sections[1].section_3).to eq('')
        expect(job_branding.sections[1].description).to eq(sections['JobDetails']['Description'])
        expect(job_branding.sections[1].requirements).to eq(sections['JobDetails']['Requirements'])
        expect(job_branding.sections[1].snapshot).to eq(sections['JobDetails']['Snapshot'])

        expect(job_branding.styles.page.raw).to eq(styles['Page'])
        expect(job_branding.styles.page.to_css).to eq('color:#FFF;font-size:14px;font-family:Helvetica;')
        expect(job_branding.styles.job_details.raw).to eq(styles['JobDetails'])
        expect(job_branding.styles.job_details.container.raw).to eq(styles['JobDetails']['Container'])
        expect(job_branding.styles.job_details.container.to_css).to eq('border-color:#FFA;')
        expect(job_branding.styles.job_details.content.raw).to eq(styles['JobDetails']['Content'])
        expect(job_branding.styles.job_details.content.to_css).to eq('-webkit-border-radius:4px;-moz-border-radius:4px;border-radius:4px;')
        expect(job_branding.styles.job_details.headings.raw).to eq(styles['JobDetails']['Headings'])
        expect(job_branding.styles.job_details.headings.to_css).to eq('-webkit-box-shadow:none;-moz-box-shadow:none;box-shadow:none;')
        expect(job_branding.styles.company_info.raw).to eq(styles['CompanyInfo'])
        expect(job_branding.styles.company_info.buttons.raw).to eq(styles['CompanyInfo']['Buttons'])
        expect(job_branding.styles.company_info.buttons.to_css).to eq('background-color:#CCC;')
        expect(job_branding.styles.company_info.container.raw).to eq(styles['CompanyInfo']['Container'])
        expect(job_branding.styles.company_info.container.to_css).to eq('background-image:url(http://image.is.here/23242.jpg);')
        expect(job_branding.styles.company_info.content.raw).to eq(styles['CompanyInfo']['Content'])
        expect(job_branding.styles.company_info.content.to_css).to eq("background:#F2323A;background:-moz-linear-gradient(left,#F2323A0%,#D245A2100%);background:-webkit-gradient(linear,lefttop,righttop,color-stop(0%,#F2323A),color-stop(100%,#D245A2));background:-webkit-linear-gradient(left,#F2323A0%,#D245A2100%);background:-o-linear-gradient(left,#F2323A0%,#D245A2100%);background:-ms-linear-gradient(left,#F2323A0%,#D245A2100%);background:linear-gradient(toright,#F2323A0%,#D245A2100%);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#F2323A',endColorstr='#D245A2',GradientType=1);")
        expect(job_branding.styles.company_info.headings.raw).to eq(styles['CompanyInfo']['Headings'])
        expect(job_branding.styles.company_info.headings.to_css).to eq('border-width:3px;')

        expect(job_branding.widgets[0].type).to eq(widgets.keys[1])
        expect(job_branding.widgets[0].url).to eq(widgets.values[1])
      end
    end
  end
end
