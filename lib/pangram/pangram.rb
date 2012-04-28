def find_a_solution
  add_to_pool(seed, error(seed), 0)
  while !solved? do
    change_sentence_every(1000000)
    current_attempt = remove_first_from_pool
    next_attempts = increments(current_attempt, language_significance)
    next_attempts.each_with_index do |attempt, index|
      add_to_pool(attempt, error(attempt), index)
    end
    prune_pool(1000)
    show_progress
  end
  alert
end
