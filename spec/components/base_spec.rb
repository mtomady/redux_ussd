# frozen_string_literal: true

require 'redux_ussd/components/base'

RSpec.describe ReduxUssd::Components::Base do
  let(:name) { 'A random name' }

  subject { described_class.new(name: name) }

  describe '#name' do
    it 'should return the name' do
      expect(subject.name).to eq(name)
    end
  end

  describe '#render' do
    it 'should a raise NotImplementedError' do
      expect { subject.render }.to raise_error(NotImplementedError)
    end
  end
end
