require_relative 'config/environment'
require 'json'

class App < Sinatra::Base
  # open the text file
  get '/' do
    # in here a render of the index page
  end

  # This is a sample dynamic route.
  get "/search/:word" do
    @word = params[:word]
    word = @word
    arrange_word(word)
    "#{@word}"
    render json: @anagrams
  end

  # **** actions *****
  def index
    @greeting = "Whats The Word?"
  end


  # def search
  #   puts "in search route"
  #   get_word
  #   # renders word's anagrams to json on /search
  #   render json: @anagrams
  # end

  # def get_word
  #   # get word from form
  #   base_word = params['base_word']
  #   arrange_word(base_word) #function that sorts word to find anagram
  # end

  def arrange_word(base_word)
    # remove white space
    base_word = base_word.strip
    # sort letters alphebetically
    sorted_base_word = base_word.downcase.split('').sort.join
    # call anagram function
    new_anagram(base_word, sorted_base_word) #find anagram

  end

  def new_anagram(base_word, sorted_base_word)
    hash = Hash.new
    anagrams = Array.new

    File.open("public/files/dictionary.txt", 'r') do |file|
      file.readlines.each_with_index do |line, index|
        original = line.strip
        if original.length == base_word.length
          sorted = original.downcase.split('').sort.join

          if sorted_base_word == sorted
            anagrams.push(original)
          end
        end
        hash[base_word] = anagrams
        @anagrams = hash[base_word]
      end #end do
    end

  end


end
