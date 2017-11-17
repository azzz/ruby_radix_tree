require_relative '../../lib/radix_tree.rb'

RSpec.describe RadixTree do
  subject { described_class.new valid_values }

  let(:valid_values) do
    {
      'she' => 1,
      'sells' => 2,
      'seashells' => 3,
      'and' => 4,
      'beer' => 5,
      'by' => 6,
      'the' => 7,
      'see' => 8
    }
  end

  describe '#get' do
    it 'returns value' do
      valid_values.each do |key, expected_value|
        expect(subject.get(key)).to eql expected_value
      end
    end

    it 'returns nil for uknown value' do
      expect(subject.get('foobar')).to be_nil
    end
  end

  describe '#put' do
    it 'adds value to existing ones' do
      subject.put('foobar', 42)
      expect(subject.get('foobar')).to eql 42
    end
  end

  describe '#has?' do
    it { expect(subject.has?('see')).to be_truthy }
    it { expect(subject.has?('foobar')).to be_falsey }
  end

  describe '#items' do
    context 'with prefix' do
      it 'returns only matched items' do
        expect(subject.items('b')).to eql [['beer', 5], ['by', 6]]
      end
    end

    context 'without prefix' do
      it 'returns all items' do
        expect(subject.items).to match_array valid_values.to_a
      end
    end

    context 'with invalid prefix' do
      it { expect(subject.items('foobar')).to eql [] }
    end
  end

  describe '#to_h' do
    it { expect(subject.to_h).to eql valid_values }
  end
end
