require 'rhaproxy/config/command/base'
require 'haproxy-tools'

module Rhaproxy
  module Config
    module Command
      class Backend < Base

        def show(*args)
          get_array_attr('backends', @haproxy_config.backends, 'name')
        end

        def get(args)
          backend_name = args.pop
          backend = @haproxy_config.backend(backend_name)

          # Render Options
          output = "\nbackend #{backend_name}\n"
          output += backend.config.map {|config_name, config_value|
            "#{INDENTATION}#{config_name} #{config_value}"
          }.join("\n") + "\n"
          output += backend.options.map {|option_name, option_value|
            "#{INDENTATION}#{option_name} #{option_value}"
          }.join("\n")
          output += backend.servers.map {|server_name, server_data|
            "#{INDENTATION}server #{server_name} " +
            "#{server_data.host}:" +
            "#{server_data.port} " +
            server_data.attributes.map { |attribute_key, attribute_value|
              attribute_key if attribute_value
            }.join(", ")
          }.join("\n")
        end

      end
    end
  end
end
