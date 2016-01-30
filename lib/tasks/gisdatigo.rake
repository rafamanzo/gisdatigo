require 'gisdatigo'

namespace :gisdatigo do
  desc 'Automated gem updates'
  task :run do
    Gisdatigo.configure_with('.gisdatigo') if File.exists?('.gisdatigo')
    Gisdatigo::Runner.run
  end
end