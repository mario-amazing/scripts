require 'nokogiri'
require 'open-uri'
require 'parallel'
require 'neatjson'

# !!!!! MANUAL !!!!!!!! => needs js loaded data
# @all_cards_url = 'https://berserk.ru/?route=catalog/cards&results_per_page=3000&sort=name&order=ASC'
# let list = [];
# $("a.card").each((i, el) => { list.push(el.href); });
# console.log(list.join(','));
#copy to tmp.txt

class BerserkRuGrabber
  def initialize
    @cards_urls = File.read("tmp.txt").strip.split(',')
  end

  def call
    data = @cards_urls.map { |url| fetch_card_data(url) }
    # data = Parallel.map(@cards_urls, in_threads: 8) { |url| fetch_card_data(url) }

    File.write('card_base.json', JSON.neat_generate(data))
  end

  def fetch_card_data(url)
    response = URI.open(url, ssl_verify_mode: 0).read
    html = Nokogiri::HTML(response)
    card_data = {}
    card_data['card_url'] = url
    card_data['card_id'] = url.split('card_id=')[1]
    card_data['imgae_url'] = html.css(".image>img").attr('src').value
    card_data['name'] = html.css("div.desc-title>h2").text

    card_data['rarity'] = html_find_card_contains(html, 'Редкость')
    card_data['release_name'] = html_find_card_contains(html, 'Выпуск')
    card_data['number'] = html_find_card_contains(html, 'Номер')
    card_data['element'] = html_find_card_contains(html, 'Стихия')
    card_data['cost'] = html_find_card_contains(html, 'Стоимость')
    card_data['health'] = html_find_card_contains(html, 'Здоровье')
    card_data['damage'] = html_find_card_contains(html, 'Простой удар')

    card_data['description'] = html.css("div.col-md-4").text.split.join(' ')
    card_data
  end

  def html_find_card_contains(html, key)
    html.css("p:contains('#{key}')").text.split(':')[1].split.join(' ')
  rescue
  end
end

BerserkRuGrabber.new.call
