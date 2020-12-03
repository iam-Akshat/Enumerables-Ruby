require_relative '../my_enumerables'

describe Enumerable do
  let(:test1) { [1, 3, 5] }
  let(:all_num) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }

  describe '#my_each' do
    it 'returns enum when no block given' do
      expect(test1.my_each).to be_an Enumerator
    end

    it 'returns self when a block is given' do
      expect(test1.my_each { |i| }).to eql(test1)
    end
  end

  describe '#my_each_with_index' do
    it 'returns enum when no block given' do
      expect(test1.my_each_with_index).to be_an Enumerator
    end

    it 'returns self when a block is given' do
      expect(test1.my_each_with_index { |i| }).to eql(test1)
    end
  end

  describe '#my_select' do
    it 'returns an enum when no block is given' do
      expect(all_num.my_select).to be_an Enumerator
    end

    it 'returns an array which fullfills condition given in block' do
      expect(all_num.my_select(&:even?)).to match_array [2, 4, 6, 8, 10]
    end
  end

  describe '#my_all' do
    let(:string_array) { %w[dog sheep bear] }

    it 'no block is given and array is empty returns true' do
      expect([].my_all?).to eql(true)
    end

    it 'no block is given returns false if an element is false or nil' do
      expect([nil, 14, false].my_all?).to eql(false)
    end

    it 'no block is given returns true if all elements are the same class' do
      expect([1, 3.5, 0.00001].my_all?(Numeric)).to eql(true)
    end

    it 'block is given returns true if block is true' do
      expect(string_array.my_all? { |i| i.length > 2 }).to eql(true)
    end

    it 'block is given returns false if block is false' do
      expect(string_array.my_all? { |i| i.length > 5 }).to eql(false)
    end
  end

  describe '#my_any?' do
    let(:string_array) { %w[dog sheep bear] }

    it 'if no block is given and array is empty returns false' do
      expect([].my_any?).to eql(false)
    end

    it 'if no block is given returns true if any element is not false or nil.' do
      expect([nil, 14, false].my_any?).to eql(true)
    end

    it 'if block is given returns true if any element satisfies block conditions' do
      expect(string_array.my_any? { |i| i.length > 2 }).to eql(true)
    end

    it 'if block is given returns true if any element satisfies block conditions' do
      expect(string_array.my_any? { |i| i.length > 4 }).to eql(true)
    end
  end

  describe '#my_none?' do
    let(:string_array) { %w[dog sheep bear] }

    it 'returns true if no block given and none of the elements is true ' do
      expect([nil, false].my_none?).to eql(true)
    end

    it 'returns false if no block given and any of the elements is not false' do
      expect([nil, false, 10].my_none?).to eql(false)
    end

    it 'returns true when none of the element satisfies block conditions' do
      expect(string_array.my_none? { |word| word.length == 6 }).to eql(true)
    end

    it 'returns false when any of the element satisfies block conditions' do
      expect(string_array.my_none? { |word| word.length == 5 }).to eql(false)
    end
  end

  describe '#my_count' do
    it 'returns number of elements if no argument or block given' do
      expect(all_num.my_count).to eql(10)
    end

    it 'returns number of elements that are equal to argument / no block given' do
      expect(all_num.my_count(5)).to eql(1)
    end

    it 'returns number of elements that yields true if a block is given' do
      expect(all_num.my_count { |x| x > 5 }).to eql(5)
    end
  end

  describe '#my_map' do
    it 'returns an enum when no block is given' do
      expect(all_num.my_map).to be_an(Enumerator)
    end
    it 'returns a new array with the results of running block once for every element in enum ' do
      expect(all_num.my_map { |x| x * 2 }).to match_array(all_num.map { |x| x * 2 })
    end
    it 'returns a new array with proc running when both proc and block are given' do
      proc = proc { |x| x * 3 }
      expect(all_num.my_map(proc) { |x| x * 2 }).to match_array(all_num.map { |x| x * 3 })
    end
  end

  describe '#my_inject' do
    it 'raises error when no block or argument give' do
      expect{all_num.my_inject}.to raise_error(LocalJumpError)
    end
  end
end
