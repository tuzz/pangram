# VERBOSE=true ruby <(curl --silent https://raw.github.com/gist/2493899/pangram.rb)

# Attempts to find a pangram in a not-too-mathsy way.
# Takes a minimization approach where the error is the sum of frequency errors for each character.
# Ensures that stems aren't repeated.
# Rudimentary language analysis helps prioritise mutation selection.

require 'numbers_and_words'

VERBOSE = ENV['VERBOSE']
CHARACTERS = ('a'..'z').to_a
PREFIX = 'This sentence contains'
FINAL_JOIN = 'and'
LANGUAGE_SEARCH = 100

def sentence_for(array)
  pairs = array.zip(CHARACTERS)
  words = pairs.map { |x, c| "#{x.to_words} #{c}#{x > 1 ? '\'s' : ''}"}
  occurences = words[0..-2].join(', ') + " #{FINAL_JOIN} #{words.last}"
  "#{PREFIX} #{occurences}."
end

def array_for(sentence)
  sentence.downcase!
  CHARACTERS.map { |c| sentence.count c }
end

def error(array)
  array1 = array
  sentence = sentence_for(array)
  array2 = array_for(sentence)
  pairs = array1.zip(array2)
  errors = pairs.map { |a, b| (a - b).abs }
  errors.inject(:+)
end

def incremented_arrays(array)
  @character_significance.map do |i|
    arr = array.dup
    arr[i] += 1
    arr
  end
end

def add_to_pool(array)
  @pool ||= {}
  @pool[array] ||= error(array)
end

def seed_pool
  seed = array_for(PREFIX + FINAL_JOIN)
  seed.map! { |i| i.zero? ? 1 : i }
  add_to_pool(seed)
end

def disable(array)
  @pool[array] = true
end

def next_array
  unexplored = @pool.select { |k, v| v != true }
  unexplored.min_by(&:last).first
end

def analyse_language
  number_words = (1..LANGUAGE_SEARCH).map(&:to_words)
  number_string = number_words.join.downcase
  occurences = CHARACTERS.map { |c| number_string.count c }
  frequencies = occurences.zip((0..(CHARACTERS.count - 1)))
  relevant_freqencies = frequencies.delete_if { |f| f.first.zero? }
  by_frequency = relevant_freqencies.sort { |a, b| b.first <=> a.first }
  @character_significance = by_frequency.map(&:last)
end

def find_a_solution
  analyse_language
  seed_pool
  while @minimum.nil? || @minimum > 0 do
    @current = next_array
    how_are_we_doing?
    disable(@current)
    increments = incremented_arrays(@current)
    increments.each &method(:add_to_pool)
  end

  puts yellow("\n\nA solution has been found:\n")
  puts yellow(current_sentence)
  puts
end

def how_are_we_doing?
  previous = @minimum
  @minimum ||= @pool[@current]
  @minimum = [@minimum, @pool[@current]].min

  if VERBOSE
    puts "Pool size: #{@pool.count}"
    puts "Minimum errors: #{@minimum}"
    puts "Current errors: #{@pool[@current]}"
    puts "  Array: #{@current.inspect}"
    puts "  Sentence: #{current_sentence}"
    puts
  else
    str = "#{@pool[@current]} "
    if previous == @minimum
      print red(str)
    else
      print green(str)
    end
  end
end

def current_sentence
  sentence_for(@current).capitalize
end

def red(string)
  "\e[31m#{string}\e[0m"
end

def green(string)
  "\e[32m#{string}\e[0m"
end

def yellow(string)
  "\e[33m#{string}\e[0m"
end