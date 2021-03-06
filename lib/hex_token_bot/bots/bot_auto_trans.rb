require 'hex_token_bot/bots/base'

module HexTokenBot
  module Bots
    class BotAutoTrans < Base
      def run
        info "starting bot for @#{name}"
        begin
          #查询渠道数据
          source_data = {}
          #查询渠道数据-渠道最大值
          source_max_data = {}
          #查询本地数据-本地最大值
          local_max_data = {}
          channels.each do |c|
            channel = HexTokenBot.data_channels[c]
            if channel
              if channel['client'] == HexTokenBot::ChannelClient::CHANNEL_BTER
                client = HexTokenBot::ChannelClient::BterClient.new
                markets.each do |m|
                  m_code = m['base_unit'] + '_' + m['quote_unit']
                  rep = client.get_order_newest(m_code)
                  source_rate = source_data[m['id']] || []
                  price = rep.empty? ? 0 : rep[:rate]
                  source_rate << price
                  source_data.store(m['id'], source_rate)
                end
              end
              if channel['client'] == HexTokenBot::ChannelClient::CHANNEL_HEX
                client = HexTokenBot::ChannelClient::HexClient.new
                markets.each do |m|
                  m_code = m['base_unit'] + m['quote_unit']
                  rep = client.get_order_newest(m_code)
                  source_rate = source_data[m['id']] || []
                  price = rep.empty? ? 0 : rep['price'].to_f
                  source_rate << price
                  source_data.store(m['id'], source_rate)
                end
              end
              if channel['client'] == HexTokenBot::ChannelClient::CHANNEL_OKCOIN
                client = HexTokenBot::ChannelClient::OkcoinClient.new
                markets.each do |m|
                  m_code = m['base_unit'] + '_' + m['quote_unit']
                  rep = client.get_order_newest(m_code)
                  source_rate = source_data[m['id']] || []
                  price = rep.empty? ? 0 : rep['price'].to_f
                  source_rate << price
                  source_data.store(m['id'], source_rate)
                end
              end
            end
          end

          info "抓取渠道数据：#{source_data.to_s}"

          #查询本地数据
          local = HexTokenBot.tran_channels['hex'].symbolize_keys
          client = HexTokenBot::ChannelClient::HexClient.new(local)
          markets.each do |m|
            market_code = m['id']
            rep = client.get_order_newest(market_code)
            local_rate = rep.empty? ? 0 : rep['price'].to_f
            local_max_data.store(m['id'], local_rate)
          end

          info "抓取本地数据：#{local_max_data.to_s}"

          #数据分析处理
          markets.each do |m|
            market_code = m['id']
            source_arr = source_data[market_code] || []
            source_max = source_arr.max
            source_max_data.store(market_code, source_max)
            #如果渠道挂单价格 >= 本地挂单价格，直接生成买单吃用户的单
            #如果渠道挂单价格 < 本地挂单价格，直接生成买单吃用户的单

            if source_max >= local_max_data[market_code]
              price = local_max_data[market_code]
              #插入数据
              buy = HexTokenBot.tran_users['buyer'].symbolize_keys
              client = HexTokenBot::ChannelClient::HexClient.new(buy)
              rep = client.send_order_buy(market_code, price, m['tran_amount'])
              info "auto_tran:#{rep.to_s}"
            else
              price = local_max_data[m['id']] + m['tran_price_add']
              #插入数据
              buy = HexTokenBot.tran_users['buyer'].symbolize_keys
              client = HexTokenBot::ChannelClient::HexClient.new(buy)
              rep = client.send_order_buy(market_code, price, m['tran_amount'])
              info "auto_tran:#{rep.to_s}"
              seller = HexTokenBot.tran_users['seller'].symbolize_keys
              client = HexTokenBot::ChannelClient::HexClient.new(seller)
              rep = client.send_order_sell(market_code, price, m['tran_amount'])
              info "auto_tran:#{rep.to_s}"
            end
          end

        rescue Exception => err
          info "exitting bot service for @#{name}..."
          info err.message
          exit 0
        end
      end
    end
  end
end
