# _*_ coding: utf-8 _*_
$:.unshift File.dirname(__FILE__)
require 'natto'
require "idf_dic"

module TfIdf

  #Mecabによる形態素解析（単語分割）
  def split_words(text)
    @arr = Array.new
    nm = Natto::MeCab.new('-d /usr/local/lib/mecab/dic/mecab-ipadic-neologd')
    nm.parse(text) do |n|
      surface = n.surface
      feature = n.feature.split(',')
      #名詞のみを抽出する
      if feature.first == '名詞' && feature.last != '*'
        @arr.push(surface) #テキストを単語分割して配列で返す
      end
    end
  end

  #TF値を計算
  #配列をkeyが形態素、valueがTF値(Float)のハッシュに変換
  def calculate_tf
    @tf = Hash.new
    @arr.each do |word|
      if(@tf.key?(word))
        @tf[word] += 1
      else
        @tf[word] = 1
      end
    end
    @tf.each do |key, value|
      @tf[key] = value.to_f/@tf.size
    end
  end

  def calculate_tfidf
    @tfidf = Hash.new
    @tf.each do |key, value|
      if $idf.has_key?(key)
        @tfidf[key] = ($idf[key] * value).round(3)
      end
    end
    puts @tfidf
  end
end
