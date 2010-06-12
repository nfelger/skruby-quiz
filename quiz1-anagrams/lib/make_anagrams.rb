class MakeAnagrams
  def initialize(word_list)
    @words = word_list.map{|word| word.chomp}
    @words.reject!{|word| illegal?(word)}    
  end
  
  def formatted_anagram_dictionary
    output = []
    anagrams.keys.sort.each do |entry|
      anagram_set = anagrams[entry]
      case anagram_set.size
      when 0
        next
      when 1
        output << ([entry] + anagram_set).join(' ')
      else
        if entry[0] < anagram_set.first[0]
          output << ([entry] + anagram_set).join(' ')
        else
          output << entry + " (See '#{anagram_set.first}')"
        end
      end
    end
    output.join("\n")
  end
  
  def anagrams
    @dictionary ||= begin
      dictionary = {}
      @words.each do |word|
        dictionary[word] = []
        anagram_set = (@words - [word]).select{|candidate| anagrams?(word, candidate)}.sort
        dictionary[word] += anagram_set unless anagram_set.empty?
      end
      dictionary
    end
  end
  
  private
  
  def illegal?(word)
    word =~ /[^a-z]/i
  end
  
  def anagrams?(some_word, another_word)
    some_word.downcase.split('').sort == another_word.downcase.split('').sort
  end
end