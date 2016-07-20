# _*_ coding: utf-8 _*_
$:.unshift File.dirname(__FILE__)
$idf = Hash.new

data = File.read("idf_dic.dat")
$idf = Marshal.load data
