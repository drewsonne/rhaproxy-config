require 'rhaproxy/config/command/base'
require 'haproxy-tools'

module Rhaproxy
  module Config
    module Command
      class Default < Base

        def self.print_help
          %q{show defaults
get default [config_name]}
        end

        def show(*args)
          output = "\ndefaults\n"
          output += @haproxy_config.defaults[0].config.map {|default_name, default_value|
            "#{INDT}#{default_name} #{default_value}"
          }.join("\n")
        end

        def get(args)
          frontend_name = args.pop
          frontend = @haproxy_config.frontend(frontend_name)

          output = "\nfrontend #{frontend_name}\n"
          output += frontend.config.map {|config_name, config_value|
            if ['default', 'use'].include? config_name
              "#{INDT}#{config_name}#{config_value}"
            else
              "#{INDT}#{config_name} #{config_value}"
            end
          }.join("\n") + "\n"
        end

      end
    end
  end
end
