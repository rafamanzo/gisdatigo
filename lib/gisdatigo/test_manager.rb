require 'gisdatigo'

module Gisdatigo
  class TestManager
    def self.check_units
      system("#{Gisdatigo.configurations[:test_command]} &> /dev/null")
    end
  end
end