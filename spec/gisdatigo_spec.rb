require 'spec_helper'

describe Gisdatigo do
  it 'has a version number' do
    expect(Gisdatigo::VERSION).not_to be nil
  end

  describe 'configuration' do
    describe 'configurations' do
      it 'is expected to return the configurations Hash' do
        expect(Gisdatigo.configurations[:test_command]).to_not be_nil
      end
    end

    describe 'configure' do
      context 'with a valid configuration' do
        let(:configuration) { {test_command: 'test'} }

        it 'is expected to set the configuration value' do
          Gisdatigo.configure configuration

          expect(Gisdatigo.configurations[:test_command]).to eq configuration[:test_command]
        end
      end

      context 'with an invalid configuration' do
        let(:configuration) { {not_valid: 'test'} }

        it 'is expected to keep the default' do
          previous = Gisdatigo.configurations

          Gisdatigo.configure configuration

          expect(Gisdatigo.configurations).to eq previous
        end
      end
    end

    describe 'configure_with' do
      let(:file_path){ 'file' }

      context 'with a existent file' do
        context 'with correct synthax' do
          let!(:loaded_file){ mock('loaded_file') }

          before :each do
            YAML.expects(:load_file).with(file_path).returns(loaded_file)
          end

          it 'is expected to call the configure method' do
            Gisdatigo.expects(:configure).with(loaded_file)

            Gisdatigo.configure_with(file_path)
          end
        end

        context 'with broken synthax' do
          before :each do
            YAML.expects(:load_file).with(file_path).raises(Psych::SyntaxError.new(0, 0, 0, 0, 0, 0))
          end

          it 'is expected to print a warn and keep the defaults' do
            Gisdatigo.expects(:warn).with("YAML configuration file contains invalid syntax. Using defaults.")

            Gisdatigo.configure_with(file_path)
          end
        end
      end

      context 'with an absent file' do
        before :each do
          YAML.expects(:load_file).with(file_path).raises(Errno::ENOENT)
        end

        it 'is expected to print a warn and keep the defaults' do
          Gisdatigo.expects(:warn).with("YAML configuration file couldn't be found. Using defaults.")

          Gisdatigo.configure_with(file_path)
        end
      end
    end
  end
end
