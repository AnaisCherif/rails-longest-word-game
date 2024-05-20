require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10).join(" ")
  end

#   The word can’t be built out of the original grid ❌
#   The word is valid according to the grid, but is not a valid English word ❌
#   The word is valid according to the grid and is an English word


# voir si le mot est valide => open URI
# si le mot est valide, regarde s'il contient lettres de l'array
# si oui, aucune lettre ne doit être doublée


  def score
    @word = params[:word]
    @letters = params[:list].split

    url = "https://dictionary.lewagon.com/#{params[:word]}"
    search = URI.open(url).read
    valid_word = JSON.parse(search)

    puts valid_word["found"]

    if valid_word["found"] && included?(@letters, @word)
      @answer = "Congratulations! #{@word} is a valid English word"
    else
      @answer = "Sorry but #{@word} doesn't seem to be a valid English word..."
    end
  end

  def included?(list, word)
    word.chars.each do |letter|
      if list.include?(letter)
        list.delete_at(list.index(letter))
      else
        return false
      end
    end
    return true

    # word.upcase.chars.all? { |letter| word.upcase.count(letter) <= list.count(letter) }
  end

end
