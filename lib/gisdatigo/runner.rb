require 'gisdatigo'

module Gisdatigo
  class Runner
    def initialize
      @git_manager = GitManager.new
    end

    def run
      pre_check
      update
      post_process
    end

    private

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

    def pre_check
      puts "Prechecking the state:"
      test("Your application has failling tests, please fix them!")
    end

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

    def post_process
      puts "Post processing:"
      print "\tFetching outdated list..."
      remaing_outdated_list = BundleManager.gem_name_list
      print "OK!\n"

      puts "\tThe following gems could not be updated and may require manual action:"
      remaing_outdated_list.each do |gem_name|
        puts "\t\t#{gem_name}"
      end
    end
  end
end