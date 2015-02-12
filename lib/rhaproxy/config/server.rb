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
          opt :interface, "Interface to bind the listening port to", :short => "i", :type => :string, :default => '*'
          opt :port, "Port to listen on", :short => "p", :type => :integer, :default => 2323
        end

    

      end

    end
  end
end