#coding: utf-8
require 'spec_helper'

module Codebreaker
  describe Game do

    describe "#start" do
      let(:output) { mock('output').as_null_object }   
      let(:game)   { Game.new(output) }

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
      let(:output) { mock('output').as_null_object }   
      let(:game)   { Game.new(output) }
        
        it "you are prompted for the name" do
          output.should_receive(:puts).with('Please enter your name:')
          game.get_user_name
        end

        it "valid name" do
          game.stub(:gets).and_return("Vasya Pupkin")
          game.get_user_name.should include("Vasya Pupkin")
        end

        it "not valid name"
    end

    describe "#cycle_game" do
      let(:output) { mock('output').as_null_object }   
      let(:game)   { Game.new(output) }

        it "Show a preliminary result" do
          game.instance_variable_set( :@guess_number, "1234")
          game.instance_variable_set( :@iterations, 1)
          game.stub(:winer).and_return()
          game.stub(:gets).and_return("4321")

          output.should_receive(:puts).with('----')
          game.cycle_game
        end

        it "Show hint"
        it "uncorrect input"
    end

    describe "#winer" do
      let(:output) { mock('output').as_null_object }   
      let(:game)   { Game.new(output) }
      before(:each) { 
          game.instance_variable_set( :@guess_number, "1234")
          game.instance_variable_set( :@input, "1234")
          game.instance_variable_set( :@count, 4)
          game.stub(:gets).and_return("Vasya Pupkin")
          game.stub(:save_result).and_return()
          game.stub(:exit).and_return()
      }
        it "Space string" do
          output.should_receive(:puts).with(' ')
          game.winer(true)
        end

        it "Name winner" do
          output.should_receive(:puts).with("Vasya Pupkin you're winner!")
          game.winer(true)
        end

        it "Guess number" do
          output.should_receive(:puts).with("Guess number 1234")
          game.winer(true)
        end

        it "Inputed number" do
          output.should_receive(:puts).with("Inputed number 1234")
          game.winer(true)
        end

        it "Try again?" do
          output.should_receive(:puts).with("Try again?")
          game.winer(true)
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
      let(:game)   { Game.new() }
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
      let(:game)   { Game.new() }
        it "Return guess_number" do
          game.get_guess_number.should match(/^[1-6]{4}$/)
        end
    end

    describe "#start_game" do
        it "I want to play more"
    end

    describe "#hint" do
      let(:game)   { Game.new() }
        it "Hint ..." do
          game.instance_variable_set( :@guess_number, "1234")
          game.hint().should == "1???" or "?2??" or "??3?" or "???4" 
        end
    end

    describe "#save_result" do
      let(:game)   { Game.new() }
        it "save_result" do
          game.save_result("test string", "test_save_result.txt")
          IO.read("test_save_result.txt").should include("test string")
          File.delete("test_save_result.txt")
        end
    end
  end
end