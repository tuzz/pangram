def sentence(array)
  words = array.zip(characters).map { |i, c| "#{i.to_words} #{c}#{"'s" if i > 1}"}
  delimited = words[0..-2].join(', ') << " #{final_join} " << words[-1]
  "#{prefix} #{delimited}."
end

def generate_prefix
  prefix = ''
  prefix << ['This sentence', 'This pangram', 'This self-enumerating pangram'].sample
  name = ['Christopher Patuzzo', 'cpatuzzo'].sample
  verb = ['generated', 'discovered', 'built', 'found', 'crafted', 'computed'].sample
  prefix << [", #{verb} by #{name},", " was #{verb} by #{name} and it"].sample
  contains = [' contains', ' uses', ' has', ' employs', ' makes use of', ' utilises'].sample
  contains << ['', ' exactly', ' precisely', ' no more or less than', ' no more nor less than'].sample
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

def change_sentence_every(frequency)
  frequency /= language_significance.count
  @sentence_count ||= 0
  @sentence_count += 1
  if @sentence_count == frequency
    @sentence_count = 0
    @base = nil
    @seed = nil
    @minimum = nil
    prefix(true)
    final_join(true)
    reset_pool
    add_to_pool(seed, error(seed), 0)
  end
end
