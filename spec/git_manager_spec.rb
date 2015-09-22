require 'spec_helper'

describe Gisdatigo::GitManager do
  describe 'constructor' do
    context 'when git is available' do
      before :each do
        Gisdatigo::GitManager.expects(:available?).returns(true)
      end

      it 'is expected to open that repository' do
        Git.expects(:open).with('.')

        Gisdatigo::GitManager.new
      end
    end

    context 'when git is not available' do
      before :each do
        Gisdatigo::GitManager.expects(:available?).returns(false)
      end

      it 'is expected to print a error' do
        expect { Gisdatigo::GitManager.new }.to output("Git is not available in the system\n").to_stderr_from_any_process
      end
    end
  end

  describe 'methods' do
    describe 'available?' do
      context 'when git is available' do
        before :each do
          Gisdatigo::GitManager.expects(:`).with('git --version').returns("version")
        end

        it 'expected to return true' do
          expect(Gisdatigo::GitManager.available?).to be_truthy
        end
      end

      context 'when git is unavailable' do
        before :each do
          Gisdatigo::GitManager.expects(:`).with('git --version').returns(nil)
        end

        it 'expected to return false' do
          expect(Gisdatigo::GitManager.available?).to be_falsey
        end
      end
    end

    describe 'instance' do
      let(:git) { mock('git') }

      before :each do
        Gisdatigo::GitManager.expects(:available?).returns(true)
        Git.expects(:open).with('.').returns(git)
      end

      describe 'has_changes?' do
        let(:status) { mock('status') }

        context 'when there are changes' do
          let!(:changed) { [:revision1, :revision2] }

          before :each do
            status.expects(:changed).returns(changed)
            git.expects(:status).returns(status)
          end

          it 'is expected to return true' do
            subject = Gisdatigo::GitManager.new
            expect(subject.has_changes?).to be_truthy
          end
        end

        context 'when there are no changes' do
          let!(:changed) { [] }

          before :each do
            status.expects(:changed).returns(changed)
            git.expects(:status).returns(status)
          end

          it 'is expected to return true' do
            subject = Gisdatigo::GitManager.new
            expect(subject.has_changes?).to be_falsey
          end
        end
      end

      describe 'commit' do
        subject { Gisdatigo::GitManager.new }

        context 'when there are changes' do
          let(:gem_name) { 'test_gem' }

          before :each do
            subject.expects(:has_changes?).returns(true)
          end

          it 'is expected to call the git commit_all' do
            git.expects(:commit_all).with("Auto updated: #{gem_name}")

            subject.commit(gem_name)
          end
        end

        context 'when there are no changes' do
          before :each do
            subject.expects(:has_changes?).returns(false)
          end

          it 'is expected to return nil' do
            expect(subject.commit('test')).to be_nil
          end
        end
      end

      describe 'reset' do
        subject { Gisdatigo::GitManager.new }

        it 'is expected to call git reset' do
          git.expects(:reset_hard)

          subject.reset
        end
      end
    end
  end
end