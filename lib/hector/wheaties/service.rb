module Hector
  module Wheaties
    class Service < Hector::Service
      attr_writer :prefix
      
      def received_privmsg
        intercept(pattern) do |line, name|
          # TODO Act on a command
        end
      end
      
      def match(input)
        if input =~ pattern
          match = CommandMatch.new
          match.prefix = $~[:prefix]
          match.command = $~[:command]
          args = $~[:args]
          if args =~ /(?<args>.*)\s+>+\s*(?<target>.*?)\s*$/
            match.args = $~[:args]
            match.target = $~[:target]
          else
            match.args = args
          end
          match
        end
      end
      
      def pattern
        /^(?<prefix>#{prefix})(?<command>\S+)(?:\s+(?<args>.*))?/
      end
      
      def prefix
        if @prefix
          @prefix.is_a?(Regexp) ? @prefix : /#{Regexp.escape(@prefix.to_s)}/
        else
          /[!\.]/
        end
      end
    end
  end
end
