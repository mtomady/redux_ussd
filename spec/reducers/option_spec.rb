# frozen_string_literal: true

RSpec.describe ReduxUssd::Reducers::Option do
  subject { described_class }

  describe '.call' do
    let(:state) { { option: :some_option, some_screen: [] } }

    context 'action type is :select_option' do
      let(:action) { { type: :select_option, option: :new_option } }

      it 'should replace the option' do
        expect(subject.call(action, state)).to eq(option: :new_option, some_screen: [])
      end

      it 'should not equal the old state' do
        expect(subject.call(action, state)).not_to eq(state)
      end
    end

    context 'action type is other' do
      let(:action) { { type: :other } }

      it 'should equal the old state' do
        expect(subject.call(action, state)).to eq(state)
      end
    end
  end
end
