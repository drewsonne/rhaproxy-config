require 'rhaproxy/config/command/base'
require 'haproxy-tools'

module Rhaproxy
  module Config
    module Command
      class Frontend < Base

        def show(*args)
          get_array_attr('frontends', @haproxy_config.frontends, 'name')
        end

        def get(args)
          frontend_name = args.pop
          frontend = @haproxy_config.frontend(frontend_name)
          raise StandardError
        end

      end
    end
  end
end
