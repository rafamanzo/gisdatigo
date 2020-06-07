require 'spec_helper'

describe Gisdatigo::GitManager do
  describe 'constructor' do
    context 'when git is available' do
      before :each do
        Gisdatigo::GitManager.expects(:available?).returns(true)
      end

      it 'is expected to open that repository' do
        Rugged::Repository.expects(:new).with('.')

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
      let(:rugged_repository) { mock('rugged_repository') }

      before :each do
        Gisdatigo::GitManager.expects(:available?).returns(true)
        Rugged::Repository.expects(:new).with('.').returns(rugged_repository)
      end

      describe 'has_changes?' do
        let(:index) { mock('index') }
        let(:diff) { mock('diff') }

        context 'when there are changes' do
          let!(:deltas) { [:revision1, :revision2] }

          before :each do
            diff.expects(:deltas).returns(deltas)
            index.expects(:diff).returns(diff)
            rugged_repository.expects(:index).returns(index)
          end

          it 'is expected to return true' do
            subject = Gisdatigo::GitManager.new
            expect(subject.has_changes?).to be_truthy
          end
        end

        context 'when there are no changes' do
          let!(:deltas) { [] }

          before :each do
            diff.expects(:deltas).returns(deltas)
            index.expects(:diff).returns(diff)
            rugged_repository.expects(:index).returns(index)
          end

          it 'is expected to return false' do
            subject = Gisdatigo::GitManager.new
            expect(subject.has_changes?).to be_falsey
          end
        end
      end

      describe 'commit' do
        subject { Gisdatigo::GitManager.new }
        let(:gem_name) { 'test_gem' }

        context 'when there are changes' do
          let(:index) { mock('index') }
          let(:diff) { mock('diff') }
          let(:delta) { mock('delta') }
          let(:head) { mock('head') }
          let(:head_target) { mock('head_target') }
          let(:head_target_tree) { mock('head_target_tree') }

          before :each do
            subject.expects(:has_changes?).returns(true)

            head_target.expects(:tree).returns(head_target_tree)
            head.expects(:target).at_least_once.returns(head_target)
            rugged_repository.expects(:head).at_least_once.returns(head)
            index.expects(:read_tree).with(head_target_tree)

            diff.expects(:each_delta).yields(delta)
            index.expects(:diff).returns(diff)
            rugged_repository.expects(:index).at_least_once.returns(index)
          end

          context 'and all the changes are modifications' do
            let(:commit_tree) { mock('commit_tree') }
            let(:commit_options) {
              {
                message: "Auto updated: #{gem_name}",
                parents: [head_target],
                tree: commit_tree,
                update_ref: 'HEAD'
              }
            }
            let(:old_file) { {path: 'object/path' } }

            before do
              index.expects(:write_tree).with(rugged_repository).returns(commit_tree)

              delta.expects(:old_file).returns(old_file)
              delta.expects(:status).returns(:modified)
            end

            it 'is expected to commit all modified deltas' do
              index.expects(:add).with(old_file[:path])
              index.expects(:write)
              Rugged::Commit.expects(:create).with(rugged_repository, commit_options)

              subject.commit(gem_name)
            end
          end

          context 'and there are other changes than modifications' do
            before do
              delta.expects(:status).returns(:deleted)
            end

            it 'is expected to raise a RuntimeError' do
              expect { subject.commit(gem_name) }.to raise_error(RuntimeError)
            end
          end
        end

        context 'when there are no changes' do
          before :each do
            subject.expects(:has_changes?).returns(false)
          end

          it 'is expected to return nil' do
            expect(subject.commit(gem_name)).to be_nil
          end
        end
      end

      describe 'reset' do
        subject { Gisdatigo::GitManager.new }
        let(:head) { mock('head') }

        before do
          rugged_repository.expects(:head).returns(head)
        end

        it 'is expected to perform a hard git reset to HEAD' do
          rugged_repository.expects(:reset).with(head, :hard)

          subject.reset
        end
      end
    end
  end
end
