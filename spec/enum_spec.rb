require_relative '../my_enumerables'

describe Enumerable do
  let(:test1) { [1, 3, 5] }

  describe '#my_each' do
    it 'returns enum when no block given' do
      expect(test1.my_each).to be_an Enumerable
    end

    it 'returns self when a block is given' do
      expect(test1.my_each { |i| }).to eql(test1)
    end
  end
end
