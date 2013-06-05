#coding: utf-8
require 'spec_helper'

module Codebreaker
  describe Game do
    let(:output) { mock('output').as_null_object }   
    let(:game)   { Game.new(output) }


    describe "#start" do
      it "sends a welcome message" do
        output.should_receive(:puts).with('Welcome to Codebreaker!')
        game.stub(:cycle_game).and_return('')
        game.start
      end

      it "prompts for the first guess" do
        output.should_receive(:puts).with('Enter guess:')
        game.stub(:cycle_game).and_return('')
        game.start
      end
    end

    describe "#get_user_name" do
          it "you are prompted for the name" do
          output.should_receive(:puts).with('Please enter your name:')
          game.get_user_name
        end

        it "valid name" do
          game.stub(:gets).and_return("Vasya Pupkin")
          game.get_user_name.should include("Vasya Pupkin")
        end

        it "not valid name"  # я пока не нашол решения как тестить "next" который все портит и программа останавливается
    end

    describe "#cycle_game" do
      before(:each) { 
          game.instance_variable_set( :@guess_number, "1234")
          game.instance_variable_set( :@iterations, 1)
          game.stub(:winer).and_return()

      }
        it "Show a preliminary result" do
          game.stub(:gets).and_return("4321")
          output.should_receive(:puts).with('----')
          game.cycle_game
        end

        it "uncorrect input" do
            game.stub(:input_validate?).and_return(false)
            game.stub(:gets).and_return("~4321")
            output.should_receive(:puts).with("Please enter code of four numbers between 1 and 6") # я пока не нашол решения как тестить "next" который все портит и программа останавливается
        end
    end

    describe "#winer" do
      before(:each) { 
          game.instance_variable_set( :@guess_number, "1234")
          game.instance_variable_set( :@input, "1234")
          game.instance_variable_set( :@count, 4)
          game.stub(:gets).and_return("Vasya Pupkin")
          game.stub(:save_result).and_return()
          game.stub(:exit).and_return()
      }
      after(:each) { 
          game.winer(true)
      }
        it "Space string" do
          output.should_receive(:puts).with(' ')
        end
        it "Name winner" do
          output.should_receive(:puts).with("Vasya Pupkin you're winner!")
        end
        it "Guess number" do
          output.should_receive(:puts).with("Guess number 1234")
        end
        it "Inputed number" do
          output.should_receive(:puts).with("Inputed number 1234")
        end
        it "Try again?" do
          output.should_receive(:puts).with("Try again?")
        end

        it "False Game ower!" do
          output.should_receive(:puts).with("Game ower!")
          game.winer(false)
        end
        it "False Try again?" do
          output.should_receive(:puts).with("Try again?")
          game.winer(false)
        end
    end

    describe "#get_string_result" do
      before(:each) { 
        game.instance_variable_set( :@guess_number, "1234")
      }
        it "returned all ++++" do
          game.get_string_result(['1', '2', '3', '4']).should include("++++")
        end
        it "returned all ----" do
            game.get_string_result(['4', '3', '2', '1']).should include("----")
        end
        it "returned mix -+--" do
          game.get_string_result(['4', '2', '4', '1']).should include("-+--")
        end
        it "returned mix whis space +-" do
          game.get_string_result(['1', '3', '5', '6']).should include("+-")
        end
    end

    describe "#get_guess_number" do
        it "Return guess_number" do
          game.get_guess_number.should match(/^[1-6]{4}$/)
        end
    end

    describe "#start_game" do
        it "I want to play more" # я пока не нашол решения как тестить "exit"
    end

    describe "#hint" do
        it "Hint ..." do
          game.instance_variable_set( :@guess_number, "1234")
          game.hint().should include("1???", "?2??", "??3?", "???4") # и здесь у меня трабла hint() может одниз из предполагаемых результатов, товарищи подскажите 
        end
    end

    describe "#save_result" do
        it "save_result" do
          game.save_result("test string", "test_save_result.txt")
          IO.read("test_save_result.txt").should include("test string")
          File.delete("test_save_result.txt")
        end
    end
  end
end