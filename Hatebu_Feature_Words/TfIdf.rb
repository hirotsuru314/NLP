# _*_ coding: utf-8 _*_
$:.unshift File.dirname(__FILE__)
require 'natto'
require "idf_dic"

module TfIdf

  def feature_words_extraction
    split_words(@bookmark_titles)
    calculate_tfidf
    extraction
  end

  #Mecabによる形態素解析
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
    return @arr
  end

    #配列をkeyが形態素、valueがTF値(Float)のハッシュに変換
  def calculate_tfidf
    #TF値を計算
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
    #TF-IDF値を計算
    @tfidf = Hash.new
    @tf.each do |key, value|
      if $idf.has_key?(key)
        @tfidf[key] = ($idf[key] * value).round(3)
      end
    end
    return @tfidf
  end

  def extraction
    @tfidf_sort =  @tfidf.sort_by {|a, b| b}.reverse
    #TF-IDF値の大きいものから５つを表示
    puts "１：#{@tfidf_sort[0][0]}"
    puts "２：#{@tfidf_sort[1][0]}"
    puts "３：#{@tfidf_sort[2][0]}"
    puts "４：#{@tfidf_sort[3][0]}"
    puts "５：#{@tfidf_sort[4][0]}"
  end
end
