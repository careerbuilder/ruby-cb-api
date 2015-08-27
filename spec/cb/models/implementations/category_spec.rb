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
  describe Category do
    context '.new' do
      it 'should create a new cb category object' do
        args = { 'Name' => { '#text' => 'name', '@language' => 'lang' },
                 'Code' => 'code' }
        category_obj = Category.new(args)

        expect(category_obj.is_a?(Category)).to eq(true)

        expect(category_obj.CategoryCode).to eq('code')
        expect(category_obj.CategoryLanguage).to eq('lang')
        expect(category_obj.CategoryName).to eq('name')
      end
    end
  end
end
