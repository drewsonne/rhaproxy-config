require 'eventmachine'

module Rhaproxy
  module Config
    class ServerDelegate < EventMachine::Connection

      @haproxy_config

      def initialize(haproxy_config)
        @haproxy_config = haproxy_config
      end

      def post_init
        puts "-- someone connected to the echo server!"
      end

      def receive_data(data, prompt=false)
        first_line_command = data.split(/[\r\n]+/)[0]
        action, resource, *arguments = first_line_command.split(/(?<!\\) /) # Split tokens by unescaped strings
        if action == 'prompt'
          response_with_prompt
        else
          case action
            when *%w{get set show}
              resource = resource.gsub(/s$/, '')
              send_data find_object(resource).send(action, arguments) + "\n"
            else
              raise "Unexpected action '#{action}'."
          end
        end
      end

      def response_with_prompt
        send_data "> "
      end

      def find_object(resource_name)
        require "rhaproxy/config/command/#{resource_name}"
        class_name = resource_name.slice(0,1).capitalize + resource_name.slice(1..-1)
        Rhaproxy::Config::Command.const_get(class_name).new(@haproxy_config)
      end

    end
  end
end
