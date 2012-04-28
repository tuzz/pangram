def pool
  @pool_count ||= 0
  @pool ||= Hash.new { |outer, error| outer[error] = Hash.new { |inner, index| inner[index] = [] } }
end

def add_to_pool(array, error, index)
  pool[error][index] << array
  @pool_count += 1
end

def remove_keys_if_necessary(error, index)
  index_count = pool[error][index].count
  if index_count == 0
    pool[error].delete(index)
    pool.delete(error) if pool.count == 1
  else
    false
  end
end

def remove_last
  error = pool.keys.max
  index = pool[error].keys.max
  pool[error][index].pop
  remove_keys_if_necessary(error, index)
  @pool_count -= 1
end

def prune_pool
  remove_last while @pool_count > PRUNE_ABOVE
end
