def base
  @base ||= frequencies(prefix + final_join).map { |i| i + 1 }
end

def description(array)
  vector_addition(*([base] + array.map { |i| word_frequencies[i] }))
end

def error(array)
  vector_subtraction(array, description(array)).inject { |sum, i| sum += i.abs }
end
