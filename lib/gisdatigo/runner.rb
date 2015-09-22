require 'gisdatigo'

require 'gisdatigo/runner/base'
require 'gisdatigo/runner/pre_processor'
require 'gisdatigo/runner/updater'
require 'gisdatigo/runner/post_processor'

module Gisdatigo
  module Runner
    def self.run
      PreProcessor.new.check
      Updater.new.update
      PostProcessor.new.process
    end
  end
end