require 'HTTParty'
require 'byebug'
require 'Nokogiri'
require 'awesome_print'

class Scraper
  def initialize
    doc = HTTParty.get("https://www.officialcharts.com/charts/singles-chart/")
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def get_songs
    songs = @parse_page.css('.chart-positions').css('tr').css('td').css('.track').css('.title-artist').css('.title').css('a').children.map {|song| song.text }.compact
  end

  def get_artists
    artists = @parse_page.css('.chart-positions').css('tr').css('td').css('.track').css('.title-artist').css('.artist').css('a').children.map {|artist| artist.text }.compact
  end

  scraper = Scraper.new
  songs = scraper.get_songs
  artists = scraper.get_artists
  title_array = []

  songs.each_with_index do | value, index|
    title_array << { rank: index+1, song: value, artist: artists[index]}
  end
    ap title_array
end