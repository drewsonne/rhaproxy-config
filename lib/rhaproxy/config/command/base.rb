module Rhaproxy
  module Config
    module Command
      class Base

        INDENTATION = "    "

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

        def get_array_attr(group_name, array_struct, attr_name)
          "\n#{group_name}\n" + array_struct.map { |backend|
            INDENTATION + backend.send(attr_name)
          }.join("\n")
        end

      end
    end
  end
end
