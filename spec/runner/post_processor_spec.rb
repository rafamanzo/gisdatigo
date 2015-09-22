require 'spec_helper'

describe Gisdatigo::Runner::PostProcessor do
  describe 'methods' do
    describe 'process' do
      subject { Gisdatigo::Runner::PostProcessor.new }
      let(:remaining_list){ ['outdated1', 'outdated2'] }

      it 'is expected to retrieve the outdated list printing the status' do
        Gisdatigo::BundlerManager.expects(:gem_name_list).returns(remaining_list)

        expected_out = "Post processing:\n"
        expected_out << "\tFetching outdated list...OK!\n"
        expected_out << "\tThe following gems could not be updated and may require manual action:\n"
        remaining_list.each { |gem_name| expected_out << "\t\t#{gem_name}\n" }

        expect { subject.process }.to output(expected_out).to_stdout
      end
    end
  end
end