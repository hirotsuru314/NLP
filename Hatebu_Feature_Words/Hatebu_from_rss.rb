# _*_ coding: utf-8 _*_
$:.unshift File.dirname(__FILE__)
require 'open-uri'
require 'rss'

module HatebuRSS

def bookmark_titles
  @titles_array = Array.new
  @bookmark_titles = ""
  #ブックマークのタイトルを取り出して配列に格納
  @rss.items.each do |item|
    @titles_array << item.title
  end

  @titles_array.each do |title|
  @bookmark_titles = @bookmark_titles.concat(title)
  end
end

#受け取ったはてなIDからRSSをパースする
def get_rss
  url = "http://b.hatena.ne.jp/#{$hatena_id}/rss"
  opt = {}
  opt['User-Agent'] = 'Opera/9.80 (Windows NT 5.1; U; ja) Presto/2.7.62 Version/11.01'
  @rss = open(url, opt) do |file|
    RSS::Parser.parse(file.read)
  end
  @rss
end

end
