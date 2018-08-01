# frozen_string_literal: true

RSpec.describe ReduxUssd::Reducers::End do
  subject { described_class }

  describe '.call' do
    let(:state) { false }

    context 'action type is :force_end' do
      let(:action) { { type: :force_end } }

      it 'should return true' do
        expect(subject.call(action, state))
            .to eq(true)
      end

      it 'should not be equal to the old state' do
        expect(subject.call(action, state)).not_to eq(state)
      end
    end

    context 'action type is something else' do
      let(:action) { { type: :something } }

      it 'should return false' do
        expect(subject.call(action, state))
            .to eq(false)
      end

      it 'should be be equal to the old state' do
        expect(subject.call(action, state)).to eq(state)
      end
    end
  end
end
