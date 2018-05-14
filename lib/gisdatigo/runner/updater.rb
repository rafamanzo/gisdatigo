module Gisdatigo
  module Runner
    class Updater < Base
      def update
        puts "Running updates:"
        outdated_list = fetch_outdated_list
        update_gems_with_options(outdated_list, ['--conservative'])
      end

      private

      def update_gems_with_options(outdated_list, options)
        current_package = 1

        outdated_list.each do |gem_name|
          puts "\t#{current_package}/#{outdated_list.count} - Updating #{gem_name}"
          BundlerManager.update_gem(gem_name, options)
          commit(gem_name)
          current_package = current_package + 1
        end
      end

      def fetch_outdated_list
        print "\tFetching outdated list..."
        outdated_list = BundlerManager.gem_name_list
        print "OK!\n"

        outdated_list
      end

      def commit(gem_name)
        if @git_manager.has_changes?
          test("ERROR: Failed to update #{gem_name}! Tests were broken!")
          @git_manager.commit(gem_name)
        end
      end
    end
  end
end
