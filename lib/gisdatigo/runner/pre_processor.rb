module Gisdatigo
  module Runner
    class PreProcessor < Base
      def check
        puts "Prechecking the state:"
        test("Your application has failling tests, please fix them!")
      end
    end
  end
end
