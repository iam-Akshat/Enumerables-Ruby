require_relative '../my_enumerables'

describe Enumerable do
  let(:test_enum) { [1, 6, 8] }
  let(:test_num) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }

  describe '#myeach' do
    it 'returns enum when no  block is given' do
      expect(test_enum.my_each).to be_an Enumerator
    end
    it 'returns self when a block is given' do
      expect(test_enum.my_each { |i| }).to eql(test_enum)
    end
  end
  describe '#my_each_with_index' do
    it 'returns enum when no block is given' do
      expect(test_enum.my_each_with_index).to be_an Enumerator
    end
    it 'returns self when a block is given' do
      expect(test_enum.my_each_with_index { |i| }).to eql(test_enum)
    end
  end
  describe '#my_select' do
    it 'returns enum when no block is given' do
      expect(test_num.my_select).to be_an Enumerator
    end
    it 'return an array that fulfills all conditions when met' do
      expect(test_num.my_select(&:odd?)).to match_array [1, 3, 5, 7, 9]
    end
  end
  describe '#my_all?' do
    let(:new_array) { %w[ant bear cat] }
    it 'block is given returns true when block is true' do
      expect(new_array.my_all? { |word| word.length >= 3 }).to eql(true)
    end
    it 'if block is given returns false when block is false ' do
      expect(new_array.my_all? { |word| word.length >= 4 }).to eql(false)
    end
    it ' if no block is given returns true when array is empty' do
      expect([].my_all?).to eql(true)
    end
    it ' if no block is given returns false when element is true or nil' do
      expect([nil, true, 99].my_all?).to eql(false)
    end
    it 'returns true when all elements are numeric' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end
  end
  describe '#my_any?' do
    let(:new_array) { %w[ant bear cat] }
    it 'if no block is given and the array is empty it returns false' do
      expect([].my_any?).to eql(false)
    end
    it 'if no block is given returns true when element is true or nil' do
      expect([nil, true, 99].my_any?(Integer)).to eql(true)
    end
    it 'block is given returns true if any element satisfies block conditions' do
      expect(new_array.my_any? { |word| word.length >= 3 }).to eql(true)
    end
    it 'block is given returns true if any element satisfies block conditions' do
      expect(new_array.my_any? { |word| word.length >= 4 }).to eql(true)
    end
  end

  describe '#my_none?' do
    let(:new_array) { %w[ant bear cat] }
    it 'The method returns true if the block never returns true for all elements' do
      expect(new_array.my_none? { |word| word.length == 5 }).to eql(true)
    end
    it 'The method returns true if the block never returns true for all elements' do
      expect(new_array.my_none? { |word| word.length >= 4 }).to eql(false)
    end
    it 'If the block is not given,my_none? will return true only if none of the collection members is true' do
      expect([].my_none?).to eql(true)
    end
    it 'If the block is not given,my_none? will return true only if none of the collection members is true' do
      expect([nil].my_none?).to eql(true)
    end
  end
  describe '#my_count' do
    it 'If an argument is given, the number of items in enum that are equal to item are counted' do
      expect(test_num.my_count).to eql(9)
    end
    it 'If a block is given, it counts the number of elements yielding a true value.' do
      expect(test_num.my_count(&:even?)).to eql(4)
    end
    it 'If an argument is given, the number of items in enum that are equal to item are counted' do
      expect(test_num.my_count(2)).to eql(1)
    end
  end
  describe '#my_map' do
    it 'Returns a new array with the results of running block once for every element in enum' do
      expect((1..4).my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end
    it 'returns an enum when no block is given' do
      expect(test_num.my_map).to be_an(Enumerator)
    end
    it 'returns a new array with proc running when both proc and block are given' do
      proc = proc { |x| x * 3 }
      expect(test_num.my_map(proc) { |x| x * 2 }).to match_array(test_num.map { |x| x * 3 })
    end
  end
  describe '#my_inject' do
    it 'Combines all elements of enum by applying a binary operation' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eql(45)
    end
    it 'returns result by applying the given initial value and symbol' do
      expect(test_num.my_inject(5, :+)).to eql(50)
    end
    it 'raises error when no block or argument given' do
      expect { test_num.my_inject }.to raise_error(LocalJumpError)
    end
  end
  describe '#multiple_els' do
    it 'returns the product of all elements in the array' do
      expect(multiply_els([1, 2, 3, 4, 5])).to eql(120)
    end
  end
end
