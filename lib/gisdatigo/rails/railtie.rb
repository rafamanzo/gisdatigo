require 'gisdatigo'
require 'rails'

module Gisdatigo
  module Rails
    class Railtie < ::Rails::Railtie
      # Testing this require to load it inside a rails app
      # So this unique line is not worth the cost so far
      # :nocov:
      rake_tasks do
        load "tasks/gisdatigo.rake"
      end
      # :nocov:
    end
  end
end