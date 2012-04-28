require 'rspec'
require 'pangram'

# Much slower, but accuracy is derived from its simplicity.
def array_for(sentence)
  sentence.downcase!
  CHARACTERS.map { |c| sentence.count c }
end
