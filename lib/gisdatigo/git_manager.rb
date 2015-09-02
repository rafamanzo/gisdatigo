require 'gisdatigo'
require 'git'

module Gisdatigo
  class GitManager
    def initialize
      if self.class.available?
        @git = Git.open('.')
      else
        STDERR.puts "Git is not available in the system"
      end
    end

    def self.available?
      git_version = `git --version`
      if git_version.nil?
        return false
      else
        return true
      end
    end

    def commit(gem_name)
      @git.commit_all("Auto updated: #{gem_name}") if @git.status.changed.count > 0
    end

    def has_changes?
      @git.status.changed.count > 0
    end

    def reset
      @git.reset_hard
    end
  end
end