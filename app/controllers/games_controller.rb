require 'open-uri'
require 'json'

class GamesController < ApplicationController

    def new
        #will generate a new random grid and a form
        #the from will POST to the score action
        @letters = generate_letters
    end

    def generate_letters
        ('A'..'Z').to_a.sample(10)
    end
    
    def score
        @letters = params[:letters].to_s.split
        @word = (params[:word] || "").upcase
        @included = included?(@word, @letters)
        @english_word = english_word?(@word)
      end
    
      private
    
      def included?(word, letters)
        word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
      end

    def english_word?(word)
        response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
        json = JSON.parse(response.read)
        return json['found']
    end
end
