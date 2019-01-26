require 'HTTParty'
require 'byebug'
require 'Nokogiri'

class Scraper
  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get("https://www.6pm.com/men-clothing/CKvXAcABAuICAgEY.zso?s=isNew/desc/goLiveDate/desc/recentSalesStyle/desc/")
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def get_names
    names = parse_page.css('#searchPage').css('._2AfQY').css('._1h6Kf').css('._2jktc').css('p').css('._3BAWv').children.map {|name| name.text}.compact
  end

  def get_price
    price = parse_page.css('#searchPage').css('._2AfQY').css('._1h6Kf').css('._2jktc').css('p').css('._1J1ab').children.map {|price| price.text}.compact
  end

  scraper = Scraper.new
  names = scraper.get_names
  prices = scraper.get_price

  (0...names.size).each do |index|
    puts "- - - index #{index + 1} - - -"
    puts "Name: #{names[index]} | #{prices[index]}"
  end
end
