require 'rhaproxy/config/command/server'
require 'haproxy-tools'

module Rhaproxy
  module Config
    module Command
      class Backend < Server

        def show(*args)
          get_array_attr('backends', @haproxy_config.backends, 'name')
        end

        def get(args)
          backend_name = args.pop
          backend = @haproxy_config.backend(backend_name)

          # Render Options
          output = "\nbackend #{backend_name}\n"
          output += backend.config.map  { |k, v| "#{INDT}#{k} #{v}\n" }.join
          output += backend.options.map { |k, v| "#{INDT}#{k} #{v}\n" }.join
          output += print_servers(backend)
        end

      end
    end
  end
end
