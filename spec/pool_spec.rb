require 'spec_helper'

describe 'Pool' do

  describe '#pool' do
    it 'returns a hash with a hash default that has an array default' do
      pool.should == {}
      pool[1].should == {}
      pool[1][2].should == []
    end

    it 'caches the result' do
      @pool.should be_nil
      pool
      @pool.should_not be_nil
    end

    it 'initalizes the pool_count instance variable to 0' do
      @pool_count.should be_nil
      pool
      @pool_count.should == 0
    end
  end

  describe '#add_to_pool' do
    it 'inserts the given array at the given error/index location' do
      add_to_pool([1, 2, 3], 4, 5)
      pool[4][5].should include([1, 2, 3])
      add_to_pool([5, 5], 1, 1)
      pool[1][1].should include([5, 5])
    end

    it 'preserves insertion ordering of the inner arrays' do
      add_to_pool([1, 2, 3], 1, 1)
      add_to_pool([3, 2, 1], 1, 1)
      pool.should == { 1 => { 1 => [[1, 2, 3], [3, 2, 1]] } }
    end

    it 'increments the pool count' do
      3.times { add_to_pool([1], 1, 1) }
      @pool_count.should == 3
    end
  end

  describe '#remove_keys_if_necessary' do
    before do
      pool[1][1] = []
    end

    it 'removes the index if there are no more inner arrays' do
      remove_keys_if_necessary(1, 1)
      pool[1].keys.should == []
    end

    it 'removes the error key if there are no more hashes' do
      remove_keys_if_necessary(1, 1)
      pool.keys.should == []
    end
  end

  describe '#remove_first_from_pool' do
    before do
      add_to_pool([1], 1, 1)
      add_to_pool([2], 1, 1)
      add_to_pool([3], 2, 2)
    end

    it 'removes the first inner array from the pool' do
      remove_first_from_pool
      pool[1][1].should == [[2]]
    end

    it 'decrements the pool_count' do
      remove_first_from_pool
      @pool_count.should == 2
    end

    it 'returns the removed array' do
      remove_first_from_pool.should == [1]
    end
  end


  describe '#remove_last_from_pool' do
    before do
      add_to_pool([1], 1, 1)
      add_to_pool([2], 2, 2)
      add_to_pool([3], 2, 2)
    end

    it 'removes the last inner array from the pool' do
      remove_last_from_pool
      pool[2][2].should == [[2]]
    end

    it 'decrements the pool_count' do
      remove_last_from_pool
      @pool_count.should == 2
    end

    it 'returns the removed array' do
      remove_last_from_pool.should == [3]
    end
  end

  describe '#prune_pool' do
    it 'does nothing if the pool_count is less than the PRUNE_ABOVE constant' do
      add_to_pool([1, 2, 3], 1, 1)
      before = pool
      prune_pool
      before.should == pool
    end

    it 'prunes the pool' do
      999.times { add_to_pool([1], 1, 1) }
      2.times   { add_to_pool([2], 2, 2) }
      prune_pool
      @pool_count.should == PRUNE_ABOVE
      pool[2][2].count.should == 1
    end
  end

  describe '#solved?' do
    it 'returns true if the 0 key is present' do
      add_to_pool([1], 1, 1)
      solved?.should be_false
      add_to_pool([1], 0, 1)
      solved?.should be_true
    end
  end

end
