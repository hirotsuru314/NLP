# _*_ coding: utf-8 _*_
$:.unshift File.dirname(__FILE__)
require 'natto'

module MakingDictionary

#テキストファイルを開いて、Abstractの配列を返す。
def open_abs(text)
  doc = open(text, &:read)
  @documents = Array.new
  @documents = doc.rstrip.split(/\r?\n/).map do |line|
    line.chomp
  end
end

#IDFを計算
#@documentsに格納された文章の配列から
#keyが形態素、valueがIDF値(Float)のハッシュを返す
def calculate_idf
  @idf = Hash.new
  @documents.each do |sentence|
    word_hash = Hash.new
    nm = Natto::MeCab.new('-d /usr/local/lib/mecab/dic/mecab-ipadic-neologd')
    nm.parse(sentence) do |word|
      surface = word.surface
      feature = word.feature.split(',')
      if feature.first == '名詞' && feature.last != '*'
        word_hash[word.surface] = 1
      end
    end
    word_hash.each_key do |key|
      @idf[key]||=0
      @idf[key]+=1
    end
  end
  #1回しか登場しない単語を削除
  @idf.delete_if{|key, value| value == 1 }
  #IDFを計算、小数点以下３桁まで
  @idf.each do |key, value|
    @idf[key] = Math.log10(@documents.size/value.to_f).round(3) + 1
  end
   #Marshalでdumpして"idf_dic.dat"に書き出し
   dumped = Marshal.dump @idf
   File.open("idf_dic.dat", "w") {|f| f.write(dumped)}
end
end

class MakeDic
include MakingDictionary
  def make_dic(text)
    open_abs(text)
    calculate_idf
  end
end

text = "documents.txt"
test = MakeDic.new
test.make_dic(text)
