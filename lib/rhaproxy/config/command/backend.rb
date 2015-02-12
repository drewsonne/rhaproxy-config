require 'rhaproxy/config/command/base'
require 'haproxy-tools'

module Rhaproxy
  module Config
    module Command
      class Backend < Base

        def show(*args)
          print_array_attr('backends', @haproxy_config.backends, 'name')
        end

        def get(args)
          backend_name = args.pop
          backend = @haproxy_config.backend(backend_name)
          renderer = HAProxy::Renderer.new(backend, backend.options)
          renderer.render
        end

      end
    end
  end
end
