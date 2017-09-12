require_relative 'channel_client/bter_client'
require_relative 'channel_client/hex_client'
require_relative 'channel_client/okcoin_client'

module HexTokenBot
  module ChannelClient
    CHANNEL_BTER = 'bter'
    CHANNEL_HEX = 'hex'
    CHANNEL_OKCOIN = 'okcoin'
  end
end