require 'trollop'
require 'eventmachine'
require 'haproxy-tools'
require 'rhaproxy/config/server_delegate'


module Rhaproxy
  module Config
    module Server

      def post_init
        puts "-- someone connected to the server"
      end

      def receive_data data
        send_data ">> you sent: #{data}"
      end

      def self.run(arguments)
        cli_options = Trollop::options arguments do
          opt :config, "Absolute path for haproxy config file", :short => "C", :type => :string, :required => true
          opt :interface, "Interface to bind the listening port to", :short => "i", :type => :string, :default => '0.0.0.0'
          opt :port, "Port to listen on", :short => "p", :type => :integer, :default => 2323
        end

        haproxy_config = HAProxy::Config.parse_file(File.expand_path(cli_options.config))

        EventMachine.run {

          Signal.trap('INT')  { EventMachine.stop }
          Signal.trap('TERM') { EventMachine.stop }

          EventMachine.start_server cli_options.interface, cli_options.port, Rhaproxy::Config::ServerDelegate, haproxy_config
        }

      end

    end
  end
end

if __FILE__ == $0
  Rhaproxy::Config::Server.run(ARGV)
end