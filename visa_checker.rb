#!/usr/bin/env ruby
require 'faraday'

class VisaChecker
  URL = 'https://lift-api.vfsglobal.com/appointment/slots'
  # CODES = %w[BRE POST-BRST POST-MIN POL-MIN PIN ]
  CODES = %w[POL-MIN]
  # CODES = %w[LID]
  # url = 'https://lift-api.vfsglobal.com/appointment/slots?countryCode=blr&missionCode=pol&centerCode=BRE&loginUser=marian1amazing%40gmail.com&visaCategoryCode=02&languageCode=ru-RU&applicantsCount=1&days=90&fromDate=24%2F09%2F2021&slotType=2&toDate=23%2F12%2F2021'
  def initialize
    @authorization = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiSW5kaXZpZHVhbCIsInVzZXJJZCI6Imx0eEZPRm53cjBGbWlkaWF6YW02WWc9PSIsImVtYWlsIjoiTm1NWk1saVc4V25oTkVDMlkwMkRMKzhsTnhNQ3BTaG41eTFBNGsrNzRIdm9rSklERW1zM0FuVzNhUDNURXh6NCIsIm5iZiI6MTYzNjYzNDM1NSwiZXhwIjoxNjM2NjQwMzU1LCJpYXQiOjE2MzY2MzQzNTV9.C2OUjeQpqISD8Rp2lvzua35-G6gMTQmd6xUIVzvWp6A'
  end

  def call
    loop do
      CODES.each do |code|
        puts "#{Time.now}| Checking: #{code}"
        response = Faraday.get(URL, params(code), headers)
        notify(code, response) if response.status == 403 || (response.status == 200 && response['content-length'].to_i > 4 && response['content-length'] != '226')
        sleep 3
      end

      sleep 3600 / 2
    end
  end

  def mac_os?
    Gem::Platform.local.os == 'darwin'
  end

  def notify(code, response)
    puts code, response.body
    puts `osascript -e 'display notification "#{code} have #{response.body.gsub(/"/,'')}" with title "Greetings #{response.status}"'` if mac_os?
  end

  def headers
    {
      ':authority' => 'lift-api.vfsglobal.com',
      ':method' =>'GET',
      ':scheme' =>'https',
      accept: 'application/json, text/plain, */*',
      'accept-encoding': 'gzip, deflate, br',
      'accept-language': 'en-US,en;q=0.9,ru;q=0.8',
      authorization: @authorization,
      'cache-control': 'no-cache',
      'content-type': 'application/json;charset=utf-8',
      dnt: '1',
      origin: 'https://visa.vfsglobal.com',
      pragma: 'no-cache',
      referer: 'https://visa.vfsglobal.com/',
      route: 'blr/ru/pol',
      'sec-ch-ua': '"Google Chrome";v="93", " Not;A Brand";v="99", "Chromium";v="93"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': "macOS",
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-site',
      'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36'
    }
  end

  def params(center_code='POST-BRST')
    # C-other visa POL-Min 01
    # visa_category_code = center_code == 'POST-MIN' ? '05' : '02' # D-visa
    visa_category_code = '01' # C-visa
    {
      countryCode: 'blr',
      missionCode: 'pol',
      centerCode: center_code,
      loginUser: 'polinuka_@mail.ru',
      visaCategoryCode: visa_category_code,
      languageCode: 'ru-RU',
      applicantsCount: '1',
      days: 91,
      fromDate: '12/11/2021',
      slotType: '2',
      toDate: '09/02/2022',
    }
  end

end

VisaChecker.new.call
