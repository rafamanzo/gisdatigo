require 'gisdatigo'

namespace :gisdatigo do
  desc 'Automated gem updates'
  task :run do
    Gisdatigo::Runner.new.run
  end
end