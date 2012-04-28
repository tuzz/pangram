def base
  @base ||= frequencies(PREFIX + FINAL_JOIN).map { |i| i + 1 }
end

def plural_index
  @plural_index ||= CHARACTERS.index('s')
end

def pluralize(array)
  plurals = array.count { |i| i > 1 }
  plurals += 1 if plurals > 1 and array[plural_index] <= 1
  array[plural_index] += plurals
  array
end

def seed
  @seed ||= pluralize(base)
end

def description(array)
  vector_addition(*([seed] + array.map { |i| word_frequencies[i] }))
end

def error(array)
  vector_subtraction(array, description(array)).inject { |sum, i| sum += i.abs }
end
