module Gisdatigo
  module Runner
    class PostProcessor < Base
      def process
        puts "Post processing:"
        print "\tFetching outdated list..."
        remaing_outdated_list = BundlerManager.gem_name_list
        print "OK!\n"

        puts "\tThe following gems could not be updated and may require manual action:"
        remaing_outdated_list.each do |gem_name|
          puts "\t\t#{gem_name}"
        end
      end
    end
  end
end