require 'spec_helper'

describe 'Utils' do

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

  describe '#increments' do
    it 'increments the elements of the given array that correspond to the given indices' do
      increments([1, 2, 3], [0, 1]).should include([2, 2, 3], [1, 3, 3])
      increments([5, 4, 1, 3], [1, 3]).should include([5, 5, 1, 3], [5, 4, 1, 4])
    end

    it 'preserves the index ordering' do
      increments([5, 2], [1, 0]).should == [[5, 3], [6, 2]]
      increments([1, 2, 3], [1, 2, 0]).should == [[1, 3, 3], [1, 2, 4], [2, 2, 3]]
    end
  end

end
