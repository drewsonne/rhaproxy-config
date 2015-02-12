require 'rhaproxy/config/command/base'
module Rhaproxy
  module Config
    module Command
      class Server < Base

        def show
          "server_list"
        end

      end
    end
  end
end
