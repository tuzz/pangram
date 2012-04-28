def sentence(array)
  words = array.zip(CHARACTERS).map { |i, c| "#{i.to_words} #{c}#{"'s" if i > 1}"}
  delimited = words[0..-2].join(', ') << " #{FINAL_JOIN} " << words[-1]
  "#{PREFIX} #{delimited}."
end

def frequencies(string)
  CHARACTERS.map { |c| string.downcase.count c }
end

def word_frequencies
  @word_frequencies ||= (0..99).map { |i| frequencies(i.to_words) }
end

def vector_addition(*arrays)
  arrays[0].zip(*arrays[1..-1]).map { |a| a.inject(:+) }
end

def vector_subtraction(a, b)
  a.zip(b).map { |a, b| (a - b) }
end

def increments(array, indices)
  indices.map do |i|
    dup = array.dup
    dup[i] += 1
    dup
  end
end

def show_progress
  minimum = pool.keys.min
  @minimum ||= minimum
  return if @minimum <= minimum
  @minimum = minimum
  puts "\n#{minimum} errors:"
  puts sentence(pool[minimum].values[0][0])
end
