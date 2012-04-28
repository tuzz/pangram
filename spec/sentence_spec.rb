require 'spec_helper'

describe 'Sentence' do

  describe '#sentence' do
    it 'constructs a sentence from an array' do
      sentence([1, 2, 3, 4, 5]).should == "This sentence contains one a, two b's, three c's, four d's and five e's."
    end
  end

end
