require 'spec_helper'

describe 'Error' do

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

  describe '#plurals' do
    it 'returns a count of the number of frequencies greater than 1' do
      plurals([0, 1, 2]).should == 1
      plurals([1, 2, 3]).should == 2
      plurals([2, 3, 4]).should == 3
    end
  end

  describe '#plural_vector' do
    it 'returns an array, the size of characters, with the plural index set to the plural count' do
      expected = [0] * 26
      expected[plural_index] = 26
      plural_vector([2] * 26).should == expected
    end
  end

  describe '#pluralize' do
    it "adds a vector to the array for the number of plural 's' characters" do
      pluralize([1] * 26).should == [1] * 26                                                          #S
      pluralize([2] + [0] * 25).should       == [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0]
      pluralize([2, 2] + [0] * 24).should    == [2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0]
      pluralize([9, 9, 9] + [0] * 23).should == [9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0]
    end

    it "does not doubly increment the 's' character in the calculation" do
      pluralize([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]).
        should == [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0]
    end

    it 'does not mutate the given array' do
      array = (1..26).to_a
      before = array.dup
      pluralize(array)
      array.should == before
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
      200.times do
        array = 26.times.map { rand(1..50) }
        description(array).should == array_for(sentence(array))
        print "\e[32m.\e[0m"
      end
      puts
    end
  end

  describe '#error' do
    it 'sums the absolute difference between the given array and its description' do
      stub!(:description).and_return([1, 2, 3, 4])
      error([6, 5, 4, 3]).should == (5 + 3 + 0 + 2)
    end
  end

end