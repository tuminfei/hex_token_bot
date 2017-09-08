require 'logger'

module HexTokenBot
  module Bots
    module Info
      def logger_set!(cond)
        @logger = Logger.new STDOUT
        @logger.level = cond ? Logger::DEBUG : Logger::INFO
      end

      def info(msg)
        @logger.info msg
      end

      def warn(msg)
        @logger.warn msg
      end

      def error(msg)
        @logger.error msg
      end

      def debug(msg)
        @logger.debug msg
      end
    end

    class Base
      include HexTokenBot::Bots::Info

      def self.run!
        self.new.run
      end

      def initialize
        logger_set! debug?
      end

      def debug?
        nil
      end

      class << self
        def set(key, value)
          keys = [:name, :debug?, :channels, :markets]
          if keys.include? key
            self.instance_eval do
              define_method key, lambda { value }
              private key
            end
          else
            raise NotImplementedError, "This option is not support, #{key}, #{value}"
          end
        end

        def set!(key, value)
          keys = [:run?]
          if keys.include? key
            define_singleton_method key, value
          else
            raise NotImplementedError, "This option is not support, #{key}, #{value}"
          end
        end
      end

    end
  end
end

