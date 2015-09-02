require 'gisdatigo'
require 'rails'

module Gisdatigo
  module Rails
    class Railtie < ::Rails::Railtie

      rake_tasks do
        load "tasks/gisdatigo.rake"
      end
    end
  end
end