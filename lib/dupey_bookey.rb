require 'json'
require 'active_support/all'
require 'fuzzystringmatch'

class DupeyBookey

  def initialize
    @jarow = FuzzyStringMatch::JaroWinkler.create(:pure)
  end

  def dupes(data)
    group(JSON.parse(data))
  end

  private

  def group(books)
    titles = {}
    books.each do |book|
      next if (book_title = book['title']).blank?
      title = find_similar(book_title, titles.keys)
      (titles[title] ||= []) << book_title
    end
    titles.select { |_t, matches| matches.count > 1 }
  end

  def find_similar(original_title, all_titles)
    possible_title = original_title.downcase
    all_titles.each do |title|
      return title if similar?(possible_title, title)
    end
    possible_title
  end

  def similar?(string_a, string_b)
    @jarow.getDistance(string_a, string_b) >= 0.8
  end
end
