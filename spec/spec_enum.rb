require_relative '../my_enumerables'

describe Enumerables do
  let(:test) { [1, 2, 3] }

  describe '#myeach' do
    it 'returns enum when no  block is given' do
      expect(test.my_each).to be_an Enumerator
    end
      it 'returns self when a block is given' do
        expect(test.my_each { |i| }).to eql(test)
    end
  end
  describe '#my_each_with_index' do
    it 'returns enum when no block is given' do
        expect(test.my_each_with_index).to be_an Enumerator
    end
    it 'returns '
  end
end
