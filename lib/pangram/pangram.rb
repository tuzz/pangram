PREFIX = 'This sentence contains'
FINAL_JOIN = 'and'

CHARACTERS = ('a'..'z').to_a

def sentence(array)
  words = array.zip(CHARACTERS).map { |i, c| "#{i.to_words} #{c}#{"'s" if i > 1}"}
  delimited = words[0..-2].join(', ') << " #{FINAL_JOIN} " << words[-1]
  "#{PREFIX} #{delimited}."
end
