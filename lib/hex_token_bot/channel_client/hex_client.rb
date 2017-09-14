module HexTokenBot
  module ChannelClient
    class HexClient
      attr_accessor :client

      def initialize(options = {})
        client_options = {
            access_key: HexTokenBot.tran_channels['hex']['access_key'],
            secret_key: HexTokenBot.tran_channels['hex']['secret_key'],
            endpoint: HexTokenBot.tran_channels['hex']['endpoint'],
            timeout: HexTokenBot.tran_channels['hex']['timeout']
        }
        @client = PeatioAPI::Client.new client_options.merge(options)
      end


      def get_market_order_book(market_code, asks_limit = nil , bids_limit = nil)
        rep = client.get '/api/v2/order_book', market: market_code
        rep
      end

      def get_order_newest(market_code)
        rep = client.get '/api/v2/trades', market: market_code
        if rep.class == Array and !rep.empty?
          count = rep.size
          rep[count - 1]
        else
          []
        end
      end

      def send_order(side, market_code, price, volume)
        rep = client.post '/api/v2/orders', market: market_code, price: price, side: side, volume: volume
        rep
      end

      #orders: [{side: 'buy', volume: '0.15', price: '2955.0'}, {side: 'sell', volume: '0.16', price: '2956'}]
      def send_orders_multi(orders, market_code)
        rep =  client.post '/api/v2/orders/multi', market: market_code, orders: orders
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