require 'rhaproxy/config/command/base'
module Rhaproxy
  module Config
    module Command
      class Server < Base

        def self.print_help
          %q{show server [backend_name]
get server [backend_name]/[server_name]}
        end

        def show(args)
          backend_name = args.pop
          output = "\nbackend #{backend_name}\n"
          output += print_servers(@haproxy_config.backend(backend_name))
        end

        def get(args)
          backend_name, server_name = args[0].split("/")
          "\n#{print_server(server_name, @haproxy_config.backend(backend_name).servers[server_name])}\n"
        end

        private

        def print_servers(backend)
          "#{backend.servers.map {|server_name, server_data|
            print_server(server_name, server_data, INDT)
          }.join("\n")}\n"
        end

        def print_server(server_name, server_data, indentation='')
          "#{indentation}server #{server_name} " +
          "#{server_data.host}:" +
          "#{server_data.port} " +
          server_data.attributes.map { |attribute_key, attribute_value|
            attribute_key if attribute_value
          }.join(", ")
        end

      end
    end
  end
end
