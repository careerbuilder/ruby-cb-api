require 'spec_helper'

describe Cb do

  context '#configure' do
    context 'when called with a block' do
      it 'yields a default configuration to play with' do
        Cb.configure do |c|
          c.should be_an_instance_of Cb::Config
        end
      end

      it 'caches the config if called again' do
        original_object_id = ''
        Cb.configure { |c1| original_object_id = c1.object_id }
        Cb.configure { |c2| c2.object_id.should eq original_object_id }
      end
    end
  end

end
