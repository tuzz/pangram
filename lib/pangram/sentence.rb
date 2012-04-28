def sentence(array)
  words = array.zip(CHARACTERS).map { |i, c| "#{i.to_words} #{c}#{"'s" if i > 1}"}
  delimited = words[0..-2].join(', ') << " #{final_join} " << words[-1]
  "#{prefix} #{delimited}."
end

def generate_prefix
  prefix = ''
  prefix << ['This sentence', 'This pangram', 'This self-enumerating pangram'].sample
  name = ['Christopher Patuzzo', 'cpatuzzo'].sample
  verb = ['generated', 'discovered', 'built', 'found', 'crafted'].sample
  prefix << [", #{verb} by #{name},", " was #{verb} by #{name} and it"].sample
  contains = [' contains', ' uses', ' has', ' employs', ' makes use of'].sample
  contains << ['', ' exactly', ' precisely', ' no more than', ' no less than', ' no more or less than'].sample
  prefix << contains
end

def prefix(regenerate = false)
  return @prefix unless regenerate or @prefix.nil?
  @prefix = generate_prefix
end

def generate_final_join(regenerate = false)
  final_join = 'and'
  final_join << ['', ' just', ' only', ' last but not least,', ' finally,'].sample
end

def final_join(regenerate = false)
  return @final_join unless regenerate or @final_join.nil?
  @final_join = generate_final_join
end
