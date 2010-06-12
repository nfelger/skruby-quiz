class MakeAnagrams
  def initialize(word_list, debug)
    @word_list = word_list.map{|word| word.chomp}
    @word_list.reject!{|word| illegal?(word)}
    @debug = debug
  end
  
  def formatted_anagram_dictionary
    output = []
    anagrams.keys.sort.each do |entry|
      anagram_set = anagrams[entry].sort
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
      words_of_size.keys.sort.each do |n|
        while word = words_of_size[n].shift
          STDERR.puts word if @debug
          next if dictionary[word]
          
          anagram_set = words_of_size[n].select{|candidate| anagrams?(word, candidate)}
          dictionary[word] = anagram_set
          
          anagram_set.each do |anagram|
            dictionary[anagram] = [word] + (anagram_set - [anagram])
          end
        end
      end
      dictionary
    end
  end
  
  private
  
  def words_of_size
    @words ||= begin
      words = {}
      @word_list.each do |word|
        words[word.size] ||= []
        words[word.size] << word
      end
      words
    end
  end
  
  def illegal?(word)
    word =~ /[^a-z]/i
  end
  
  def anagrams?(some_word, another_word)
    some_word.downcase.split('').sort == another_word.downcase.split('').sort
  end
end