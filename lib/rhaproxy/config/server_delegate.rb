require 'eventmachine'

module Rhaproxy
  module Config
    class ServerDelegate < EventMachine::Connection

      @haproxy_config
      @is_interactive = false

      def initialize(haproxy_config)
        @haproxy_config = haproxy_config
      end

      def post_init
        puts "-- someone connected to the echo server!"
      end

      def receive_data(data, prompt=false)
        first_line_command = data.split(/[\r\n]+/)[0]
        action, resource, *arguments = first_line_command.split(/(?<!\\) /) # Split tokens by unescaped strings
        case action
          when *%w{get set show add}
            resource = resource.gsub(/s$/, '')
            send_data find_object(resource).send(action, arguments)
            close_connection_after_writing if not @is_interactive
            send_data "\n> "
          when 'help'
            send_data "#{print_help}\n"
            close_connection_after_writing if not @is_interactive
            send_data "\n> "
          when "prompt"
            respond_with_prompt
            send_data "> "
          when "quit"
            close_connection
          else
            raise "Unexpected action '#{action}'."
        end

      end

      def print_help
        Dir.glob("#{File.dirname(__FILE__)}/command/*.rb").map { |filepath|
          filename = File.basename(filepath).gsub(/\.rb$/,'')
          puts filename
          if filename != 'base'
            require filepath
            classname = filename.slice(0,1).capitalize + filename.slice(1..-1)
            Rhaproxy::Config::Command.const_get(classname)::print_help
          else
            nil
          end
        }.compact.join("\n")
      end

      def respond_with_prompt
        @is_interactive = true
      end

      def find_object(resource_name)
        require "rhaproxy/config/command/#{resource_name}"
        classname = resource_name.slice(0,1).capitalize + resource_name.slice(1..-1)
        Rhaproxy::Config::Command.const_get(classname).new(@haproxy_config)
      end

    end
  end
end
