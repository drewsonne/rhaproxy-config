require 'eventmachine'

module Rhaproxy
  module Config
    module Server

      def post_init
        puts "-- someone connected to the echo server!"
      end

      def receieve_data(data)
        send_data ">>> you sent: #{data}"
      end

    end
  end
end
