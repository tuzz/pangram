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