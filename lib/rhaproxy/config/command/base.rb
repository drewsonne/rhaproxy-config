module Rhaproxy
  module Config
    module Command
      class Base

        public

        def get(*args)
          throw NotImplementedError
        end

        def set(*args)
          throw NotImplementedError
        end

        def show
          throw NotImplementedError
        end

      end
    end
  end
end
