##
# Contains logic for playing hangman, the game.

require_relative "words_list"

class Game

    ##
    # Has @player_name as primary reference variable

    attr_reader :current_guesses

    

    public

    def initialize(word_file)
        @words_list = WordsList.new(word_file)
        @current_guesses = []
        puts "you started a game!"
    end

    def try(letter)
        # Takes single-character string.
        # Tries it against current word.

    end

    def draw_current_state
        # Prints the current state of the game to the console.


    end

    private


end