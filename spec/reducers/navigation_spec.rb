# frozen_string_literal: true

RSpec.describe ReduxUssd::Reducers::Navigation do
  subject { described_class }

  describe '.call' do
    let(:state) { { current_screen: :old_screen_name} }

    context 'action type is :push' do
      let(:action) { { type: :push, screen: :new_screen_name } }

      it 'should update the :current_screen' do
        expect(subject.call(action, state))
          .to eq(:new_screen_name)
      end

      it 'should not equal the old state' do
        expect(subject.call(action, state))
            .not_to eq(state)
      end
    end

    context 'action type is not :push' do
      let(:action) { { type: :not_push, screen: :new_screen_name } }

      it 'should equal the old state' do
        expect(subject.call(action, state)).to eq(state)
      end
    end
  end
end
