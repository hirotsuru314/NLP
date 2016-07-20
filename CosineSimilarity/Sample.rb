# _*_ coding: utf-8 _*_
$:.unshift File.dirname(__FILE__)  # ロードパスにカレントディレクトリを追加
require 'TfIdf'
require 'CosSim'

class CalculateSimilarity
  include TfIdf
  include CosineSimilarity

  def calculation(text1, text2)
    split_words(text1, text2)
    calculate_tf
    calculate_tfidf
    feature_vector
    calculate_similarity
  end
end

#ARGVで二つの文章を受け取り、計算を実行する。

text1 = open(ARGV[0], &:read)
text2 = open(ARGV[1], &:read)

test = CalculateSimilarity.new
test.calculation(text1, text2)
