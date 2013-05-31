require "codebreaker/version"

module Codebreaker
  class Game

    def initialize(output = $stdout)
      @output = output
      @guess_number = get_guess_number
    end

    def start
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Enter guess:'
      cycle_game
    end

    def cycle_game
      @count = 0
      while @count < 5 do
        @input = gets.chomp
        if @input == "hint" or @input == "h"
          @output.puts "подсказочка"
          next
        end
        unless input_validate? 
          @output.puts 'Please enter code of four numbers between 1 and 6'
          next
        end

        #@output.puts 'Загаданое число' + @guess_number
        #@output.puts 'Введенное число' + @input
        string_result = get_string_result(@input.split(//))
        
        if string_result == "++++"
          winer(true)
        else
          @output.puts string_result
        end

        @count += 1
      end
      @count -= 1
      winer(false)
    end
    
    def winer(winer)
      name = get_user_name
      if winer
        @output.puts " "
        @output.puts "#{name} you're winner!"
        @output.puts 'Guess number ' + @guess_number
        @output.puts 'Введенное number ' + @input
        @output.puts "Try again?"
      else
        @output.puts "Game ower!"
        @output.puts "Try again?"
      end
      save_result({ 
        :winer => winer, :name => name, :guess_number => @guess_number, 
        :last_input => @input, :step => @count+1})

      if (gets.chomp == "yes")
        Game.new().start
      else
        exit
      end
    end

    def get_user_name
      @output.puts 'Please enter your name:'
      name = gets.chomp
      if (name.match /\w/)
        name
      else
        get_user_nam
      end
    end

    private
    def save_result(hash)
      File.open("game_stat.txt", "a") { |file| file.puts(hash) }
    end

    def get_string_result(array)
      @new_array = Array.new
      @a = @guess_number.split(//)
      @a.each_index  { | key |
        if array[key] == @a[key]
          @new_array << '+'
        elsif @a.include?(array[key])
          @new_array << '-'
        else
          @new_array << nil
        end
      }
      @new_array.join
    end

    def input_validate?
      @input.match /^[1-6]{4}$/
    end

    def get_guess_number
      guess_number = String.new
      4.times { guess_number += rand(1..6).to_s }
      guess_number
    end
  end
end
#Codebreaker::Game.new().start
#@output.puts 'Please enter a number between 1111 and 6666' 