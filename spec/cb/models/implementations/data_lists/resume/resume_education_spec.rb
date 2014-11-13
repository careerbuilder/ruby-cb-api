require 'spec_helper'

module Cb
  module Models
    describe DataLists::ResumeEducation do
      subject { DataLists::ResumeEducation.new(args) }

      let(:args) { { key => key, value => value } }
      let(:key) { 'key' }
      let(:value) { 'value' }

      it { expect(subject.key).to eql(key) }
      it { expect(subject.value).to eql(value) }
    end
  end
end
