#require "codebreaker/version"

module Codebreaker
  class Game

    def initialize(output = $stdout, input = $stdin)
      @output, @input = output, input
      @guess_number = get_guess_number
    end

    def start
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Enter guess:'
      cycle_game
    end

    def cycle_game
      count = 0
      while count < 5 do
        unless input_validate? 
          @output.puts 'Please enter a number between 1111 and 6666'
          next
        end

        @output.puts 'Загаданое число' + @guess_number.to_s
        @output.puts 'Введенное число' + @input.to_s
        @output.puts get_string_result(@input.to_s.split(//))

        count += 1
      end
      @output.puts 'Game over!'
    end

    def get_string_result(array)
      @new_array = Array.new
      @a = @guess_number.to_s.split(//)
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
      @input = gets.chomp
      @input.to_i >= 1111 and @input.to_i <= 6666 ? true : false
    end

    def get_guess_number
      Random.new.rand(1111..6666)
    end
  end
end
Codebreaker::Game.new().start
#@output.puts 'Please enter a number between 1111 and 6666' 