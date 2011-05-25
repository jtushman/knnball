require 'minitest/autorun'
require 'knnball'

module KnnBall
  class StatTest < MiniTest::Unit::TestCase
    def test_median_index
      assert_equal(1, Stat.median_index([1] * 3))
      assert_equal(1, Stat.median_index([1] * 4))
    end
    
    def test_pivot
      data = [2,3,4,23,1,342,6,34, 2.3,4,-5,-1,2]
      assert_equal(8, Stat.pivot!(data, 2), data.inspect)
      assert_equal(4, data[8])
      data[0..8].each {|v| assert v <= 4}
      data[9..-1].each {|v| assert v > 4}
    end
    
    def test_pivot_with_comparison_block
      data = [2,3,4,23,1,342,6,34, 2.3,4,-5,-1,2]
      assert_equal(5, Stat.pivot!(data, 2){|a,b| b<=>a}, data.inspect)
      assert_equal(4, data[5])
      data[0..5].each {|v| assert v >= 4}
      data[6..-1].each {|v| assert v < 4}
    end
    
    def test_median_with_sorted_value
      data = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      assert_equal(5, Stat.median!(data), data.inspect)
      assert_equal(5, data[4])
      data[0..4].each {|v| assert v <= 5}
      data[4..8].each {|v| assert v >= 5}
    end
    
    def test_median_with_unsorted_values
      data = [1, 5, 3, 2, 7, 3, 4, 5, 6]
      assert_equal(4, Stat.median!(data), data.inspect)
      assert_equal(4, data[4], data.inspect)
      data[0..4].each {|v| assert v <= 4}
      data[4..8].each {|v| assert v >= 4}      
    end
    
    def test_median_with_hash
      data = [{:coord => [1]}, {:coord => [2]}, {:coord => [3]}]
      assert_equal({:coord => [2]}, Stat.median!(data){|a,b| a[:coord] <=> b[:coord]}, data.inspect)
    end
  end
end