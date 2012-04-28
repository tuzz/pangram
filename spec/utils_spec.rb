require 'spec_helper'

describe 'Utils' do

  describe '#sentence' do
    it 'constructs a sentence from an array' do
      sentence([1, 2, 3, 4, 5]).should == "This sentence contains one a, two b's, three c's, four d's and five e's."
    end
  end

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

end
