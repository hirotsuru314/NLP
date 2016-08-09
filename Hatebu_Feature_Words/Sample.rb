# _*_ coding: utf-8 _*_
$:.unshift File.dirname(__FILE__)  # ロードパスにカレントディレクトリを追加
require 'Hatebu_from_rss'
require 'TfIdf'

class HatebuFeatureWords
  include TfIdf
  include HatebuRSS
end

test = HatebuFeatureWords.new
print 'はてなIDを入力してください。'
$hatena_id = gets.chomp
test.get_rss
test.bookmark_titles
test.feature_words_extraction
