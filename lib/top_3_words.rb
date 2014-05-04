# http://www.codewars.com/kata/51e056fe544cf36c410000fb/train/ruby
# given a string of text (possibly with punctuation and line-breaks),
# returns an array of the top-3 most occurring words, in descending
# order of the number of occurrences.

class Top3Words
  # best solution
  def top_3_words(text)
    count = Hash.new { 0 }
    text.scan(/\w+'*\w*/) { |word| count[word.downcase] += 1 }
    count.map{|k,v| [-v,k]}.sort.first(3).map(&:last)
  end

    # freq = {}
    # string.split.each do |word|
    #   w = word.downcase.match(/[a-z']+/) # no punctuation except '
    #   w.nil? ? next : w = w[0]
    #   return [] if w == "'"
    #   freq[w] ? freq[w] += 1 : freq[w] = 1
    # end
    # freq.sort_by { |word, f| f }.reverse[0..2].map { |f| f[0] }
end