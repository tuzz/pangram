def characters
  @characters ||= ('a'..'z').to_a
end

def plural_index
  @plural_index ||= characters.index('s')
end

def frequencies(string)
  characters.map { |c| string.downcase.count c }
end

def word_frequencies
  return @word_frequencies if @word_frequencies
  plural_modifier = characters.each_with_index.map { |_, i| i == plural_index ? 1 : 0 }
  @word_frequencies = [[0] * 26] + (1..99).map { |i| vector_addition(frequencies(i.to_words), i > 1 ? plural_modifier : [0] * 26) }
end

def language_frequencies
  @language_frequencies ||= vector_addition(*word_frequencies)
end

def language_significance
  return @language_significance if @language_significance
  significant_pairs = language_frequencies.zip(0..language_frequencies.count).select { |f, i| !f.zero? }
  @language_significance = significant_pairs.sort_by { |a, b| -a }.map { |arr| arr[1] }
end
