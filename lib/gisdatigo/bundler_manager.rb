require 'gisdatigo'

module Gisdatigo
  class BundlerManager
    GEM_LINE_BEGINNING = "  * "

    def self.gem_name_list
      outdated_raw = `bundle outdated`.split("\n")
      outdated_gems = outdated_raw.delete_if { |line| !line.start_with?(GEM_LINE_BEGINNING)}
      outdated_gems.map { |gem_line| gem_line.gsub(GEM_LINE_BEGINNING, '').split(" ")[0] }
    end

    def self.update_gem(gem_name, opts=[])
      system("bundle update #{opts.join(' ')} #{gem_name} > /dev/null 2>&1")
    end
  end
end
