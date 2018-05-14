require 'spec_helper'

describe Gisdatigo::Runner::Updater do
  let!(:git_manager) { mock('git_manager') }

  before :each do
    Gisdatigo::GitManager.expects(:new).returns(git_manager)
  end

  describe 'methods' do
    describe 'update' do
      let(:outdated_gems_list) { mock('outdated_gems_list') }
      let(:conservative_options) { ['--conservative'] }

      it 'is expected to retrieve the outdated list and try to update' do
        subject.expects(:fetch_outdated_list).returns(outdated_gems_list)
        subject.expects(:update_gems_with_options).with(outdated_gems_list, conservative_options)

        expect { subject.update }.to output("Running updates:\n").to_stdout
      end
    end
  end

  describe 'private method' do

    describe 'update_gems_with_options' do
      let(:outdated_gem_name){ 'outdated1' }
      let(:outdated_gems_list) { [outdated_gem_name] }
      let(:options) { [] }

      it 'is expected to call the BundlerManager#update, print status and commit' do
        expected_out = "\t1/1 - Updating #{outdated_gem_name}\n"
        subject.expects(:commit).with(outdated_gem_name)

        expect { subject.send(:update_gems_with_options, outdated_gems_list, options) }.to output(expected_out).to_stdout
      end
    end

    describe 'commit' do
      let(:gem_name) { 'outdated42' }

      it 'is expected to check for changes, test them and commit' do
        subject.expects(:test).with("ERROR: Failed to update #{gem_name}! Tests were broken!")
        git_manager.expects(:has_changes?).returns(true)
        git_manager.expects(:commit).with(gem_name)

        subject.send(:commit, gem_name)
      end
    end

    describe 'fetch_outdated_list' do
      it 'is expected to invoke the BundlerManager#gem_name_list' do
        outdated_gems_list = mock('outdated_gems_list')
        Gisdatigo::BundlerManager.expects(:gem_name_list).returns(outdated_gems_list)

        expected_out = "\tFetching outdated list...OK!\n"

        expect { expect(subject.send(:fetch_outdated_list)).to eq(outdated_gems_list) }.to output(expected_out).to_stdout
      end
    end
  end
end
