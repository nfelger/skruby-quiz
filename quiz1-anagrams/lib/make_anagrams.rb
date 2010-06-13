class MakeAnagrams
  def initialize(word_list)
    @word_list = word_list.map{|word| word.chomp}.sort
    @word_list.reject!{|word| illegal?(word)}
  end
  
  def formatted_anagram_dictionary
    output = []
    anagrams.each do |word, anagram_set|
      case anagram_set.size
      when 1
        next
      when 2
        output << [word, anagram_set.detect{|a| a != word}].join(' ')
      else
        anagram_set = [word] + (anagram_set - [word])
        if anagram_set[0][0] < anagram_set[1][0]
          output << anagram_set.join(' ')
        else
          output << anagram_set[0] + " (See '#{anagram_set[1]}')"
        end
      end
    end
    output.join("\n")
  end
  
  def anagrams
    @anagrams ||= begin
      @word_list.map do |word|
        [word, words[representative(word)]]
      end
    end
  end
  
  private
  
  def words
    @words ||= begin
      words = {}
      @word_list.each do |word|        
        rep = representative(word)
        words[rep] ||= []
        words[rep] << word
      end
      words
    end
  end
  
  def representative(word)
    word.downcase.unpack('c*').sort.join('')
  end
  
  def illegal?(word)
    word =~ /[^a-z]/i
  end
end