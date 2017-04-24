module Dry
  module System
    class MagicCommentsParser
      VALID_LINE_RE = /^(#.*)?$/.freeze
      COMMENT_RE = /^#\s+(?<name>[A-Za-z]{1}[A-Za-z0-9_]+):\s+(?<value>.+?)$/.freeze

      def self.call(file_name)
        {}.tap do |options|
          File.foreach(file_name) do |line|
            break if !line.match?(VALID_LINE_RE)

            if (comment = line.match(COMMENT_RE))
              options[comment[:name].to_sym] = comment[:value]
            end
          end
        end
      end
    end
  end
end
