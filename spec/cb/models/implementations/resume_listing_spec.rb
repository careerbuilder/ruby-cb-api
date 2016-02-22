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

module Cb
  module Models
    describe ResumeListing do
      let(:resume_listing) { Models::ResumeListing.new(resume_list_hash) }
      let(:resume_list_hash) do
        {
          'MigrationID' => 'migrationID',
          'Title' => 'Software Engineer',
          'ExternalID' => 'externalID',
          'HostSite' => 'US',
          'ModifiedDT' => '2/16/2016 11:08:11 AM',
          'Visibility' => 'Private'
        }
      end

      it { expect(resume_listing.title).to eq('Software Engineer') }
      it { expect(resume_listing.external_id).to eq('externalID') }
      it { expect(resume_listing.migration_id).to eq('migrationID') }
      it { expect(resume_listing.host_site).to eq('US') }
      it { expect(resume_listing.modified_dt).to eq('2/16/2016 11:08:11 AM') }
      it { expect(resume_listing.visibility).to eq('Private') }

      context 'listing does not contain a migration ID' do
        let(:resume_list_hash) do
          {
              'Title' => 'Software Engineer',
              'ExternalID' => 'externalID',
              'HostSite' => 'US',
              'ModifiedDT' => '2/16/2016 11:08:11 AM',
              'Visibility' => 'Private'
          }
        end

        it { expect(resume_listing.migration_id.nil?).to be(true) }
      end
    end
  end
end
