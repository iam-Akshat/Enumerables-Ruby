require_relative '../my_enumerables'

describe Enumerable do
  let(:test1) { [1, 3, 5] }

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
    let(:all_num) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }
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
end
