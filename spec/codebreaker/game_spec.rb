require 'spec_helper'

module Codebreaker
  describe Game do


    describe "#start" do
      let(:output) { mock('output').as_null_object }
      let(:cycle_game) { mock('cycle_game').as_null_object }      
      let(:game)   { Game.new(output) }

      it "sends a welcome message" do
        output.should_receive(:puts).with('Welcome to Codebreaker!')
        game.start
      end

      it "prompts for the first guess" do
        output.should_receive(:puts).with('Enter guess:')
        game.start
      end
    end

    describe "#cycle_game" do
        it "message" do
        end
    end

    describe "#winer" do
        it "message"
    end

    describe "#get_user_name" do
        it "message"
    end

    describe "#save_result" do
        it "message"
    end

    describe "#get_string_result" do
        it "message"
    end

    describe "#get_guess_number" do
        it "message"
    end
  end
end