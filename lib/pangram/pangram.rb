def find_a_solution(depth = 150000, prune_above = 1000)
  add_to_pool(seed, error(seed), 0)
  while !solved? do
    change_sentence_every(depth)
    current_attempt = remove_first_from_pool
    next_attempts = increments(current_attempt, language_significance)
    next_attempts.each_with_index do |attempt, index|
      add_to_pool(attempt, error(attempt), index)
    end
    prune_pool(prune_above)
    show_progress
  end
  alert
end
