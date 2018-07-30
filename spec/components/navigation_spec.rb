# frozen_string_literal: true

require 'redux_ussd/components/text'

RSpec.describe ReduxUssd::Components::Option do
  let(:name) { 'A random name' }
  let(:text) { 'A random text' }
  let(:option_index) { 2 }

  subject do
    described_class.new(name: name,
                        text: text,
                        option_index: option_index)
  end

  describe '#name' do
    it 'should return the name' do
      expect(subject.name).to eq(name)
    end
  end

  describe '#render' do
    it 'should return the text' do
      expect(subject.render).to eq('2. A random text')
    end
  end
end
