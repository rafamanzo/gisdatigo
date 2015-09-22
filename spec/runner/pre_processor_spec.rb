require 'spec_helper'

describe Gisdatigo::Runner::PreProcessor do
  describe 'methods' do
    describe 'check' do
      subject { Gisdatigo::Runner::PreProcessor.new }

      it 'is expected to print the status and call the tests' do
        subject.expects(:test).with("Your application has failling tests, please fix them!")

        expect { subject.check }.to output("Prechecking the state:\n").to_stdout
      end
    end
  end
end