require 'spec_helper'

describe Gisdatigo::BundlerManager do
  describe 'methods' do
    describe 'update_gem' do
      let(:gem_name) { 'gisdatigo' }
      let(:options) { ['--conservative'] }

      it 'is expected to call the test command in the system' do
        Gisdatigo::BundlerManager.expects(:system).with("bundle update #{options.join(' ')} #{gem_name} > /dev/null 2>&1").returns(true)

        Gisdatigo::BundlerManager.update_gem(gem_name, options)
      end
    end

    describe 'gem_name_list' do
      before :each do
        Gisdatigo::BundlerManager.expects(:`).with('bundle outdated').returns("
Fetching gem metadata from https://rubygems.org/.........
Fetching version metadata from https://rubygems.org/..
Resolving dependencies....

  * gisdatigo"
        )
      end

      it 'is expected to parse the bundle outdated command output into a gem list' do
        expect(Gisdatigo::BundlerManager.gem_name_list).to eq(['gisdatigo'])
      end
    end
  end
end
