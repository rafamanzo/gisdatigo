module Gisdatigo
  module Runner
    class Base
      def initialize
        @git_manager = GitManager.new
      end

      protected

      def test(error_message)
        print "\tRunning tests..."
        if TestManager.check_units
          print "OK!\n"
        else
          STDERR.puts(error_message)
          @git_manager.reset
          exit(1)
        end
      end
    end
  end
end