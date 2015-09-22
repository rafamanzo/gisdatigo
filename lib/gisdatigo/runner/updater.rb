module Gisdatigo
  module Runner
    class Updater < Base
      def update
        puts "Running updates:"

        print "\tFetching outdated list..."
        outdated_list = BundlerManager.gem_name_list
        print "OK!\n"

        current_package = 1
        outdated_list.each do |gem_name|
          puts "\t#{current_package}/#{outdated_list.count} - Updating #{gem_name}"
          BundlerManager.update_gem(gem_name)
          if @git_manager.has_changes?
            test("ERROR: Failed to update #{gem_name}! Tests were broken!")
            @git_manager.commit(gem_name)
          end
          current_package = current_package + 1
        end
      end
    end
  end
end