# _*_ coding: utf-8 _*_
$:.unshift File.dirname(__FILE__)
require 'natto'
require "idf_dic"

module TfIdf

  #Mecabによる形態素解析（単語分割）
  def split_words(text1, text2)
    @arr1 = Array.new
    @arr2 = Array.new
    nm = Natto::MeCab.new
    #text1
    nm.parse(text1) do |n|
      surface = n.surface
      feature = n.feature.split(',')
      #名詞のみを抽出する
      if feature.first == '名詞' && feature.last != '*'
        @arr1.push(surface) #テキストを単語分割して配列で返す
      end
    end
    #text2
    nm.parse(text2) do |n|
      surface = n.surface
      feature = n.feature.split(',')
      if feature.first == '名詞' && feature.last != '*'
        @arr2.push(surface)
      end
    end
  end


  #TF値を計算
  #配列をkeyが形態素、valueがTF値(Float)のハッシュに変換
  def calculate_tf
    @tf1 = Hash.new
    @tf2 = Hash.new
    #text1
    @arr1.each do |word|
      if(@tf1.key?(word))
        @tf1[word] += 1
      else
        @tf1[word] = 1
      end
    end
    @tf1.each do |key, value|
      @tf1[key] = value.to_f/@tf1.size
    end
    #text2
    @arr2.each do |word|
      if(@tf2.key?(word))
        @tf2[word] += 1
      else
        @tf2[word] = 1
      end
    end
    @tf2.each do |key, value|
      @tf2[key] = value.to_f/@tf2.size
    end
  end

  def calculate_tfidf
    @tfidf1 = Hash.new
    @tfidf2 = Hash.new
    #text1
    @tf1.each do |key, value|
      if $idf.has_key?(key)
        @tfidf1[key] = $idf[key] * value
      end
    end
    #text2
    @tf2.each do |key, value|
      if $idf.has_key?(key)
        @tfidf2[key] = $idf[key] * value
      end
    end
  end
end
