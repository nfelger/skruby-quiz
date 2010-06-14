require 'set'

class MakeAnagrams
  def initialize(word_list)
    @word_list = word_list.
                   map { |word| word.chomp }.
                   reject { |word| illegal?(word) }.
                   sort
  end
  
  def formatted_anagram_dictionary    
    words_with_anagrams.
      select { |_, anagrams| anagrams.printable? }.
      map { |word, anagrams| anagrams.entry_for(word) }.
      join("\n")
  end
  
  def words_with_anagrams
    @word_list.map do |word|
      [word, anagrams[essence(word)]]
    end
  end
  
  private
  
  def anagrams
    @anagrams ||= begin
      anagrams = {}
      @word_list.each do |word|        
        the_essence = essence(word)
        anagrams[the_essence] ||= AnagramSet.new
        anagrams[the_essence] << word
      end
      anagrams
    end
  end
  
  def essence(word)
    word.downcase.unpack('c*').sort.join('')
  end
  
  def illegal?(word)
    word =~ /[^a-z]/i
  end
end

class AnagramSet
  def initialize
    @words = SortedSet.new
  end
  
  def <<(anagram)
    @words << anagram
  end
  
  def printable?
    @words.size > 1
  end
  
  def entry_for(word)
    case @words.size
    when 2
      [word, @words.detect{|a| a != word}].join(' ')
    else      
      if word == @words.first
        @words.to_a.join(' ')
      else
        word + " (See '#{lemma}')"
      end
    end
  end
  
  def lemma
    @words.first
  end
end