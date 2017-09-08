require 'hex_token_bot/version'
require 'hex_token_bot/channel_api'
require 'hex_token_bot/channel_client'
require 'hex_token_bot/bots'
require 'hex_token_bot/bot_server'

require 'yaml'

module HexTokenBot
  class<< self
    attr_accessor :bots, :data_channels, :tran_channels, :tran_users

    def bots_yml=(options = {})
      unless options.empty?
        if options[:file_bots]
          @bots = YAML.load(File.open(options[:file_bots]))
        end
        if options[:file_data_channels]
          @data_channels = YAML.load(File.open(options[:file_data_channels]))
        end
        if options[:file_tran_channels]
          @tran_channels = YAML.load(File.open(options[:file_tran_channels]))
        end
        if options[:file_tran_users]
          @tran_users = YAML.load(File.open(options[:file_tran_users]))
        end
      end
    end
  end

end
