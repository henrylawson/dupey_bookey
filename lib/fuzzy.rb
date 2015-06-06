require 'fuzzystringmatch'

class Fuzzy

  def initialize
    @jarow = FuzzyStringMatch::JaroWinkler.create(:pure)
  end

  def find_similar(word, all_words)
    lower_word = word.downcase
    all_words.find { |title| similar?(lower_word, title) } || lower_word
  end

  def similar?(word_a, word_b)
    @jarow.getDistance(word_a, word_b) >= 0.8
  end
end
