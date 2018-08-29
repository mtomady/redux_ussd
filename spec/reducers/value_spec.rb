# frozen_string_literal: true

RSpec.describe ReduxUssd::Reducers::Value do
  subject { described_class }

  describe '.call' do

    let(:state) { {} }

    context 'action type is :set_value' do
      let(:action) { { type: :set_value, target: :some_target, value: 'input' } }

      it 'should add a new value' do
        expect(subject.call(action, state)).to eq(some_target: 'input')
      end

      it 'should not equal the initial state' do
        expect(subject.call(action, state)).not_to eq(state)
      end

      context 'with existing key' do
        let(:state) { {some_target: 'other_value'} }

        it 'should not equal the old state' do
          expect(subject.call(action, state)).not_to eq(state)
        end

        it 'should update the value for the existing key' do
          expect(subject.call(action, state)).to eq(some_target: 'input')
        end
      end
    end
  end
end
