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