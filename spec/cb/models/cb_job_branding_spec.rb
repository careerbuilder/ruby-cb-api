require 'spec_helper'

module Cb
  describe Cb::CbJobBranding do
    context '.new' do
      it 'should create a job branding' do
        name = 'Jesse Branding'
        id = 'JBID'
        account_id = 'ADID'
        type = 'Basic'
        tracking = '<img src="url" alt="some_text">'
        errors = { 'Message' => 'There is no job branding for this Id.' }
        company_description = 'Company name ...'

        media = 
	        { 
	        	'Header' => 'header?',
	        	'HeaderType' => 'awesome',
	        	'TabletBanner' => 'wut?',
	        	'MobileLogo' => 'mobile, duh.',
	        	'Footer' => 'the bottom',
                'Video' => '123456789',
	        	'IsMultiVideo' => false
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


        job_branding = Cb::CbJobBranding.new(
        	{
	        	'Name' => name,
	        	'Id' => id,
	        	'AccountId' => account_id,
	            'Type' => type,
                'Tracking' => tracking,
	            'Media' => media,
	            'Styles' => styles,
	            'Errors' => errors,
	            'Sections' => sections,
	            'Widgets' => widgets,
                'CompanyDescription' => company_description
	        })

        job_branding.name.should == name
        job_branding.id.should == id
        job_branding.account_id.should == account_id
        job_branding.type.should == type
        job_branding.tracking.should == tracking
        job_branding.errors.should == errors
        job_branding.company_description = company_description
        job_branding.show_widgets.should == (widgets['ShowWidgets'] == 'true')

        job_branding.media.header.should == media['Header']
        job_branding.media.header_type.should == media['HeaderType']
        job_branding.media.tablet_banner.should == media['TabletBanner']
        job_branding.media.mobile_logo.should == media['MobileLogo']
        job_branding.media.footer.should == media['Footer']
        job_branding.media.is_multi_video.should == (media['IsMultiVideo'] == 'true')

        job_branding.sections.count.should == 2
        job_branding.sections[0].type.should == sections.keys[0]
        job_branding.sections[0].section_1.should == sections['Page']['Section1']
        job_branding.sections[0].section_2.should == sections['Page']['Section2']
        job_branding.sections[0].section_3.should == sections['Page']['Section3']
        job_branding.sections[0].description.should == ''
        job_branding.sections[0].requirements.should == ''
        job_branding.sections[0].snapshot.should == ''
        job_branding.sections[1].type.should == sections.keys[1]
        job_branding.sections[1].section_1.should == ''
        job_branding.sections[1].section_2.should == ''
        job_branding.sections[1].section_3.should == ''
        job_branding.sections[1].description.should == sections['JobDetails']['Description']
        job_branding.sections[1].requirements.should == sections['JobDetails']['Requirements']
        job_branding.sections[1].snapshot.should == sections['JobDetails']['Snapshot']

        job_branding.styles.page.raw.should == styles['Page']
        job_branding.styles.page.to_css.should == 'color:#FFF;font-size:14px;font-family:Helvetica;'
        job_branding.styles.job_details.raw.should == styles['JobDetails']
        job_branding.styles.job_details.container.raw.should == styles['JobDetails']['Container']
        job_branding.styles.job_details.container.to_css.should == 'border-color:#FFA;'
        job_branding.styles.job_details.content.raw.should == styles['JobDetails']['Content']
        job_branding.styles.job_details.content.to_css.should == '-webkit-border-radius:4px;-moz-border-radius:4px;border-radius:4px;'
        job_branding.styles.job_details.headings.raw.should == styles['JobDetails']['Headings']
        job_branding.styles.job_details.headings.to_css.should == '-webkit-box-shadow:none;-moz-box-shadow:none;box-shadow:none;'
        job_branding.styles.company_info.raw.should == styles['CompanyInfo']
        job_branding.styles.company_info.buttons.raw.should == styles['CompanyInfo']['Buttons']
        job_branding.styles.company_info.buttons.to_css.should == 'background-color:#CCC;'
        job_branding.styles.company_info.container.raw.should == styles['CompanyInfo']['Container']
        job_branding.styles.company_info.container.to_css.should == 'background-image:url(http://image.is.here/23242.jpg);'
        job_branding.styles.company_info.content.raw.should == styles['CompanyInfo']['Content']
        job_branding.styles.company_info.content.to_css.should == "background:#F2323A;background:-moz-linear-gradient(left,#F2323A0%,#D245A2100%);background:-webkit-gradient(linear,lefttop,righttop,color-stop(0%,#F2323A),color-stop(100%,#D245A2));background:-webkit-linear-gradient(left,#F2323A0%,#D245A2100%);background:-o-linear-gradient(left,#F2323A0%,#D245A2100%);background:-ms-linear-gradient(left,#F2323A0%,#D245A2100%);background:linear-gradient(toright,#F2323A0%,#D245A2100%);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#F2323A',endColorstr='#D245A2',GradientType=1);"
        job_branding.styles.company_info.headings.raw.should == styles['CompanyInfo']['Headings']
        job_branding.styles.company_info.headings.to_css.should == 'border-width:3px;'

        job_branding.widgets[0].type.should == widgets.keys[1]
        job_branding.widgets[0].url.should == widgets.values[1]
      end
    end
  end
end