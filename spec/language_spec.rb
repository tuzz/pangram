require 'spec_helper'

describe 'Language' do

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
