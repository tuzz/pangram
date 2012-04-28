def pool
  @pool_count ||= 0
  @pool ||= Hash.new { |outer, error| outer[error] = Hash.new { |inner, index| inner[index] = [] } }
end

def reset_pool
  @pool = Hash.new { |outer, error| outer[error] = Hash.new { |inner, index| inner[index] = [] } }
end

def add_to_pool(array, error, index)
  pool[error][index] << array
  @pool_count += 1 unless pool[error][index].uniq!
end

def remove_keys_if_necessary(error, index)
  index_count = pool[error][index].count
  if index_count == 0
    pool[error].delete(index)
    pool.delete(error) if pool[error].count == 0
  else
    false
  end
end

def remove_first_from_pool
  error = pool.keys.min
  index = pool[error].keys.min
  first = pool[error][index].shift
  remove_keys_if_necessary(error, index)
  @pool_count -= 1
  first
end

def remove_last_from_pool
  error = pool.keys.max
  index = pool[error].keys.max
  last = pool[error][index].pop
  remove_keys_if_necessary(error, index)
  @pool_count -= 1
  last
end

def prune_pool(threshold)
  remove_last_from_pool while @pool_count > threshold
end

def solved?
  pool.has_key?(0)
end
