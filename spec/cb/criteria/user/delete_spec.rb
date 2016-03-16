# Copyright 2016 CareerBuilder, LLC
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
  describe Cb::Criteria::User::Delete do
    before :all do
      @external_id                 = 'ext_id'
      @password                    = 'pw'
      @test                        = 'true'

      @user_delete = Cb::Criteria::User::Delete.new(
        external_id: @external_id,
        password: @password,
        test: @test
      )
    end

    context '.delete' do
      it 'should create an empty new user' do
        expect(@user_delete.external_id).to eq @external_id
        expect(@user_delete.password).to eq @password
        expect(@user_delete.test).to eq @test
      end
    end

    context '#to_xml' do
      it 'returns a string of valid XML' do
        returned_xml = @user_delete.to_xml
        # if the string fails to parse there is invalid XML being generated
        Nokogiri::XML::Document.parse(returned_xml)

        expect(returned_xml).to be_an_instance_of String
      end
    end
  end
end
