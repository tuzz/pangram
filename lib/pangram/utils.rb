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

def alert
  5.times { print "\a*** "; sleep 0.5 }
  "A solution has been found"
end
