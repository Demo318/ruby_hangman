##
# Contains logic for playing hangman, the game.

require_relative "words_list"

class Game

    ##
    # Has @player_name as primary reference variable

    public

    def initialize(player_name, word_file)
        @words_list = WordsList.new(word_file)

    end

    private


end