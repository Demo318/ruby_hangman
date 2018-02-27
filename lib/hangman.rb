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
        # TODO: Use @special_commands as master reference to, uh, special commands.
        @special_commands = ["save", "exit", "new"]
        @word_file = word_file
        @save_file_name = "lib/saved_games.yaml"
        if File.exist?(@save_file_name)
            save_file = File.open(@save_file_name, "r")
            @games_hash = YAML::load(save_file)
            with_previous_games
        else
            @games_hash = Hash.new()
            save_game
            new_game
            play_game
        end
    end

    private

    def with_previous_games
        # Logic for playing when previous saved games are found.
        # Player has the option to load an old game or start a new one.
        available_games = []
        downcase_games = []
        @games_hash.each { |key, val| available_games << key }
        available_games.each do |name|
            puts name 
            downcase_games << name.downcase
        end

        puts "Please select a game to load, or enter 'new' to start a new game."
        selection = ""
        while selection == ""
            try_selection = gets.chomp
            if try_selection.downcase == "new"
                selection = try_selection.downcase
            elsif downcase_games.include?(try_selection.downcase)
                available_games.each do |game|
                    selection = game if game.downcase == try_selection.downcase
                end
            else
                puts "That name is not valid, please enter another."
            end
        end

        if selection == "new"
            new_game
        else
            @game_name = selection
        end

        play_game
    end

    def play_game
        # Flow for player interacting with game.
        this_game = @games_hash[@game_name]
        while true
            this_game.draw_current_state
            letter = get_player_entry
            this_game.try(letter)
        end

    end

    def exit_game
        # Handles player leaving the game.

        exit
    end

    def get_player_entry
        # Regular entries for player turns.
        player_entry = ""

        while player_entry == ""
            puts "Please enter your next guess:"
            try_entry = gets.chomp.downcase

            if try_entry.length != 1
                case try_entry
                    when @special_commands[0] then save_game
                    when @special_commands[1] then exit_game
                    else puts "That entry is not valid."
                end
            elsif @games_hash[@game_name].current_guesses.include?(try_entry) 
                puts "You've already entered that letter."
            elsif try_entry.length == 1
                player_entry = try_entry
            end

        end

        player_entry
    end 

    def new_game
        # Logic for starting a new game.
        # Automatically executes if no saved games file is found.
        @game_name = get_player_name
        @games_hash[@game_name] = Game.new(@word_file)
    end

    def save_game
        # Write @games_hash to yaml file.
        save_file = File.open(@save_file_name, "w")
        save_file.write(YAML::dump(@games_hash))

        puts "Saved games updated."
    end

    def get_player_name
        # Ask current player to enter their name.
        this_player = ""
        puts "Please enter your name:"

        while this_player == ""
            player_entry = gets.chomp
            unless @games_hash.key?(player_entry) && @special_commands.include?(player_entry)
                this_player = player_entry
            end
        end
        this_player
    end

end