module Rhaproxy
  module Config
    module Command
      class Base

        INDT = "    "

        @haproxy_config

        public

        def initialize(haproxy_config)
          @haproxy_config = haproxy_config
        end

        def get(*args)
          throw NotImplementedError
        end

        def set(*args)
          throw NotImplementedError
        end

        def show
          throw NotImplementedError
        end

        def self.print_help
          throw NotImplementedError
        end

        def get_array_attr(group_name, array_struct, attr_name)
          "\n#{group_name}\n" + array_struct.map { |backend|
            INDT + backend.send(attr_name)
          }.join("\n") + "\n"
        end

      end
    end
  end
end
