# _*_ coding: utf-8 _*_
$:.unshift File.dirname(__FILE__)  # ロードパスにカレントディレクトリを追加
require 'TfIdf'

class FeatureVector
  include TfIdf

  def calculation(text)
    split_words(text)
    calculate_tf
    calculate_tfidf
  end
end

#ARGVで二つの文章を受け取り、計算を実行する。

text = open(ARGV[0], &:read)

test = FeatureVector.new
test.calculation(text)
