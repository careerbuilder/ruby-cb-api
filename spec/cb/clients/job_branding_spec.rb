require 'spec_helper'

module Cb
	describe Cb::Clients::JobBranding do

		context '.find_by_id' do
      before :each do
        content = { Branding: { Media: Hash.new, Sections: Array.new, Widgets: Hash.new, Styles: {
          Page: nil, JobDetails: { Container: nil, Content: nil, Headings: nil},
          CompanyInfo: { Buttons: nil, Container: nil, Content: nil, Headings: nil } } } }

        stub_request(:get, uri_stem(Cb.configuration.uri_job_branding)).
          to_return(:body => content.to_json)
      end

			it 'should return valid job branding schema' do
        job_branding = Cb::Clients::JobBranding.find_by_id('fake-id')
        expect(job_branding).to be_an_instance_of Cb::CbJobBranding
			end
    end

	end
end
