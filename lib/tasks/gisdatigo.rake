require 'gisdatigo'

namespace :gisdatigo do
  desc 'Automated gem updates'
  task :run do
    Gisdatigo::Runner.run
  end
end