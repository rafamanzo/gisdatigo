require 'optparse'
require "gisdatigo"
require "gisdatigo/version"

module CLI
  def CLI.run(args)
    options = CLI.parse_options(args)

    Gisdatigo.configure_with('.gisdatigo') if File.exists?('.gisdatigo')

    Gisdatigo::Runner.run
  end

  def CLI.parse_options(args)
    OptionParser.new do |parser|
      parser.on_tail('-h', '--help', 'Show this message') do
        Kernel.puts parser
        Kernel.exit
      end

      parser.on_tail('-V', '--version', 'Print version and exit') do
        Kernel.puts Gisdatigo::VERSION
        Kernel.exit
      end
    end.parse(args)
  end
end
