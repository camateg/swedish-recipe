require 'nokogiri'
require 'open-uri'
require 'gmail'

root_url = "http://vadfanskajaglagatillmiddag.nu"

user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"


html = open(root_url, "User-Agent" => user_agent)
page = Nokogiri::HTML(html)

all = page.css('div#fredag')
question = page.css('h1.question:nth-child(1)').text
recipe = page.css('h1.question:nth-child(2)').text

gmail = Gmail.new(ENV['EMAIL'], ENV['PASS'])

gmail.deliver do
  to ENV['TO_EMAIL']
  subject recipe
  text_part do
    body recipe
  end
  html_part do
    content_type 'text/html; charset=UTF-8'
    body all
  end
end
