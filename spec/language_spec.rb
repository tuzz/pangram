require 'spec_helper'

describe 'Language' do

  describe '#plural_index' do
    it "returns the index of the 's' character" do
      plural_index.should == 18
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
      word_frequencies[50].should == [0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0]
      word_frequencies[62].should == [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 2, 0, 0, 1, 1, 1, 0]
    end                            #  A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z

    it 'does not enter triple figures' do
      word_frequencies[99].should_not be_nil
      word_frequencies[100].should be_nil
    end

    it 'does not have any frequencies for zero' do
      word_frequencies[0].should == [0] * 26
    end

    it 'caches the result' do
      @word_frequencies.should be_nil
      word_frequencies
      @word_frequencies.should_not be_nil
    end
  end

  describe '#language_frequencies' do
    it 'creates an array of frequencies from the written numbers' do
      stub!(:word_frequencies).and_return([[0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1], [1, 2, 3, 4, 5, 6]])
      language_frequencies.should == [2, 3, 4, 5, 6, 7]
    end

    it 'caches the result' do
      @language_frequencies.should be_nil
      language_frequencies
      @language_frequencies.should_not be_nil
    end
  end

  describe '#language_significance' do
    it 'creates an array of indices sorted by language frequency occurence' do
      stub!(:language_frequencies).and_return([2, 3, 1, 5, 4])
      language_significance.should == [3, 4, 1, 0, 2]
    end

    it 'caches the result' do
      @language_significance.should be_nil
      language_significance
      @language_significance.should_not be_nil
    end
  end

end
