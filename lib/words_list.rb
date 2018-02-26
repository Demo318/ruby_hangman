##
# This class contains all the logic for interacting with words to be served to the player.

class WordsList

    ##
    # Opens a .txt file to be used as a master words list.
    # Knows the current_word, all previous words.
    # Uses random number to select new word. Loops until all conditions for word are met.

    attr_reader :current_word

    public 

    def initialize(word_file)
        # word_file is string for File.open() to process.

        @word_file_str = word_file
        @previous_words = Array.new
        @current_word = new_word
    end

    def new_word
        # Quiries @word_file to find a new word that is not in @previous_words.

        store_current_word

        potential_words = Array.new
        File.open(@word_file_str, "r").each do |line|
            line = line.chomp
            if line.length > 3 && all_lowercase?(line)
                potential_words << line unless @previous_words.include?(line)
            end
        end

        @current_word = potential_words[1 + rand(potential_words.length)]
    end


    private

    def store_current_word
        # Puts current word into previous_words array.

        @previous_words << @current_word unless @current_word == ""
    end

    def all_lowercase?(tst_word)
        # Determines if all characters in string are lowercase.

        tst_word.split.each do |lttr|
            return false if lttr.match(/[A-Z]/)
        end
        true
    end

end