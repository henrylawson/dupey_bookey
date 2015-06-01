#!/usr/bin/env ruby

require './lib/dupey_bookey'

books_file = ARGV[0] ||= 'spec/fixture/books.json'
file = File.open(books_file)
DupeyBookey.new.dupes(file.read).each_with_index { |book, index| puts "#{index+1}: #{book}" }
