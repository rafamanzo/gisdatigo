require 'spec_helper'
require 'cli'

describe CLI do
  describe 'run' do
    let(:args) { [] }

    it 'is expected to parse the options and call the runner' do
      described_class.expects(:parse_options).with(args)
      File.expects(:exists?).with('.gisdatigo').returns(true)
      Gisdatigo.expects(:configure_with).with('.gisdatigo')
      Gisdatigo::Runner.expects(:run)

      described_class.run args
    end
  end

  describe 'parse_options' do
    let(:args) { [] }

    context 'when passing the help flag' do
      let(:args) { ['--help'] }
      let(:message) { '' }

      it 'is expected to print a message and exit' do
        Kernel.expects(:puts).with(instance_of(OptionParser))
        Kernel.expects(:exit)

        described_class.parse_options(args)
      end
    end

    context 'when passing the version flag' do
      let(:args) { ['--version'] }
      let(:message) { '' }

      it 'is expected to print a message and exit' do
        Kernel.expects(:puts).with(Gisdatigo::VERSION)
        Kernel.expects(:exit)

        described_class.parse_options(args)
      end
    end

    context 'with no arguments' do
      let(:args) { [] }

      it 'is expected to be return empty options' do
        expect(described_class.parse_options(args).to_a).to be_empty
      end
    end
  end
end
