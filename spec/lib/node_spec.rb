require_relative '../../lib/node.rb'

RSpec.describe Node do
  subject { described_class.new }

  describe '#child_on' do
    context 'when node does not have any children' do
      it { expect(subject.child_on('a')).to be_nil }
    end

    context 'when node has some children' do
      let(:node) { described_class.new }

      before { subject.set_child 'a', node }

      it { expect(subject.child_on('a')).to eql node }
      it { expect(subject.child_on('b')).to be_nil }
      it { expect(subject.child_on('A')).to be_nil }
    end
  end

  describe '#set_child' do
    let(:node) { described_class.new }

    it 'sets child' do
      subject.set_child('a', node)
      expect(subject.child_on('a')).to eql node
    end
  end

  describe '#children' do
    context 'when node does not have any children' do
      it { expect(subject.children).to eql [] }
    end

    context 'when node has some children' do
      let(:node1) { described_class.new }
      let(:node2) { described_class.new }

      before do
        subject.set_child 'a', node1
        subject.set_child 'q', node2
      end

      it { expect(subject.children).to eql [['a', node1], ['q', node2]] }
    end
  end

  describe '#value' do
    it 'has default value' do
      expect(subject.value).not_to be_nil
    end

    it 'sets value' do
      subject.value = 42
      expect(subject.value).to eql 42
    end
  end

  describe '#undefined?' do
    it 'return true by default' do
      expect(subject.undefined?).to be_truthy
    end

    it do
      subject.value = 42
      expect(subject.undefined?).to be_falsey
    end
  end
end
