# frozen_string_literal: true

require 'redux_ussd/components/text'

RSpec.describe ReduxUssd::Components::Text do
  let(:name) { 'A random name' }
  let(:text) { 'A random text' }

  subject { described_class.new(name: name, text: text) }

  describe '#name' do
    it 'should return the name' do
      expect(subject.name).to eq(name)
    end
  end

  describe '#render' do
    it 'should return the text' do
      expect(subject.render).to eq(text)
    end
  end
end
