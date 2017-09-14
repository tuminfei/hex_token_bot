module HexTokenBot
  module ChannelClient
    class BterClient
      attr_accessor :client

      def initialize(options = {})
        @client = HexTokenBot::ChannelApi::Bter::Public.new
      end


      def get_market_order_book(market_code, asks_limit = nil , bids_limit = nil)
        rep = @client.order_book(market_code)
        rep
      end

      def get_order_newest(market_code)
        rep = @client.trade_history(market_code)
        unless rep[:data].nil?
          count = rep[:data].size
          rep[:data][count - 1]
        else
          []
        end
      end
    end
  end
end