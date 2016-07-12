# _*_ coding: utf-8 _*_
$:.unshift File.dirname(__FILE__)
doc = open("abstract.txt", &:read)

$documents = doc.rstrip.split(/\r?\n/).map do |line|
  line.chomp
end

#$documents.shuffle!
$documents.slice!(0..1000000)

$documents.delete_if do |sentence|
  sentence.size < 100
end
