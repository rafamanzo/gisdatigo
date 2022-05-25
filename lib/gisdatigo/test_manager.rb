require 'gisdatigo'

module Gisdatigo
  class TestManager
    def self.check_units
      system("#{Gisdatigo.configurations[:test_command]} > /dev/null 2>&1")
    end
  end
end
