require "gisdatigo/version"

require "gisdatigo/git_manager"
require "gisdatigo/bundler_manager"
require "gisdatigo/test_manager"
require "gisdatigo/runner"
require "gisdatigo/rails/railtie"

module Gisdatigo
  @configurations = {
    test_command: 'rake'
  }
  @valid_configuration_keys = @configurations.keys

  # Configure through Hash
  def Gisdatigo.configure(opts = {})
    opts.each do |key,value|
      if @valid_configuration_keys.include? key.to_sym
        @configurations[key.to_sym] = value
      end
    end
  end

  # Configure through yaml file
  def Gisdatigo.configure_with(path_to_yaml_file)
    begin
      config = YAML.load_file(path_to_yaml_file)
      configure(config)
    rescue Errno::ENOENT
      warn "YAML configuration file couldn't be found. Using defaults."
    rescue Psych::SyntaxError
      warn "YAML configuration file contains invalid syntax. Using defaults."
    end
  end

  def Gisdatigo.configurations
    @configurations
  end
end
