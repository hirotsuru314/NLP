# _*_ coding: utf-8 _*_
$:.unshift File.dirname(__FILE__)  # ロードパスにカレントディレクトリを追加
require 'TfIdf'

module CosineSimilarity
  include TfIdf

  #ハッシュから特徴ベクトルを生成
  def feature_vector
    @vector1 = Array.new
    @vector2 = Array.new
    @hash = @tfidf1.merge(@tfidf2)
    @hash.each do |key,value|
      @tfidf1[key] = 0 unless @tfidf1.has_key?(key)
      @tfidf2[key] = 0 unless @tfidf2.has_key?(key)
    end

    @vector1 = @tfidf1.sort.map{|key,val|val}
    @vector2 = @tfidf2.sort.map{|key,val|val}
  end

  #コサイン類似度を計算
  def calculate_similarity
    ip = inner_product
    nm = normalize(@vector1) * normalize(@vector2)
    ip / nm
    puts "CosineSimilarity: #{ip/nm}"
  end

  #ベクトルの内積を計算
  def inner_product
    sum = 0.0
    @vector1.each_with_index{ |val, i| sum += val*@vector2[i] }
    sum
  end

  #ベクトルの正規化
  def normalize(vector)
    Math.sqrt(vector.inject(0.0){ |sum,n| sum += n**2 })
  end
end
