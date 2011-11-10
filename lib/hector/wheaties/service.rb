module Hector
  module Wheaties
    class Service < Hector::Service
      def received_privmsg
        intercept(command_pattern) do |line, name|
          # TODO Act on a command
        end
      end

      def command_pattern
        /^[!\.](\S+)?/
      end
    end
  end
end
