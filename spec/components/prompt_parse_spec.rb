# frozen_string_literal: true

RSpec.describe ReduxUssd::Components::Prompt do
  let(:name) { 'A random name' }
  let(:prompt_text) { 'A random text' }

  subject do
    described_class.new(name: name,
                        text: prompt_text)
  end

  describe '#name' do
    it 'should return the name' do
      expect(subject.name).to eq(name)
    end
  end

  describe '#render' do
    it 'should return the text' do
      expect(subject.render).to eq(prompt_text)
    end
  end
end
