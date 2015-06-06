require 'json'
require 'active_support/all'
require 'fuzzystringmatch'

class DupeyBookey

  def initialize
    @jarow = FuzzyStringMatch::JaroWinkler.create(:pure)
  end

  def dupes(data)
    books = JSON.parse(data)
    group(books)
  end

  private

  def group(books)
    titles = {}
    books.each do |book|
      original_title = book['title']
      next if original_title.blank?

      title = determine_title(original_title, titles.keys)
      titles[title] ||= []
      titles[title] << original_title
    end
    titles.select { |title, matched_titles| matched_titles.count > 1 }
  end

  def determine_title(original_title, all_titles)
    possible_title = original_title.downcase
    if existing_title = fuzzy_match(possible_title, all_titles)
      existing_title
    else
      possible_title
    end
  end

  def fuzzy_match(possible_title, all_titles)
    all_titles.each do |title|
      if @jarow.getDistance(possible_title, title) >= 0.8
        return title
      end
    end
    nil
  end
end
