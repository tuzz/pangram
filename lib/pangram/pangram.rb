PREFIX = 'This sentence contains'
FINAL_JOIN = 'and'
CHARACTERS = ('a'..'z').to_a
PRUNE_ABOVE = 10000

def find_a_solution
  add_to_pool(seed, error(seed), 0)
  while !solved? do
    current_attempt = remove_first_from_pool
    next_attempts = increments(current_attempt, language_significance)
    next_attempts.each_with_index do |attempt, index|
      add_to_pool(attempt, error(attempt), index)
    end
    prune_pool
    show_progress
  end
end
