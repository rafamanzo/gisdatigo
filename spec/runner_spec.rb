require 'spec_helper'

describe Gisdatigo::Runner do
  describe 'methods' do
    describe 'run' do
      it 'is expected to call the sub classes' do
        Gisdatigo::Runner::PreProcessor.any_instance.expects(:check)
        Gisdatigo::Runner::Updater.any_instance.expects(:update)
        Gisdatigo::Runner::PostProcessor.any_instance.expects(:process)

        Gisdatigo::Runner.run
      end
    end
  end
end