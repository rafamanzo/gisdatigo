require 'spec_helper'

class BaseTest < Gisdatigo::Runner::Base
  def public_test(error_message)
    test(error_message)
  end
end

describe Gisdatigo::Runner::Base do
  describe 'methods' do
    describe 'test' do
      subject { BaseTest.new }

      context 'when tests passes' do
        before :each do
          Gisdatigo::TestManager.expects(:check_units).returns(true)
        end

        it 'is expected to call the TestsManager and print status' do
          expect { subject.public_test("error") }.to output("\tRunning tests...OK!\n").to_stdout
        end
      end

      context 'when tests fail' do
        let!(:git_manager) { mock('git_manager') }

        before :each do
          Gisdatigo::GitManager.expects(:new).returns(git_manager)
          Gisdatigo::TestManager.expects(:check_units).returns(false)
        end

        subject { BaseTest.new }

        it 'is expected to call the TestsManager, print status and exit with code 1' do
          git_manager.expects(:reset)
          subject.expects(:exit).with(1)
          STDERR.expects(:puts).with("error")

          expect { subject.public_test("error") }.to output("\tRunning tests...").to_stdout
        end
      end
    end
  end
end