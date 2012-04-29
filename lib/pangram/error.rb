def base
  @base ||= frequencies(prefix + final_join).map { |i| i + 1 }
end

def plural_index
  @plural_index ||= characters.index('s')
end

def plurals(array)
  array.count { |i| i > 1 }
end

def plural_vector(array)
  plural_vector = characters.map { 0 }
  plural_vector[plural_index] = plurals(array)
  plural_vector
end

def pluralize(array)
  array = array.dup
  modifier = plurals(array)
  modifier += 1 if modifier > 1 and array[plural_index] <= 1
  array[plural_index] += modifier
  array
end

def seed
  @seed ||= pluralize(base)
end

def description(array)
  vector_addition(*([base] + array.map { |i| word_frequencies[i] } + [plural_vector(array)]))
end

def error(array)
  vector_subtraction(array, description(array)).inject { |sum, i| sum += i.abs }
end
