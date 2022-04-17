require 'faraday'
require 'nokogiri'
require 'date'

class RwChecker
  def initialize
    # @interesting_train_ids = [
    #   '1_701Б_1567787820_1567800240',
    #   '1_711Б_1567790160_1567803120',
    # ]
    #test
    @interesting_train_ids = [
      '1_027Б_1568582760_1568601600',
    ]
    @allert_message = "ALLERT!!!\nTrain FOUNDED!!"
    @sleep_sec = 180
  end

  def rw_url
    @rw_url ||=
      begin
        from = 'Минск-Пассажирский'
        to = 'Брест'
        # date = (Date.today + 1).to_s
        date = '2019-09-16'
        "https://rasp.rw.by/ru/route/?from=#{from}&to=#{to}&date=#{date}"
      end
  end

  def call
    loop do
      page = fetch_data_from_url

      @interesting_train_ids.each do |train_id|
        if page.css("tr\##{train_id} li.train_price span").empty?
          puts "TrainID #{train_id} - nothing found"
          next
        else
          success_notify
        end
      end
      sleep @sleep_sec
    end
  end

  def mac_os?
    Gem::Platform.local.os == 'darwin'
  end

  def success_notify
    puts @allert_message
    puts `osascript -e 'display notification "#{@allert_message}" with title "Greetings"'` if mac_os?
  end

  def fetch_data_from_url
    puts "Fetching data from #{rw_url}\n"
    response = Faraday.get(URI.encode(rw_url))
    Nokogiri::HTML(response.body)
  end
end

RwChecker.new.call
