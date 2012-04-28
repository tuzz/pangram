require 'spec_helper'

describe 'Error' do

  describe '#frequencies' do
    it 'creates an array of the frequency for each character' do
      frequencies('aaabbc').should == [3, 2, 1] + [0] * 23
    end

    it 'is case insensitive' do
      frequencies('ZzZz').should == [0] * 25 + [4]
    end

    it 'does not error if given non-alphabetic characters' do
      frequencies("<>!*a''#").should == [1] + [0] * 25
    end
  end

  describe '#word_frequencies' do
    it 'creates an array of arrays, containing the frequencies of characters in the written indices' do
      word_frequencies[1].should  == [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      word_frequencies[50].should == [0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0]
      word_frequencies[62].should == [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 2, 0, 0, 1, 1, 1, 0]
    end                            #  A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z

    it 'does not enter triple figures' do
      word_frequencies[99].should_not be_nil
      word_frequencies[100].should be_nil
    end

    it 'caches the result' do
      @word_frequencies.should be_nil
      word_frequencies
      @word_frequencies.should_not be_nil
    end
  end

  describe '#vector_addition' do
    it 'carries out vector addition on the given arrays' do
      vector_addition([1, 2, 3], [1, 1, 1]).should == [2, 3, 4]
      vector_addition([0, 0], [0, 0], [0, 0]).should == [0, 0]
      vector_addition([1]).should == [1]
    end
  end

  describe '#vector_subtraction' do
    it 'carries out vector subtraction on the given array' do
      vector_subtraction([1, 2], [0, 1]).should == [1, 1]
      vector_subtraction([5, 4, 3, 2, 1], [2, 1, 2, 1, 1]).should == [3, 3, 1, 1, 0]
      vector_subtraction([2], [2]).should == [0]
    end
  end

  describe '#base' do
    it 'creates an array of frequencies from the prefix and final join, incremented by one' do
                                          # This sentence contains # and
      base.should == [3, 1, 3, 2, 4, 1, 1, 2, 3, 1, 1, 1, 1, 6, 2, 1, 1, 1, 4, 4, 1, 1, 1, 1, 1, 1]
    end            #  A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z

    it 'caches the result' do
      @base.should be_nil
      base
      @base.should_not be_nil
    end
  end

  describe '#plural_index' do
    it "returns the index of the 's' character" do
      plural_index.should == 18
    end
  end

  describe '#pluralize' do
    it "calculates a vector for the number of plural 's' characters" do
      pluralize([1] * 26).should == [1] * 26                                                          #S
      pluralize([2] + [0] * 25).should       == [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0]
      pluralize([2, 2] + [0] * 24).should    == [2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0]
      pluralize([9, 9, 9] + [0] * 23).should == [9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0]
    end

    it "does not doubly increment the 's' character in the calculation" do
      pluralize([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0]).
        should == [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0]
    end
  end

  describe '#seed' do
    it 'is an array created by pluralizing the base' do
      seed.should == pluralize(base)
    end

    it 'caches the result' do
      @seed.should be_nil
      seed
      @seed.should_not be_nil
    end
  end

  describe '#description' do
    it 'generates an array that describes the frequency of characters in the sentence composed from the given array' do
      description(seed).should == array_for(sentence(seed))
    end
  end

  describe '#error' do
    it 'sums the absolute difference between the given array and its description' do
      stub!(:description).and_return([1, 2, 3, 4])
      error([6, 5, 4, 3]).should == (5 + 3 + 0 + 2)
    end
  end

end