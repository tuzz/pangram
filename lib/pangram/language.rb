def language_frequencies
  @language_frequencies ||= vector_addition(*word_frequencies)
end

def language_significance
  return @language_significance if @language_significance
  significant_pairs = language_frequencies.zip(0..language_frequencies.count).select { |f, i| !f.zero? }
  @language_significance = significant_pairs.sort_by { |a, b| -a }.map { |arr| arr[1] }
end
