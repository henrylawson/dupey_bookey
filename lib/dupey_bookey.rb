require 'json'
require 'active_support/all'
require 'fuzzystringmatch'

class DupeyBookey

  def initialize
    @jarow = FuzzyStringMatch::JaroWinkler.create(:pure)
  end

  def dupes(data)
    books = JSON.parse(data)
    title_counts = group_by_title_count(books)
    counts_greater_than_one(title_counts)
  end

  private

  def counts_greater_than_one(title_counts)
    titles = title_counts.map do |title, count|
      if title.present? && count > 1
        title.titleize
      end
    end
    titles.compact
  end

  def group_by_title_count(books)
    title_count = {}
    books.each do |book|
      title = determine_title(book, title_count.keys)
      title_count[title] ||= 0
      title_count[title] = title_count[title] += 1
    end
    title_count
  end

  def determine_title(book, titles)
    possible_title = book['title'].try(:downcase)
    if existing_title = fuzzy_match(possible_title, titles)
      existing_title
    else
      possible_title
    end
  end

  def fuzzy_match(possible_title, titles)
    titles.each do |title|
      if @jarow.getDistance(possible_title, title) >= 0.8
        return title
      end
    end
    nil
  end
end
