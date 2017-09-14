module HexTokenBot
  module ChannelClient
    class OkcoinClient
      attr_accessor :client

      def initialize(options = {})
        url = options['endpoint'] || HexTokenBot.data_channels['okcoin']['endpoint']
        api_key = options['access_key'] || HexTokenBot.data_channels['okcoin']['access_key']
        secret_key = options['secret_key'] || HexTokenBot.data_channels['okcoin']['secret_key']

        @client = Okcoin::Client.new url: url, api_key: api_key, secret_key: secret_key
      end


      def get_market_order_book(market_code, asks_limit = nil , bids_limit = nil)
        rep = client.trades(symbol: market_code, since: nil)
        rep
      end

      def get_order_newest(market_code)
        rep = client.trades(symbol: market_code, since: nil)
        if rep.class == Array and !rep.empty?
          count = rep.size
          rep[count - 1]
        else
          []
        end
      end

      def send_order(side, market_code, price, volume)
        rep = client.trade(symbol: market_code, type: side, price: price, amount: volume)
        rep
      end

      #orders: [{type: 'buy', amount: '0.15', price: '2955.0'}, {side: 'sell', volume: '0.16', price: '2956'}]
      def send_orders_multi(orders, market_code)
        rep = client.batch_trade(symbol: market_code, orders_data: orders)
        rep
      end

      def send_order_buy(market_code, price, volume)
        send_order('buy', market_code, price, volume)
      end

      def send_order_sell(market_code, price, volume)
        send_order('sell', market_code, price, volume)
      end

    end
  end
end