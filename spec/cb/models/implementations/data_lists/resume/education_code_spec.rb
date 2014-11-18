require 'spec_helper'

module Cb
  module Models
    describe DataLists::EducationCode do
      subject { DataLists::EducationCode.new(args) }

      let(:args) { { key => key, value => value } }
      let(:key) { 'key' }
      let(:value) { 'value' }

      it { expect(subject.key).to eql(key) }
      it { expect(subject.value).to eql(value) }
    end
  end
end
