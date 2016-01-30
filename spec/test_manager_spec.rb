require 'spec_helper'

describe Gisdatigo::TestManager do
  describe 'methods' do
    describe 'check_units' do
      it 'is expected to call the test command in the system' do
        Gisdatigo::TestManager.expects(:system).with("#{Gisdatigo.configurations[:test_command]} &> /dev/null").returns(true)

        Gisdatigo::TestManager.check_units
      end
    end
  end
end