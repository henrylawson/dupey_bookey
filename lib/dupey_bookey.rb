require 'json'
require 'fuzzy'
require 'active_support/all'

class DupeyBookey

  def initialize
    @fuzzy = Fuzzy.new
  end

  def dupes(data)
    group(JSON.parse(data))
  end

  private

  def group(books)
    matches = {}
    books.each do |book|
      next if (book_title = book['title']).blank?
      value_using_fuzzy_key(book_title, matches) << book_title
    end
    filter_single_matches(matches)
  end

  def value_using_fuzzy_key(book_title, titles)
    title = @fuzzy.find_similar(book_title, titles.keys)
    titles[title] ||= []
  end

  def filter_single_matches(titles)
    titles.select { |_t, matches| matches.count > 1 }
  end
end
