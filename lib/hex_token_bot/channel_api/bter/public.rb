require_relative 'request.rb'
module HexTokenBot
  module ChannelApi
    module Bter
      class Public
        include Request

        METHODS = ['pairs', 'ticker', 'tickers', 'marketinfo', 'markelist', 'trade', 'tradeHistory', 'orderBook']

        METHODS.each do |method|
          define_method(method) do |pair=nil, tid=nil|
            public_request(method, pair, tid)
          end
        end

        alias_method :info, :marketinfo
        alias_method :details, :markelist
        alias_method :trades, :trade
        alias_method :history, :trade
        alias_method :order_book, :orderBook
        alias_method :trade_history, :tradeHistory

      end
    end
  end
end

