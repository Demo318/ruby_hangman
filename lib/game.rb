##
# Contains logic for playing hangman.

require_relative "words_list"

##
# game.rb includes Game class.

class Game

    ##
    # Class always has a single WordsList instance for managing the current
    # word and for interacting with a dictionary to retrieve a new word. 

    attr_reader :current_guesses

    

    public

    def initialize(word_file)
        @games_won = 0
        @games_lost = 0
        @max_misses = 6
        @current_misses = 0
        @current_guesses = []
        @current_word_with_blanks = []
        @words_list = WordsList.new(word_file)

        refresh_current_blanks
    end

    def try(letter)
        # Takes single-character string.
        # Tries it against current word.

        @current_guesses << letter

        if letter_is_correct?(letter)
            update_blanks(letter)
            if won_game?
                puts "You've found all the letters!"
                puts "The word was #{@words_list.current_word}."
                @games_won += 1
                display_record
                get_new_word
            else
                puts "Correct!"
            end
        else
            @current_misses += 1
            if lost_game?
                puts "You've run out of guesses!"
                @games_lost += 1
                display_record
                get_new_word
            else
                puts "Wrong!"
            end
        end
        

    end

    def draw_current_state
        # Prints the current state of the game to the console.

        puts "You have #{@max_misses - @current_misses} misses remaining."
        puts @current_word_with_blanks.join(" ")

    end

    private

    def letter_is_correct?(lttr)
        # Check if letter is in the @words_list's current word.

        @words_list.current_word.split("").include?(lttr)

    end

    def refresh_current_blanks
        # Initializes the number of blanks that will be displayed for the word being guessed.

        @current_word_with_blanks = []
        @words_list.current_word.length.times { @current_word_with_blanks << "_" }
    end

    def update_blanks(lttr)
        # Iterates through blanks & current word to change blanks to the letter guessed.

        @words_list.current_word.split("").each_with_index do |chrctr, ind|
            if lttr == chrctr
                @current_word_with_blanks[ind] = lttr
            end
        end

    end

    def lost_game?
        # Checks if the maximum amount of misses has been acheived.

        @current_misses >= @max_misses
    end

    def get_new_word
        # Updates the current word, current blanks, current_guesses and resets the misses counter.
        @words_list.new_word
        @current_guesses = []
        refresh_current_blanks
        @current_misses = 0
        puts "Getting a new word."
    end

    def won_game?
        # Provides feedback on if winning conditions have been met.

        @words_list.current_word.split("") == @current_word_with_blanks
    end

    def display_record
        # Shows current players win/loss record.

        puts "Won: #{@games_won}. Lost: #{@games_lost}"
    end

end
