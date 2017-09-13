require 'rufus-scheduler'

module HexTokenBot
  class BotServer
    attr_accessor :scheduler
    attr_accessor :bot_servers

    def initialize

      @scheduler = Rufus::Scheduler.new

      HexTokenBot.bots.each do |bot|
        case bot['bot_name']
          when 'bot_auto_trans'
            when_ever = bot['bot_params']['when_ever']
            puts '--------------------'
            HexTokenBot::Bots::BotAutoTrans.set(:name, bot['bot_name'])
            @scheduler.every when_ever||'3s', :tag => bot['bot_name'] do
              puts 'Hello... Bots'
              HexTokenBot::Bots::BotAutoTrans.set(:channels, bot['bot_data_channels'])
              HexTokenBot::Bots::BotAutoTrans.set(:markets, bot['bot_markets'])
              HexTokenBot::Bots::BotAutoTrans.run!
            end
        end
      end
    end
  end
end