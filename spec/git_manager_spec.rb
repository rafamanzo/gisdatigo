require 'spec_helper'

describe Gisdatigo::GitManager do
  describe 'constructor' do
    pending
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
  end
end