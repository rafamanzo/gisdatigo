require 'spec_helper'

describe Gisdatigo::Runner::Updater do
  describe 'methods' do
    let!(:git_manager) { mock('git_manager') }

    before :each do
      Gisdatigo::GitManager.expects(:new).returns(git_manager)
    end

    describe 'update' do
      subject { Gisdatigo::Runner::Updater.new }
      let(:outdated_gem_name){ 'outdated1' }

      it 'is expected to retrieve the outdated list, try to update them and commit the changes printing the status' do
        Gisdatigo::BundlerManager.expects(:gem_name_list).returns([outdated_gem_name])
        subject.expects(:test).with("ERROR: Failed to update #{outdated_gem_name}! Tests were broken!")
        git_manager.expects(:has_changes?).returns(true)
        git_manager.expects(:commit).with(outdated_gem_name)

        expected_out = "Running updates:\n"
        expected_out << "\tFetching outdated list...OK!\n"
        expected_out << "\t1/1 - Updating #{outdated_gem_name}\n"

        expect { subject.update }.to output(expected_out).to_stdout
      end
    end
  end
end