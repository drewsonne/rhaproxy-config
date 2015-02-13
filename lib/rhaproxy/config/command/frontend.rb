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

          output = "\nfrontend #{frontend_name}\n"
          output += frontend.config.map {|config_name, config_value|
            if ['default', 'use'].include? config_name
              "#{INDENTATION}#{config_name}#{config_value}"
            else
              "#{INDENTATION}#{config_name} #{config_value}"
            end
          }.join("\n") + "\n"
        end

      end
    end
  end
end
