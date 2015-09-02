require 'gisdatigo'

module Gisdatigo
  class TestManager
    def self.check_units
      system('rake spec &> /dev/null')
    end
  end
end