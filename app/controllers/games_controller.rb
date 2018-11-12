require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
     @grid = (1..10).map { ("A".."Z").to_a.sample }

    #@grid = []
    #random = ("a".."z").to_a

    #for i in (0..9)
    #  @grid << random.sample(1)
    #end
    #return @grid
  end

  def score
    @word = params[:word]
    @grid = params[:grid]

    if right_chars(@word, @grid)
      if true_word(@word)
        @answer = "contratulation madafucker"
      else
        @answer = "try again looser"
      end
    else
      @answer = "Wrong Grid"
    end
  end

  def right_chars(word, grid)
    attempt_array = word.upcase.split("")
    p attempt_array
    attempt_test = attempt_array.all? { |l| attempt_array.count(l) <= grid.count(l) }

    return @answer = attempt_test
  end

  def true_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    lw_api = open(url).read
    api_hash = JSON.parse(lw_api)
    answ = api_hash["found"]
    p answ
    return answ
  end
end

