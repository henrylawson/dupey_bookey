#!/usr/bin/env ruby

require './lib/dupey_bookey'

books_file = ARGV[0] ||= 'spec/fixture/books.json'
file = File.open(books_file)
DupeyBookey.new.dupes(file.read).each do |title, matched_titles|
  puts "#{title.titleize}: #{matched_titles}"
end
