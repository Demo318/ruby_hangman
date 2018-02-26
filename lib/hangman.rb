##
# Master logic for user interaction with application.
# Saves/loads ALL PLAYER GAMES. Saves as array of Game objects.

require_relative "game"
require "yaml"

class Hangman

    ##
    # Uses @games_hash as master reference for current game. All calls for player interactionw ill go through that hash.

    def initialize(word_file)
        # If @games_hash file exists, load it & ask player if they want to load a game. Else, Hash.new & start new game.


    end

end